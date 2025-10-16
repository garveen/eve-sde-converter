import * as fs from 'fs';
import * as path from 'path';
import { execSync } from 'child_process';
import { ProxyAgent } from 'undici';
const AdmZip = require('adm-zip');

function getProxyAgent() {
  const proxyUrl = process.env.HTTPS_PROXY || process.env.https_proxy || process.env.HTTP_PROXY || process.env.http_proxy;
  return proxyUrl ? new ProxyAgent(proxyUrl) : undefined;
}

export interface BuildInfo {
  _key: string;
  buildNumber: number;
  releaseDate: string;
}

export async function getLatestBuildNumber(): Promise<number> {
  try {
    const response = await fetch('https://developers.eveonline.com/static-data/tranquility/latest.jsonl', {
      method: 'GET',
      signal: AbortSignal.timeout(10000),
      dispatcher: getProxyAgent() as any
    });
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }
    const data = await response.text();
    const lines = data.trim().split('\n');
    const json = JSON.parse(lines[0]) as BuildInfo;
    return json.buildNumber;
  } catch (err) {
    throw err;
  }
}



export async function downloadZip(buildNumber: number, outputPath: string): Promise<void> {
  const url = `https://developers.eveonline.com/static-data/tranquility/eve-online-static-data-${buildNumber}-jsonl.zip`;
  try {
    const response = await fetch(url, {
      dispatcher: getProxyAgent() as any
    });
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }
    const buffer = await response.arrayBuffer();
    fs.writeFileSync(outputPath, Buffer.from(buffer));
  } catch (err) {
    fs.unlink(outputPath, () => {});
    throw err;
  }
}

export function unzipFile(zipPath: string, outputDir: string): void {
  const zip = new AdmZip(zipPath);
  zip.extractAllTo(outputDir, true);
}

export function* readJsonl(filePath: string): Generator<any> {
  const content = fs.readFileSync(filePath, 'utf-8');
  const lines = content.split('\n');
  for (const line of lines) {
    const trimmed = line.trim();
    if (trimmed) {
      yield JSON.parse(trimmed);
    }
  }
}

function generateInsertValues(item: any, mapping: any, fileName: string): string[] {
  const values = mapping.fields.map((field: string | { name: string; transform: (item: any, subItem?: any, fileName?: string) => any }) => {
    let fieldName: string;
    let value: any;
    if (typeof field === 'string') {
      fieldName = field;
      if (fieldName === 'agentID' && item._key !== undefined) {
        value = item._key;
      } else if (fieldName === 'typeID' && item._key !== undefined) {
        value = item._key;
      } else {
        value = item[fieldName];
      }
    } else {
      fieldName = field.name;
      value = field.transform(item, fileName);
    }
    if (value === null || value === undefined) {
      return 'NULL';
    }
    if (typeof value === 'string') {
      return `'${value.replace(/'/g, "''").replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\t/g, '\\t')}'`;
    }
    if (typeof value === 'boolean') {
      return value ? '1' : '0';
    }
    return value.toString();
  });
  return values;
}

export function processTable(tableName: string, unzippedDir: string): string[] {
  const mapping = tableMappings[tableName];
  if (!mapping) {
    throw new Error(`No mapping for ${tableName}`);
  }
  if (tableName === 'invUniqueNames') {
    const uniqueByID = new Map<number, {itemID: number, itemName: string, groupID: number}>();
    for (const fileName of mapping.files) {
      const filePath = path.join(unzippedDir, fileName);
      if (!fs.existsSync(filePath)) {
        console.warn(`File ${filePath} does not exist, skipping.`);
        continue;
      }
      for (const item of readJsonl(filePath)) {
        const itemID = item._key;
        const itemName = item.name?.en || '';
        const groupID = item.groupID;
        if (uniqueByID.has(itemID)) {
          const existing = uniqueByID.get(itemID)!;
          if (groupID < existing.groupID) {
            uniqueByID.set(itemID, {itemID, itemName, groupID});
          }
        } else {
          uniqueByID.set(itemID, {itemID, itemName, groupID});
        }
      }
    }
    // Now deduplicate by itemName, keeping the one with smallest groupID
    const uniqueByName = new Map<string, {itemID: number, itemName: string, groupID: number}>();
    for (const entry of uniqueByID.values()) {
      const itemName = entry.itemName;
      if (uniqueByName.has(itemName)) {
        const existing = uniqueByName.get(itemName)!;
        if (entry.groupID < existing.groupID) {
          uniqueByName.set(itemName, entry);
        }
      } else {
        uniqueByName.set(itemName, entry);
      }
    }
    const inserts: string[] = [];
    for (const entry of uniqueByName.values()) {
      const values = [
        entry.itemID.toString(),
        `'${entry.itemName.replace(/'/g, "''").replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\t/g, '\\t')}'`,
        entry.groupID.toString()
      ];
      inserts.push(`INSERT INTO \`invUniqueNames\` (\`itemID\`, \`itemName\`, \`groupID\`) VALUES (${values.join(', ')});`);
    }
    return inserts;
  } else if (tableName === 'invNames') {
    const processedItemIDs = new Set<number>();
    const inserts: string[] = [];
    for (const fileName of mapping.files) {
      const filePath = path.join(unzippedDir, fileName);
      if (!fs.existsSync(filePath)) {
        console.warn(`File ${filePath} does not exist, skipping.`);
        continue;
      }
      for (const item of readJsonl(filePath)) {
        const itemID = item._key;
        if (!processedItemIDs.has(itemID)) {
          processedItemIDs.add(itemID);
          const values = generateInsertValues(item, mapping, fileName);
          inserts.push(`INSERT INTO \`${tableName}\` (${mapping.fields.map(f => {
            const fieldName = typeof f === 'string' ? f : f.name;
            return `\`${fieldName}\``;
          }).join(', ')}) VALUES (${values.join(', ')});`);
        }
      }
    }
    return inserts;
  } else if (tableName === 'certMasteries') {
    // Special handling for double-nested masteries structure
    const inserts: string[] = [];
    for (const fileName of mapping.files) {
      const filePath = path.join(unzippedDir, fileName);
      if (!fs.existsSync(filePath)) {
        console.warn(`File ${filePath} does not exist, skipping.`);
        continue;
      }
      for (const item of readJsonl(filePath)) {
        const typeID = item._key;
        if (Array.isArray(item._value)) {
          for (const masteryLevel of item._value) {
            const level = masteryLevel._key;
            if (Array.isArray(masteryLevel._value)) {
              for (const certID of masteryLevel._value) {
                inserts.push(`INSERT INTO \`certMasteries\` (\`typeID\`, \`masteryLevel\`, \`certID\`) VALUES (${typeID}, ${level}, ${certID});`);
              }
            }
          }
        }
      }
    }
    return inserts;
  } else if (tableName === 'certSkills') {
    // Special handling for skillTypes with multiple cert levels
    const inserts: string[] = [];
    const certLevels = ['basic', 'standard', 'improved', 'advanced', 'elite'];
    const certLevelInts = [0, 1, 2, 3, 4];
    for (const fileName of mapping.files) {
      const filePath = path.join(unzippedDir, fileName);
      if (!fs.existsSync(filePath)) {
        console.warn(`File ${filePath} does not exist, skipping.`);
        continue;
      }
      for (const item of readJsonl(filePath)) {
        const certID = item._key;
        if (Array.isArray(item.skillTypes)) {
          for (const skill of item.skillTypes) {
            const skillID = skill._key;
            for (let i = 0; i < certLevels.length; i++) {
              const levelName = certLevels[i];
              const levelInt = certLevelInts[i];
              const skillLevel = skill[levelName] || 0;
              inserts.push(`INSERT INTO \`certSkills\` (\`certID\`, \`skillID\`, \`certLevelInt\`, \`skillLevel\`, \`certLevelText\`) VALUES (${certID}, ${skillID}, ${levelInt}, ${skillLevel}, '${levelName}');`);
            }
          }
        }
      }
    }
    return inserts;
  } else if (tableName === 'trnTranslations') {
    // Special handling for translation data from multiple sources
    const inserts: string[] = [];
    const languages = ['de', 'en', 'es', 'fr', 'ja', 'ko', 'ru', 'zh'];
    
    for (const fileName of mapping.files) {
      const filePath = path.join(unzippedDir, fileName);
      if (!fs.existsSync(filePath)) {
        console.warn(`File ${filePath} does not exist, skipping.`);
        continue;
      }
      
      for (const item of readJsonl(filePath)) {
        const keyID = item._key;
        
        // Handle different file types
        if (fileName === 'categories.jsonl' && item.name) {
          // tcID=6: invCategories.categoryName
          for (const lang of languages) {
            if (item.name[lang]) {
              const text = item.name[lang].replace(/'/g, "''").replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\t/g, '\\t');
              inserts.push(`INSERT INTO \`trnTranslations\` (\`tcID\`, \`keyID\`, \`languageID\`, \`text\`) VALUES (6, ${keyID}, '${lang}', '${text}');`);
            }
          }
        } else if (fileName === 'groups.jsonl' && item.name) {
          // tcID=7: invGroups.groupName
          for (const lang of languages) {
            if (item.name[lang]) {
              const text = item.name[lang].replace(/'/g, "''").replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\t/g, '\\t');
              inserts.push(`INSERT INTO \`trnTranslations\` (\`tcID\`, \`keyID\`, \`languageID\`, \`text\`) VALUES (7, ${keyID}, '${lang}', '${text}');`);
            }
          }
        } else if (fileName === 'types.jsonl') {
          // tcID=8: invTypes.typeName
          if (item.name) {
            for (const lang of languages) {
              if (item.name[lang]) {
                const text = item.name[lang].replace(/'/g, "''").replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\t/g, '\\t');
                inserts.push(`INSERT INTO \`trnTranslations\` (\`tcID\`, \`keyID\`, \`languageID\`, \`text\`) VALUES (8, ${keyID}, '${lang}', '${text}');`);
              }
            }
          }
          // tcID=33: invTypes.description
          if (item.description) {
            for (const lang of languages) {
              if (item.description[lang]) {
                const text = item.description[lang].replace(/'/g, "''").replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\t/g, '\\t');
                inserts.push(`INSERT INTO \`trnTranslations\` (\`tcID\`, \`keyID\`, \`languageID\`, \`text\`) VALUES (33, ${keyID}, '${lang}', '${text}');`);
              }
            }
          }
        } else if (fileName === 'metaGroups.jsonl' && item.name) {
          // tcID=34: invMetaGroups.metaGroupName
          for (const lang of languages) {
            if (item.name[lang]) {
              const text = item.name[lang].replace(/'/g, "''").replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\t/g, '\\t');
              inserts.push(`INSERT INTO \`trnTranslations\` (\`tcID\`, \`keyID\`, \`languageID\`, \`text\`) VALUES (34, ${keyID}, '${lang}', '${text}');`);
            }
          }
          // tcID=35: invMetaGroups.description (if exists)
          if (item.description) {
            for (const lang of languages) {
              if (item.description[lang]) {
                const text = item.description[lang].replace(/'/g, "''").replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\t/g, '\\t');
                inserts.push(`INSERT INTO \`trnTranslations\` (\`tcID\`, \`keyID\`, \`languageID\`, \`text\`) VALUES (35, ${keyID}, '${lang}', '${text}');`);
              }
            }
          }
        } else if (fileName === 'marketGroups.jsonl') {
          // tcID=36: invMarketGroups.marketGroupName
          if (item.name) {
            for (const lang of languages) {
              if (item.name[lang]) {
                const text = item.name[lang].replace(/'/g, "''").replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\t/g, '\\t');
                inserts.push(`INSERT INTO \`trnTranslations\` (\`tcID\`, \`keyID\`, \`languageID\`, \`text\`) VALUES (36, ${keyID}, '${lang}', '${text}');`);
              }
            }
          }
          // tcID=37: invMarketGroups.description
          if (item.description) {
            for (const lang of languages) {
              if (item.description[lang]) {
                const text = item.description[lang].replace(/'/g, "''").replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\t/g, '\\t');
                inserts.push(`INSERT INTO \`trnTranslations\` (\`tcID\`, \`keyID\`, \`languageID\`, \`text\`) VALUES (37, ${keyID}, '${lang}', '${text}');`);
              }
            }
          }
        } else if (fileName === 'typeBonus.jsonl') {
          // tcID=1002: invTypes traits/bonus text
          // does not fit the database schema, ignore
          /*
          // const typeID = item._key;
          // Process roleBonuses
          if (Array.isArray(item.roleBonuses)) {
            const bonusID = item._key;
            for (const bonus of item.roleBonuses) {
              if (bonus.bonusText) {
                for (const lang of languages) {
                  if (bonus.bonusText[lang]) {
                    const text = bonus.bonusText[lang].replace(/'/g, "''").replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\t/g, '\\t');
                    // Use a hash or unique identifier for each bonus text
                    inserts.push(`INSERT INTO \`trnTranslations\` (\`tcID\`, \`keyID\`, \`languageID\`, \`text\`) VALUES (1002, ${bonusID}, '${lang}', '${text}');`);
                  }
                }
              }
            }
          }
          
          // Process types bonuses
          if (Array.isArray(item.types)) {
            for (const type of item.types) {
              const bonusID = type._key;
              if (Array.isArray(type._value)) {
                for (const bonus of type._value) {
                  if (bonus.bonusText) {
                    for (const lang of languages) {
                      if (bonus.bonusText[lang]) {
                        const text = bonus.bonusText[lang].replace(/'/g, "''").replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\t/g, '\\t');
                        // Use a hash or unique identifier for each bonus text
                        inserts.push(`INSERT INTO \`trnTranslations\` (\`tcID\`, \`keyID\`, \`languageID\`, \`text\`) VALUES (1002, ${bonusID}, '${lang}', '${text}');`);
                      }
                    }
                  }
                }
              }
            }
          } */
        }
      }
    }
    return inserts;
  } else {
    const inserts: string[] = [];
    for (const fileName of mapping.files) {
      const filePath = path.join(unzippedDir, fileName);
      if (!fs.existsSync(filePath)) {
        console.warn(`File ${filePath} does not exist, skipping.`);
        continue;
      }
      for (const item of readJsonl(filePath)) {
        if (mapping.filter && !mapping.filter(item)) {
          continue;
        }
        if (mapping.expand && Array.isArray(item[mapping.expand])) {
          // Expand array into multiple rows
          for (const subItem of item[mapping.expand]) {
            let values = mapping.fields.map(field => {
              let fieldName: string;
              let value: any;
              if (typeof field === 'string') {
                fieldName = field;
                if (fieldName === 'agentID' && item._key !== undefined) {
                  value = item._key;
                } else if (fieldName === 'typeID' && item._key !== undefined) {
                  value = item._key;
                } else {
                  value = item[fieldName] || subItem[fieldName];
                }
              } else {
                fieldName = field.name;
                value = field.transform(item, subItem, fileName);
              }
              if (value === null || value === undefined) {
                return 'NULL';
              }
              if (typeof value === 'string') {
                return `'${value.replace(/'/g, "''").replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\t/g, '\\t')}'`;
              }
              if (typeof value === 'boolean') {
                return value ? '1' : '0';
              }
              return value.toString();
            });
            inserts.push(`INSERT INTO \`${tableName}\` (${mapping.fields.map(f => {
              const fieldName = typeof f === 'string' ? f : f.name;
              return `\`${fieldName}\``;
            }).join(', ')}) VALUES (${values.join(', ')});`);
          }
        } else {
          // Normal processing
          const values = generateInsertValues(item, mapping, fileName);
          inserts.push(`INSERT INTO \`${tableName}\` (${mapping.fields.map(f => {
            const fieldName = typeof f === 'string' ? f : f.name;
            return `\`${fieldName}\``;
          }).join(', ')}) VALUES (${values.join(', ')});`);
        }
      }
    }
    return inserts;
  }
}

export function generateMySqlDump(schemaPath: string, unzippedDir: string, outputPath: string, tableName?: string): void {
  let dump = fs.readFileSync(schemaPath, 'utf-8');
  const lines = dump.split('\n');
  const newLines: string[] = [];

  for (let i = 0; i < lines.length; i++) {
    newLines.push(lines[i]);
    // Look for DISABLE KEYS line
    if (lines[i].includes('DISABLE KEYS')) {
      // Find the table name from previous lines
      let currentTableName = '';
      for (let j = i - 1; j >= 0; j--) {
        if (lines[j].includes('LOCK TABLES `')) {
          const match = lines[j].match(/LOCK TABLES `([^`]+)`/);
          if (match) {
            currentTableName = match[1];
            break;
          }
        }
      }
      if (currentTableName && tableMappings[currentTableName] && (!tableName || currentTableName === tableName)) {
        try {
          const inserts = processTable(currentTableName, unzippedDir);
          for (const insert of inserts) {
            newLines.push(insert);
          }
        } catch (e: any) {
          console.warn(`Skipping ${currentTableName}: ${e.message}`);
        }
      }
    }
  }

  if (!tableName || tableName === 'invFlags') {
    try {
      const invFlagsPath = path.resolve(path.dirname(schemaPath), 'invFlags.sql');
      if (fs.existsSync(invFlagsPath)) {
        console.log('Adding fixed invFlags.sql content...');
        const invFlagsContent = fs.readFileSync(invFlagsPath, 'utf-8');
        let lockTableIndex = -1;
        let unlockTableIndex = -1;
        
        for (let i = 0; i < newLines.length; i++) {
          if (newLines[i].includes('LOCK TABLES `invFlags`')) {
            lockTableIndex = i;
          } else if (lockTableIndex !== -1 && newLines[i].includes('UNLOCK TABLES')) {
            unlockTableIndex = i;
            break;
          }
        }
        
        if (lockTableIndex !== -1 && unlockTableIndex !== -1) {
          for (let i = lockTableIndex; i < unlockTableIndex; i++) {
            if (newLines[i].includes('DISABLE KEYS')) {
              const invFlagsLines = invFlagsContent.split('\n');
              newLines.splice(i + 1, 0, ...invFlagsLines);
              break;
            }
          }
        } else {
          console.warn('Could not find invFlags table position, will add invFlags content at the end of the file');
          newLines.push('\n-- Fixed invFlags data');
          newLines.push('LOCK TABLES `invFlags` WRITE;');
          newLines.push('/*!40000 ALTER TABLE `invFlags` DISABLE KEYS */;');
          newLines.push(invFlagsContent);
          newLines.push('/*!40000 ALTER TABLE `invFlags` ENABLE KEYS */;');
          newLines.push('UNLOCK TABLES;');
        }
      } else {
        console.warn('invFlags.sql file does not exist, skipping fixed invFlags data');
      }
    } catch (e: any) {
      console.warn(`Error adding invFlags.sql content: ${e.message}`);
    }
  }

  fs.writeFileSync(outputPath, newLines.join('\n'));
}

export function convertToSqlite(mysqlDumpPath: string, sqlitePath: string, mysql2sqlitePath: string): void {
  const command = `awk -f ${mysql2sqlitePath} ${mysqlDumpPath} | sqlite3 ${sqlitePath}`; // -echo -bail
  console.log(command);
  // process.exit();
  execSync(command, { stdio: 'inherit' });
}

export const tableMappings: Record<string, { files: string[]; fields: Array<string | { name: string; transform: (item: any, subItem?: any, fileName?: string) => any }>; expand?: string; filter?: (item: any) => boolean }> = {
  'agtAgents': {
    files: ['npcCharacters.jsonl'],
    fields: [
      { name: 'agentID', transform: (item) => item._key },
      { name: 'divisionID', transform: (item) => item.agent?.divisionID },
      'corporationID',
      'locationID',
      { name: 'level', transform: (item) => item.agent?.level },
      { name: 'agentTypeID', transform: (item) => item.agent?.agentTypeID },
      { name: 'isLocator', transform: (item) => item.agent?.isLocator }
    ],
    filter: (item) => item.agent != null
  },
  'agtAgentTypes': {
    files: ['agentTypes.jsonl'],
    fields: [
      { name: 'agentTypeID', transform: (item) => item._key },
      { name: 'agentType', transform: (item) => item.name }
    ]
  },
  'agtAgentsInSpace': {
    files: ['agentsInSpace.jsonl'],
    fields: ['agentID', 'dungeonID', 'solarSystemID', 'spawnPointID', 'typeID']
  },
  'invCategories': {
    files: ['categories.jsonl'],
    fields: [
      { name: 'categoryID', transform: (item) => item._key },
      { name: 'categoryName', transform: (item) => item.name?.en || '' },
      'iconID',
      'published'
    ]
  },
  'invGroups': {
    files: ['groups.jsonl'],
    fields: [
      { name: 'groupID', transform: (item) => item._key },
      'categoryID',
      { name: 'groupName', transform: (item) => item.name?.en || '' },
      'iconID',
      'useBasePrice',
      'anchored',
      'anchorable',
      'fittableNonSingleton',
      'published'
    ]
  },
  'invTypes': {
    files: ['types.jsonl'],
    fields: [
      { name: 'typeID', transform: (item) => item._key },
      'groupID',
      { name: 'typeName', transform: (item) => item.name?.en || '' },
      { name: 'description', transform: (item) => item.description?.en || '' },
      'mass',
      'volume',
      'capacity',
      'portionSize',
      'raceID',
      'basePrice',
      'published',
      'marketGroupID',
      'iconID',
      'soundID',
      'graphicID'
    ]
  },
  'chrFactions': {
    files: ['factions.jsonl'],
    fields: [
      { name: 'factionID', transform: (item) => item._key },
      { name: 'factionName', transform: (item) => item.name?.en || '' },
      { name: 'description', transform: (item) => item.description?.en || '' },
      'raceIDs',
      'solarSystemID',
      'corporationID',
      'sizeFactor',
      'stationCount',
      'stationSystemCount',
      'militiaCorporationID',
      'iconID'
    ]
  },
  'dgmTypeAttributes': {
    files: ['typeDogma.jsonl'],
    fields: [
      { name: 'typeID', transform: (item) => item._key },
      { name: 'attributeID', transform: (item, subItem) => subItem?.attributeID },
      { name: 'valueInt', transform: (item, subItem) => subItem?.value },
      { name: 'valueFloat', transform: (item, subItem) => null }
    ],
    expand: 'dogmaAttributes'
  },
  'dgmTypeEffects': {
    files: ['typeDogma.jsonl'],
    fields: [
      { name: 'typeID', transform: (item) => item._key },
      { name: 'effectID', transform: (item, subItem) => subItem?.effectID },
      { name: 'isDefault', transform: (item, subItem) => subItem?.isDefault }
    ],
    expand: 'dogmaEffects',
    filter: (item) => Array.isArray(item.dogmaEffects) && item.dogmaEffects.length > 0 && item.dogmaEffects.some((eff: any) => eff?.effectID)
  },
  'invContrabandTypes': {
    files: ['contrabandTypes.jsonl'],
    expand: 'factions',
    fields: [
      { name: 'factionID', transform: (item, subItem) => subItem._key },
      { name: 'typeID', transform: (item) => item._key },
      'standingLoss',
      'confiscateMinSec',
      'fineByValue',
      'attackMinSec'
    ]
  },
  'invControlTowerResources': {
    files: ['controlTowerResources.jsonl'],
    expand: 'resources',
    fields: [
      { name: 'controlTowerTypeID', transform: (item) => item._key },
      'resourceTypeID',
      'purpose',
      'quantity',
      'minSecurityLevel',
      'factionID'
    ]
  },
  'invMarketGroups': {
    files: ['marketGroups.jsonl'],
    fields: [
      { name: 'marketGroupID', transform: (item) => item._key },
      { name: 'parentGroupID', transform: (item) => item.parentGroupID || null },
      { name: 'marketGroupName', transform: (item) => item.name?.en || '' },
      { name: 'description', transform: (item) => item.description?.en || '' },
      'iconID',
      'hasTypes'
    ]
  },
  'invMetaGroups': {
    files: ['metaGroups.jsonl'],
    fields: [
      { name: 'metaGroupID', transform: (item) => item._key },
      { name: 'metaGroupName', transform: (item) => item.name?.en || '' },
      'iconID'
    ]
  },
  'invTypeMaterials': {
    files: ['typeMaterials.jsonl'],
    fields: [
      { name: 'typeID', transform: (item) => item._key },
      { name: 'materialTypeID', transform: (item, subItem) => subItem?.materialTypeID },
      { name: 'quantity', transform: (item, subItem) => subItem?.quantity }
    ],
    expand: 'materials'
  },
  'invMetaTypes': {
    files: ['types.jsonl'],
    fields: [
      { name: 'typeID', transform: (item) => item._key },
      { name: 'parentTypeID', transform: (item) => item.variationParentTypeID },
      { name: 'metaGroupID', transform: (item) => item.metaGroupID }
    ],
    filter: (item) => item.metaGroupID != null && item.metaGroupID !== undefined
  },
  'mapDenormalize': {
    files: ['mapSolarSystems.jsonl', 'mapConstellations.jsonl', 'mapRegions.jsonl', 'mapPlanets.jsonl', 'mapMoons.jsonl', 'mapAsteroidBelts.jsonl', 'mapStargates.jsonl', 'mapStars.jsonl'],
    fields: [
      { name: 'itemID', transform: (item) => item._key },
      { name: 'typeID', transform: (item, fileName) => {
        // Determine typeID based on file
        if (fileName === 'mapSolarSystems.jsonl') return 3;
        if (fileName === 'mapConstellations.jsonl') return 4;
        if (fileName === 'mapRegions.jsonl') return 5;
        if (fileName === 'mapPlanets.jsonl') return item.typeID;
        if (fileName === 'mapMoons.jsonl') return item.typeID;
        if (fileName === 'mapAsteroidBelts.jsonl') return item.typeID;
        if (fileName === 'mapStargates.jsonl') return item.typeID;
        if (fileName === 'mapStars.jsonl') return item.typeID;
        return null;
      }},
      { name: 'groupID', transform: (item, fileName) => {
        // Determine groupID based on file
        if (fileName === 'mapSolarSystems.jsonl') return 5;
        if (fileName === 'mapConstellations.jsonl') return 4;
        if (fileName === 'mapRegions.jsonl') return 3;
        if (fileName === 'mapPlanets.jsonl') return 7; // Assuming planet group
        if (fileName === 'mapMoons.jsonl') return 8; // Assuming moon group
        if (fileName === 'mapAsteroidBelts.jsonl') return 9; // Assuming asteroid belt group
        if (fileName === 'mapStargates.jsonl') return 10; // Assuming stargate group
        if (fileName === 'mapStars.jsonl') return 6; // Assuming star group
        return null;
      }},
      'solarSystemID',
      'constellationID',
      'regionID',
      'orbitID',
      { name: 'x', transform: (item) => item.position?.x || null },
      { name: 'y', transform: (item) => item.position?.y || null },
      { name: 'z', transform: (item) => item.position?.z || null },
      'radius',
      { name: 'itemName', transform: (item) => item.name?.en || '' },
      'security',
      'celestialIndex',
      'orbitIndex'
    ]
  },
  'invNames': {
    files: ['types.jsonl', 'ancestries.jsonl', 'bloodlines.jsonl', 'categories.jsonl', 'certificates.jsonl', 'characterAttributes.jsonl', 'corporationActivities.jsonl', 'factions.jsonl', 'groups.jsonl', 'landmarks.jsonl', 'mapConstellations.jsonl', 'mapRegions.jsonl', 'mapSolarSystems.jsonl', 'marketGroups.jsonl', 'metaGroups.jsonl', 'npcCorporationDivisions.jsonl', 'npcCorporations.jsonl', 'planetSchematics.jsonl', 'races.jsonl'],
    fields: [
      { name: 'itemID', transform: (item) => item._key },
      { name: 'itemName', transform: (item) => item.name?.en || '' }
    ]
  },
  'invUniqueNames': {
    files: ['certificates.jsonl', 'types.jsonl'],
    fields: [
      { name: 'itemID', transform: (item) => item._key },
      { name: 'itemName', transform: (item) => item.name?.en || '' },
      { name: 'groupID', transform: (item) => item.groupID }
    ]
  },
  'certCerts': {
    files: ['certificates.jsonl'],
    fields: [
      { name: 'certID', transform: (item) => item._key },
      { name: 'description', transform: (item) => item.description?.en || null },
      'groupID',
      { name: 'name', transform: (item) => item.name?.en || '' }
    ]
  },
  'chrAncestries': {
    files: ['ancestries.jsonl'],
    fields: [
      { name: 'ancestryID', transform: (item) => item._key },
      { name: 'ancestryName', transform: (item) => item.name?.en || '' },
      'bloodlineID',
      { name: 'description', transform: (item) => item.description?.en || null },
      'perception',
      'willpower',
      'charisma',
      'memory',
      'intelligence',
      'iconID',
      'shortDescription'
    ]
  },
  'chrAttributes': {
    files: ['characterAttributes.jsonl'],
    fields: [
      { name: 'attributeID', transform: (item) => item._key },
      { name: 'attributeName', transform: (item) => item.name?.en || '' },
      { name: 'description', transform: (item) => item.description || null },
      'iconID',
      'shortDescription',
      'notes'
    ]
  },
  'chrBloodlines': {
    files: ['bloodlines.jsonl'],
    fields: [
      { name: 'bloodlineID', transform: (item) => item._key },
      { name: 'bloodlineName', transform: (item) => item.name?.en || '' },
      'raceID',
      { name: 'description', transform: (item) => item.description?.en || null },
      { name: 'maleDescription', transform: (item) => null },
      { name: 'femaleDescription', transform: (item) => null },
      { name: 'shipTypeID', transform: (item) => null },
      'corporationID',
      'perception',
      'willpower',
      'charisma',
      'memory',
      'intelligence',
      'iconID',
      { name: 'shortDescription', transform: (item) => null },
      { name: 'shortMaleDescription', transform: (item) => null },
      { name: 'shortFemaleDescription', transform: (item) => null }
    ]
  },
  'chrRaces': {
    files: ['races.jsonl'],
    fields: [
      { name: 'raceID', transform: (item) => item._key },
      { name: 'raceName', transform: (item) => item.name?.en || '' },
      { name: 'description', transform: (item) => item.description?.en || null },
      'iconID',
      { name: 'shortDescription', transform: (item) => null }
    ]
  },
  'crpActivities': {
    files: ['corporationActivities.jsonl'],
    fields: [
      { name: 'activityID', transform: (item) => item._key },
      { name: 'activityName', transform: (item) => item.name?.en || '' },
      { name: 'description', transform: (item) => null }
    ]
  },
  'dgmAttributeCategories': {
    files: ['dogmaAttributeCategories.jsonl'],
    fields: [
      { name: 'categoryID', transform: (item) => item._key },
      { name: 'categoryName', transform: (item) => item.name || '' },
      { name: 'categoryDescription', transform: (item) => item.description || null }
    ]
  },
  'dgmAttributeTypes': {
    files: ['dogmaAttributes.jsonl'],
    fields: [
      'attributeID',
      { name: 'attributeName', transform: (item) => item.name || '' },
      'description',
      { name: 'iconID', transform: (item) => null },
      'defaultValue',
      'published',
      { name: 'displayName', transform: (item) => null },
      { name: 'unitID', transform: (item) => null },
      'stackable',
      'highIsGood',
      'categoryID'
    ]
  },
  'dgmEffects': {
    files: ['dogmaEffects.jsonl'],
    fields: [
      'effectID',
      'effectName',
      'effectCategory',
      { name: 'preExpression', transform: (item) => null },
      { name: 'postExpression', transform: (item) => null },
      { name: 'description', transform: (item) => null },
      'guid',
      { name: 'iconID', transform: (item) => null },
      'isOffensive',
      'isAssistance',
      'durationAttributeID',
      { name: 'trackingSpeedAttributeID', transform: (item) => null },
      'dischargeAttributeID',
      { name: 'rangeAttributeID', transform: (item) => null },
      { name: 'falloffAttributeID', transform: (item) => null },
      'disallowAutoRepeat',
      { name: 'published', transform: (item) => item.published || false },
      { name: 'displayName', transform: (item) => null },
      'isWarpSafe',
      'rangeChance'
    ]
  },
  'eveGraphics': {
    files: ['graphics.jsonl'],
    fields: [
      { name: 'graphicID', transform: (item) => item._key },
      { name: 'sofFactionName', transform: (item) => null },
      'graphicFile',
      { name: 'sofHullName', transform: (item) => null },
      { name: 'sofRaceName', transform: (item) => null },
      { name: 'description', transform: (item) => null }
    ]
  },
  'eveIcons': {
    files: ['icons.jsonl'],
    fields: [
      { name: 'iconID', transform: (item) => item._key },
      'iconFile',
      { name: 'description', transform: (item) => null }
    ]
  },
  'eveUnits': {
    files: ['dogmaUnits.jsonl'],
    fields: [
      { name: 'unitID', transform: (item) => item._key },
      { name: 'unitName', transform: (item) => item.name || '' },
      { name: 'displayName', transform: (item) => item.displayName?.en || '' },
      { name: 'description', transform: (item) => item.description?.en || null }
    ]
  },
  'crpNPCCorporations': {
    files: ['npcCorporations.jsonl'],
    fields: [
      { name: 'corporationID', transform: (item) => item._key },
      'size',
      'extent',
      { name: 'solarSystemID', transform: (item) => null },
      { name: 'investorID1', transform: (item) => null },
      { name: 'investorShares1', transform: (item) => null },
      { name: 'investorID2', transform: (item) => null },
      { name: 'investorShares2', transform: (item) => null },
      { name: 'investorID3', transform: (item) => null },
      { name: 'investorShares3', transform: (item) => null },
      { name: 'investorID4', transform: (item) => null },
      { name: 'investorShares4', transform: (item) => null },
      { name: 'friendID', transform: (item) => null },
      { name: 'enemyID', transform: (item) => null },
      { name: 'publicShares', transform: (item) => item.shares || null },
      'initialPrice',
      'minSecurity',
      { name: 'scattered', transform: (item) => null },
      { name: 'fringe', transform: (item) => null },
      { name: 'corridor', transform: (item) => null },
      { name: 'hub', transform: (item) => null },
      { name: 'border', transform: (item) => null },
      { name: 'factionID', transform: (item) => null },
      { name: 'sizeFactor', transform: (item) => null },
      { name: 'stationCount', transform: (item) => null },
      { name: 'stationSystemCount', transform: (item) => null },
      { name: 'description', transform: (item) => item.description?.en || null },
      { name: 'iconID', transform: (item) => null }
    ]
  },
  'skinLicense': {
    files: ['skinLicenses.jsonl'],
    fields: [
      'licenseTypeID',
      'duration',
      'skinID'
    ]
  },
  'skinMaterials': {
    files: ['skinMaterials.jsonl'],
    fields: [
      'skinMaterialID',
      { name: 'displayNameID', transform: (item) => null },
      'materialSetID'
    ]
  },
  'skinShip': {
    files: ['skins.jsonl'],
    fields: [
      { name: 'skinID', transform: (item) => item._key },
      { name: 'typeID', transform: (item, subItem) => subItem }
    ],
    expand: 'types'
  },
  'staStations': {
    files: ['npcStations.jsonl'],
    fields: [
      { name: 'stationID', transform: (item) => item._key },
      { name: 'security', transform: (item) => null },
      { name: 'dockingCostPerVolume', transform: (item) => null },
      { name: 'maxShipVolumeDockable', transform: (item) => null },
      { name: 'officeRentalCost', transform: (item) => null },
      'operationID',
      { name: 'stationTypeID', transform: (item) => item.typeID },
      { name: 'corporationID', transform: (item) => item.ownerID },
      'solarSystemID',
      { name: 'constellationID', transform: (item) => null },
      { name: 'regionID', transform: (item) => null },
      { name: 'stationName', transform: (item) => null },
      { name: 'x', transform: (item) => item.position?.x || null },
      { name: 'y', transform: (item) => item.position?.y || null },
      { name: 'z', transform: (item) => item.position?.z || null },
      'reprocessingEfficiency',
      'reprocessingStationsTake',
      'reprocessingHangarFlag'
    ]
  },
  'industryBlueprints': {
    files: ['blueprints.jsonl'],
    fields: [
      { name: 'typeID', transform: (item) => item.blueprintTypeID },
      'maxProductionLimit'
    ]
  },
  'planetSchematics': {
    files: ['planetSchematics.jsonl'],
    fields: [
      { name: 'schematicID', transform: (item) => item._key },
      { name: 'schematicName', transform: (item) => item.name?.en || '' },
      'cycleTime'
    ]
  },
  'planetSchematicsPinMap': {
    files: ['planetSchematics.jsonl'],
    fields: [
      { name: 'schematicID', transform: (item) => item._key },
      { name: 'pinTypeID', transform: (item, subItem) => subItem }
    ],
    expand: 'pins'
  },
  'planetSchematicsTypeMap': {
    files: ['planetSchematics.jsonl'],
    fields: [
      { name: 'schematicID', transform: (item) => item._key },
      { name: 'typeID', transform: (item, subItem) => subItem?._key },
      { name: 'quantity', transform: (item, subItem) => subItem?.quantity },
      { name: 'isInput', transform: (item, subItem) => subItem?.isInput }
    ],
    expand: 'types'
  },
  'mapConstellations': {
    files: ['mapConstellations.jsonl'],
    fields: [
      'regionID',
      { name: 'constellationID', transform: (item) => item._key },
      { name: 'constellationName', transform: (item) => item.name?.en || '' },
      { name: 'x', transform: (item) => item.position?.x || null },
      { name: 'y', transform: (item) => item.position?.y || null },
      { name: 'z', transform: (item) => item.position?.z || null },
      { name: 'xMin', transform: (item) => null },
      { name: 'xMax', transform: (item) => null },
      { name: 'yMin', transform: (item) => null },
      { name: 'yMax', transform: (item) => null },
      { name: 'zMin', transform: (item) => null },
      { name: 'zMax', transform: (item) => null },
      'factionID',
      { name: 'radius', transform: (item) => null }
    ]
  },
  'mapRegions': {
    files: ['mapRegions.jsonl'],
    fields: [
      { name: 'regionID', transform: (item) => item._key },
      { name: 'regionName', transform: (item) => item.name?.en || '' },
      { name: 'x', transform: (item) => item.position?.x || null },
      { name: 'y', transform: (item) => item.position?.y || null },
      { name: 'z', transform: (item) => item.position?.z || null },
      { name: 'xMin', transform: (item) => null },
      { name: 'xMax', transform: (item) => null },
      { name: 'yMin', transform: (item) => null },
      { name: 'yMax', transform: (item) => null },
      { name: 'zMin', transform: (item) => null },
      { name: 'zMax', transform: (item) => null },
      { name: 'factionID', transform: (item) => null },
      { name: 'nebula', transform: (item) => null },
      { name: 'radius', transform: (item) => null }
    ]
  },
  'mapSolarSystems': {
    files: ['mapSolarSystems.jsonl'],
    fields: [
      'regionID',
      'constellationID',
      { name: 'solarSystemID', transform: (item) => item._key },
      { name: 'solarSystemName', transform: (item) => item.name?.en || '' },
      { name: 'x', transform: (item) => item.position?.x || null },
      { name: 'y', transform: (item) => item.position?.y || null },
      { name: 'z', transform: (item) => item.position?.z || null },
      { name: 'xMin', transform: (item) => null },
      { name: 'xMax', transform: (item) => null },
      { name: 'yMin', transform: (item) => null },
      { name: 'yMax', transform: (item) => null },
      { name: 'zMin', transform: (item) => null },
      { name: 'zMax', transform: (item) => null },
      'luminosity',
      'border',
      { name: 'fringe', transform: (item) => item.fringe || false },
      { name: 'corridor', transform: (item) => item.corridor || false },
      { name: 'hub', transform: (item) => item.hub || false },
      'international',
      'regional',
      { name: 'constellation', transform: (item) => item.constellation || false },
      { name: 'security', transform: (item) => item.securityStatus || null },
      { name: 'factionID', transform: (item) => null },
      'radius',
      { name: 'sunTypeID', transform: (item) => item.starID || null },
      'securityClass'
    ]
  },
  'mapLandmarks': {
    files: ['landmarks.jsonl'],
    fields: [
      { name: 'landmarkID', transform: (item) => item._key },
      { name: 'landmarkName', transform: (item) => item.name?.en || '' },
      { name: 'description', transform: (item) => item.description?.en || null },
      { name: 'locationID', transform: (item) => null },
      { name: 'x', transform: (item) => item.position?.x || null },
      { name: 'y', transform: (item) => item.position?.y || null },
      { name: 'z', transform: (item) => item.position?.z || null },
      'iconID'
    ]
  },
  'certMasteries': {
    files: ['masteries.jsonl'],
    fields: [] // Custom processing in processTable function
  },
  'certSkills': {
    files: ['certificates.jsonl'],
    fields: [] // Custom processing in processTable function
  },
  'trnTranslations': {
    files: ['categories.jsonl', 'groups.jsonl', 'types.jsonl', 'metaGroups.jsonl', 'marketGroups.jsonl', 'typeBonus.jsonl'],
    fields: [] // Custom processing in processTable function
  },
};
