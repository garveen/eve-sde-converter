import knex, { Knex } from 'knex';

// ── Static data for tables that have hard-coded rows ─────────────────────────

export const invFlagsData: Array<{ flagID: number; flagName: string; flagText: string; orderID: number }> = [
  { flagID: 0, flagName: 'None', flagText: 'None', orderID: 0 },
  { flagID: 1, flagName: 'Wallet', flagText: 'Wallet', orderID: 10 },
  { flagID: 2, flagName: 'Offices', flagText: 'OfficeFolder', orderID: 0 },
  { flagID: 3, flagName: 'Wardrobe', flagText: 'Wardrobe', orderID: 0 },
  { flagID: 4, flagName: 'Hangar', flagText: 'Hangar', orderID: 30 },
  { flagID: 5, flagName: 'Cargo', flagText: 'Cargo', orderID: 3000 },
  { flagID: 6, flagName: 'OfficeImpound', flagText: 'Impounded Offices', orderID: 0 },
  { flagID: 7, flagName: 'Skill', flagText: 'Skill', orderID: 15 },
  { flagID: 8, flagName: 'Reward', flagText: 'Reward', orderID: 17 },
  { flagID: 11, flagName: 'LoSlot0', flagText: 'Low power slot 1', orderID: 0 },
  { flagID: 12, flagName: 'LoSlot1', flagText: 'Low power slot 2', orderID: 0 },
  { flagID: 13, flagName: 'LoSlot2', flagText: 'Low power slot 3', orderID: 0 },
  { flagID: 14, flagName: 'LoSlot3', flagText: 'Low power slot 4', orderID: 0 },
  { flagID: 15, flagName: 'LoSlot4', flagText: 'Low power slot 5', orderID: 0 },
  { flagID: 16, flagName: 'LoSlot5', flagText: 'Low power slot 6', orderID: 0 },
  { flagID: 17, flagName: 'LoSlot6', flagText: 'Low power slot 7', orderID: 0 },
  { flagID: 18, flagName: 'LoSlot7', flagText: 'Low power slot 8', orderID: 0 },
  { flagID: 19, flagName: 'MedSlot0', flagText: 'Medium power slot 1', orderID: 0 },
  { flagID: 20, flagName: 'MedSlot1', flagText: 'Medium power slot 2', orderID: 0 },
  { flagID: 21, flagName: 'MedSlot2', flagText: 'Medium power slot 3', orderID: 0 },
  { flagID: 22, flagName: 'MedSlot3', flagText: 'Medium power slot 4', orderID: 0 },
  { flagID: 23, flagName: 'MedSlot4', flagText: 'Medium power slot 5', orderID: 0 },
  { flagID: 24, flagName: 'MedSlot5', flagText: 'Medium power slot 6', orderID: 0 },
  { flagID: 25, flagName: 'MedSlot6', flagText: 'Medium power slot 7', orderID: 0 },
  { flagID: 26, flagName: 'MedSlot7', flagText: 'Medium power slot 8', orderID: 0 },
  { flagID: 27, flagName: 'HiSlot0', flagText: 'High power slot 1', orderID: 0 },
  { flagID: 28, flagName: 'HiSlot1', flagText: 'High power slot 2', orderID: 0 },
  { flagID: 29, flagName: 'HiSlot2', flagText: 'High power slot 3', orderID: 0 },
  { flagID: 30, flagName: 'HiSlot3', flagText: 'High power slot 4', orderID: 0 },
  { flagID: 31, flagName: 'HiSlot4', flagText: 'High power slot 5', orderID: 0 },
  { flagID: 32, flagName: 'HiSlot5', flagText: 'High power slot 6', orderID: 0 },
  { flagID: 33, flagName: 'HiSlot6', flagText: 'High power slot 7', orderID: 0 },
  { flagID: 34, flagName: 'HiSlot7', flagText: 'High power slot 8', orderID: 0 },
  { flagID: 35, flagName: 'Fixed Slot', flagText: 'Fixed Slot', orderID: 0 },
  { flagID: 36, flagName: 'AssetSafety', flagText: 'Asset Safety', orderID: 0 },
  { flagID: 56, flagName: 'Capsule', flagText: 'Capsule', orderID: 0 },
  { flagID: 57, flagName: 'Pilot', flagText: 'Pilot', orderID: 0 },
  { flagID: 61, flagName: 'Skill In Training', flagText: 'Skill in training', orderID: 0 },
  { flagID: 62, flagName: 'CorpMarket', flagText: 'Corporation Market Deliveries / Returns', orderID: 0 },
  { flagID: 63, flagName: 'Locked', flagText: 'Locked item, can not be moved unless unlocked', orderID: 0 },
  { flagID: 64, flagName: 'Unlocked', flagText: 'Unlocked item, can be moved', orderID: 0 },
  { flagID: 70, flagName: 'Office Slot 1', flagText: 'Office slot 1', orderID: 0 },
  { flagID: 71, flagName: 'Office Slot 2', flagText: 'Office slot 2', orderID: 0 },
  { flagID: 72, flagName: 'Office Slot 3', flagText: 'Office slot 3', orderID: 0 },
  { flagID: 73, flagName: 'Office Slot 4', flagText: 'Office slot 4', orderID: 0 },
  { flagID: 74, flagName: 'Office Slot 5', flagText: 'Office slot 5', orderID: 0 },
  { flagID: 75, flagName: 'Office Slot 6', flagText: 'Office slot 6', orderID: 0 },
  { flagID: 76, flagName: 'Office Slot 7', flagText: 'Office slot 7', orderID: 0 },
  { flagID: 77, flagName: 'Office Slot 8', flagText: 'Office slot 8', orderID: 0 },
  { flagID: 78, flagName: 'Office Slot 9', flagText: 'Office slot 9', orderID: 0 },
  { flagID: 79, flagName: 'Office Slot 10', flagText: 'Office slot 10', orderID: 0 },
  { flagID: 80, flagName: 'Office Slot 11', flagText: 'Office slot 11', orderID: 0 },
  { flagID: 81, flagName: 'Office Slot 12', flagText: 'Office slot 12', orderID: 0 },
  { flagID: 82, flagName: 'Office Slot 13', flagText: 'Office slot 13', orderID: 0 },
  { flagID: 83, flagName: 'Office Slot 14', flagText: 'Office slot 14', orderID: 0 },
  { flagID: 84, flagName: 'Office Slot 15', flagText: 'Office slot 15', orderID: 0 },
  { flagID: 85, flagName: 'Office Slot 16', flagText: 'Office slot 16', orderID: 0 },
  { flagID: 86, flagName: 'Bonus', flagText: 'Bonus', orderID: 0 },
  { flagID: 87, flagName: 'DroneBay', flagText: 'Drone Bay', orderID: 0 },
  { flagID: 88, flagName: 'Booster', flagText: 'Booster', orderID: 0 },
  { flagID: 89, flagName: 'Implant', flagText: 'Implant', orderID: 0 },
  { flagID: 90, flagName: 'ShipHangar', flagText: 'Ship Hangar', orderID: 0 },
  { flagID: 91, flagName: 'ShipOffline', flagText: 'Ship Offline', orderID: 0 },
  { flagID: 92, flagName: 'RigSlot0', flagText: 'Rig power slot 1', orderID: 0 },
  { flagID: 93, flagName: 'RigSlot1', flagText: 'Rig power slot 2', orderID: 0 },
  { flagID: 94, flagName: 'RigSlot2', flagText: 'Rig power slot 3', orderID: 0 },
  { flagID: 95, flagName: 'RigSlot3', flagText: 'Rig power slot 4', orderID: 0 },
  { flagID: 96, flagName: 'RigSlot4', flagText: 'Rig power slot 5', orderID: 0 },
  { flagID: 97, flagName: 'RigSlot5', flagText: 'Rig power slot 6', orderID: 0 },
  { flagID: 98, flagName: 'RigSlot6', flagText: 'Rig power slot 7', orderID: 0 },
  { flagID: 99, flagName: 'RigSlot7', flagText: 'Rig power slot 8', orderID: 0 },
  { flagID: 115, flagName: 'CorpSAG1', flagText: 'Corp Security Access Group 1', orderID: 0 },
  { flagID: 116, flagName: 'CorpSAG2', flagText: 'Corp Security Access Group 2', orderID: 0 },
  { flagID: 117, flagName: 'CorpSAG3', flagText: 'Corp Security Access Group 3', orderID: 0 },
  { flagID: 118, flagName: 'CorpSAG4', flagText: 'Corp Security Access Group 4', orderID: 0 },
  { flagID: 119, flagName: 'CorpSAG5', flagText: 'Corp Security Access Group 5', orderID: 0 },
  { flagID: 120, flagName: 'CorpSAG6', flagText: 'Corp Security Access Group 6', orderID: 0 },
  { flagID: 121, flagName: 'CorpSAG7', flagText: 'Corp Security Access Group 7', orderID: 0 },
  { flagID: 122, flagName: 'SecondaryStorage', flagText: 'Secondary Storage', orderID: 0 },
  { flagID: 125, flagName: 'SubSystem0', flagText: 'Sub system slot 0', orderID: 0 },
  { flagID: 126, flagName: 'SubSystem1', flagText: 'Sub system slot 1', orderID: 0 },
  { flagID: 127, flagName: 'SubSystem2', flagText: 'Sub system slot 2', orderID: 0 },
  { flagID: 128, flagName: 'SubSystem3', flagText: 'Sub system slot 3', orderID: 0 },
  { flagID: 129, flagName: 'SubSystem4', flagText: 'Sub system slot 4', orderID: 0 },
  { flagID: 130, flagName: 'SubSystem5', flagText: 'Sub system slot 5', orderID: 0 },
  { flagID: 131, flagName: 'SubSystem6', flagText: 'Sub system slot 6', orderID: 0 },
  { flagID: 132, flagName: 'SubSystem7', flagText: 'Sub system slot 7', orderID: 0 },
  { flagID: 133, flagName: 'SpecializedFuelBay', flagText: 'Specialized Fuel Bay', orderID: 0 },
  { flagID: 134, flagName: 'SpecializedAsteroidHold', flagText: 'Specialized Asteroid Hold', orderID: 0 },
  { flagID: 135, flagName: 'SpecializedGasHold', flagText: 'Specialized Gas Hold', orderID: 0 },
  { flagID: 136, flagName: 'SpecializedMineralHold', flagText: 'Specialized Mineral Hold', orderID: 0 },
  { flagID: 137, flagName: 'SpecializedSalvageHold', flagText: 'Specialized Salvage Hold', orderID: 0 },
  { flagID: 138, flagName: 'SpecializedShipHold', flagText: 'Specialized Ship Hold', orderID: 0 },
  { flagID: 139, flagName: 'SpecializedSmallShipHold', flagText: 'Specialized Small Ship Hold', orderID: 0 },
  { flagID: 140, flagName: 'SpecializedMediumShipHold', flagText: 'Specialized Medium Ship Hold', orderID: 0 },
  { flagID: 141, flagName: 'SpecializedLargeShipHold', flagText: 'Specialized Large Ship Hold', orderID: 0 },
  { flagID: 142, flagName: 'SpecializedIndustrialShipHold', flagText: 'Specialized Industrial Ship Hold', orderID: 0 },
  { flagID: 143, flagName: 'SpecializedAmmoHold', flagText: 'Specialized Ammo Hold', orderID: 0 },
  { flagID: 144, flagName: 'StructureActive', flagText: 'Structure Active', orderID: 0 },
  { flagID: 145, flagName: 'StructureInactive', flagText: 'Structure Inactive', orderID: 0 },
  { flagID: 146, flagName: 'JunkyardReprocessed', flagText: 'This item was put into a junkyard through reprocession.', orderID: 0 },
  { flagID: 147, flagName: 'JunkyardTrashed', flagText: 'This item was put into a junkyard through being trashed by its owner.', orderID: 0 },
  { flagID: 148, flagName: 'SpecializedCommandCenterHold', flagText: 'Specialized Command Center Hold', orderID: 0 },
  { flagID: 149, flagName: 'SpecializedPlanetaryCommoditiesHold', flagText: 'Specialized Planetary Commodities Hold', orderID: 0 },
  { flagID: 150, flagName: 'PlanetSurface', flagText: 'Planet Surface', orderID: 0 },
  { flagID: 151, flagName: 'SpecializedMaterialBay', flagText: 'Specialized Material Bay', orderID: 0 },
  { flagID: 152, flagName: 'DustCharacterDatabank', flagText: 'Dust Character Databank', orderID: 0 },
  { flagID: 153, flagName: 'DustCharacterBattle', flagText: 'Dust Character Battle', orderID: 0 },
  { flagID: 154, flagName: 'QuafeBay', flagText: 'Quafe Bay', orderID: 0 },
  { flagID: 155, flagName: 'FleetHangar', flagText: 'Fleet Hangar', orderID: 0 },
  { flagID: 156, flagName: 'HiddenModifiers', flagText: 'Hidden Modifiers', orderID: 0 },
  { flagID: 157, flagName: 'StructureOffline', flagText: 'Structure Offline', orderID: 0 },
  { flagID: 158, flagName: 'FighterBay', flagText: 'Fighter Bay', orderID: 0 },
  { flagID: 159, flagName: 'FighterTube0', flagText: 'Fighter Tube 0', orderID: 0 },
  { flagID: 160, flagName: 'FighterTube1', flagText: 'Fighter Tube 1', orderID: 0 },
  { flagID: 161, flagName: 'FighterTube2', flagText: 'Fighter Tube 2', orderID: 0 },
  { flagID: 162, flagName: 'FighterTube3', flagText: 'Fighter Tube 3', orderID: 0 },
  { flagID: 163, flagName: 'FighterTube4', flagText: 'Fighter Tube 4', orderID: 0 },
  { flagID: 164, flagName: 'StructureServiceSlot0', flagText: 'Structure service slot 1', orderID: 0 },
  { flagID: 165, flagName: 'StructureServiceSlot1', flagText: 'Structure service slot 2', orderID: 0 },
  { flagID: 166, flagName: 'StructureServiceSlot2', flagText: 'Structure service slot 3', orderID: 0 },
  { flagID: 167, flagName: 'StructureServiceSlot3', flagText: 'Structure service slot 4', orderID: 0 },
  { flagID: 168, flagName: 'StructureServiceSlot4', flagText: 'Structure service slot 5', orderID: 0 },
  { flagID: 169, flagName: 'StructureServiceSlot5', flagText: 'Structure service slot 6', orderID: 0 },
  { flagID: 170, flagName: 'StructureServiceSlot6', flagText: 'Structure service slot 7', orderID: 0 },
  { flagID: 171, flagName: 'StructureServiceSlot7', flagText: 'Structure service slot 8', orderID: 0 },
  { flagID: 172, flagName: 'StructureFuel', flagText: 'Structure Fuel', orderID: 0 },
  { flagID: 173, flagName: 'Deliveries', flagText: 'Deliveries', orderID: 0 },
  { flagID: 174, flagName: 'CrateLoot', flagText: 'Crate Loot', orderID: 0 },
  { flagID: 176, flagName: 'BoosterBay', flagText: 'Booster Hold', orderID: 0 },
  { flagID: 177, flagName: 'SubsystemBay', flagText: 'Subsystem Hold', orderID: 0 },
  { flagID: 178, flagName: 'Raffles', flagText: 'Raffles Hangar', orderID: 0 },
  { flagID: 179, flagName: 'FrigateEscapeBay', flagText: 'Frigate escape bay Hangar', orderID: 0 },
  { flagID: 180, flagName: 'StructureDeedBay', flagText: 'Structure Deed Bay', orderID: 0 },
  { flagID: 181, flagName: 'SpecializedIceHold', flagText: 'Specialized Ice Hold', orderID: 0 },
  { flagID: 182, flagName: 'SpecializedAsteroidHold', flagText: 'Specialized Asteroid Hold', orderID: 0 },
  { flagID: 183, flagName: 'MobileDepot', flagText: 'Mobile Depot', orderID: 0 },
  { flagID: 184, flagName: 'CorpProjectsHangar', flagText: 'Corporation Projects Hangar ', orderID: 0 },
  { flagID: 185, flagName: 'ColonyResourcesHold', flagText: 'Infrastructure Hold', orderID: 0 },
  { flagID: 186, flagName: 'MoonMaterialBay', flagText: 'Moon Material Bay', orderID: 0 },
  { flagID: 187, flagName: 'CapsuleerDeliveries', flagText: 'Capsuleer Deliveries', orderID: 0 },
];

export const mapUniverseData: Array<{ universeID: number; universeName: string; x: number; y: number; z: number; xMin: number; xMax: number; yMin: number; yMax: number; zMin: number; zMax: number; radius: number }> = [
  { universeID: 9, universeName: '', x: -7.8414612025763e+16, y: 4.00068382454404e+16, z: -1.87911133534779e+16, xMin: -4.49013589606488e+17, xMax: 2.92184365554962e+17, yMin: -3.13915018760047e+16, yMax: 1.11405178366885e+17, zMin: -4.33602446107849e+17, zMax: 4.71184672814804e+17, radius: 4.52393559461327e+17 },
  { universeID: 9000001, universeName: 'EVE Wormhole Universe', x: 7.70416391716947e+18, y: 1.53937198079579e+18, z: -9.51905586204134e+18, xMin: 7.25177035770814e+18, xMax: 8.1565574766308e+18, yMin: 1.08697842133446e+18, yMax: 1.99176554025711e+18, zMin: 9.06666230258001e+18, zMax: 9.97144942150266e+18, radius: 4.52393559461327e+17 },
];

export const trnTranslationColumnsData: Array<{ tcGroupID: number | null; tcID: number; tableName: string; columnName: string; masterID: string | null }> = [
  { tcGroupID: 4, tcID: 6, tableName: 'dbo.invCategories', columnName: 'categoryName', masterID: 'categoryID' },
  { tcGroupID: 5, tcID: 7, tableName: 'dbo.invGroups', columnName: 'groupName', masterID: 'groupID' },
  { tcGroupID: 5, tcID: 8, tableName: 'dbo.invTypes', columnName: 'typeName', masterID: 'typeID' },
  { tcGroupID: 5, tcID: 33, tableName: 'dbo.invTypes', columnName: 'description', masterID: 'typeID' },
  { tcGroupID: 6, tcID: 34, tableName: 'dbo.invMetaGroups', columnName: 'metaGroupName', masterID: 'metaGroupID' },
  { tcGroupID: 6, tcID: 35, tableName: 'dbo.invMetaGroups', columnName: 'description', masterID: 'metaGroupID' },
  { tcGroupID: 28, tcID: 36, tableName: 'dbo.invMarketGroups', columnName: 'marketGroupName', masterID: 'marketGroupID' },
  { tcGroupID: 28, tcID: 37, tableName: 'dbo.invMarketGroups', columnName: 'description', masterID: 'marketGroupID' },
  { tcGroupID: 85, tcID: 40, tableName: 'dbo.mapSolarSystems', columnName: 'solarSystemName', masterID: 'solarSystemID' },
  { tcGroupID: 86, tcID: 41, tableName: 'dbo.mapConstellations', columnName: 'constellationName', masterID: 'constellationID' },
  { tcGroupID: 87, tcID: 42, tableName: 'dbo.mapRegions', columnName: 'regionName', masterID: 'regionID' },
  { tcGroupID: 34, tcID: 46, tableName: 'dbo.staOperations', columnName: 'operationName', masterID: 'operationID' },
  { tcGroupID: 34, tcID: 47, tableName: 'dbo.staOperations', columnName: 'description', masterID: 'operationID' },
  { tcGroupID: 35, tcID: 48, tableName: 'dbo.staServices', columnName: 'serviceName', masterID: 'serviceID' },
  { tcGroupID: 35, tcID: 49, tableName: 'dbo.staServices', columnName: 'description', masterID: 'serviceID' },
  { tcGroupID: 41, tcID: 58, tableName: 'dbo.eveUnits', columnName: 'displayName', masterID: 'unitID' },
  { tcGroupID: 42, tcID: 59, tableName: 'dbo.dgmAttributeTypes', columnName: 'displayName', masterID: 'attributeID' },
  { tcGroupID: 46, tcID: 63, tableName: 'dbo.mapLandmarks', columnName: 'landmarkName', masterID: 'landmarkID' },
  { tcGroupID: 46, tcID: 64, tableName: 'dbo.mapLandmarks', columnName: 'description', masterID: 'landmarkID' },
  { tcGroupID: 47, tcID: 65, tableName: 'dbo.crpNPCDivisions', columnName: 'divisionName', masterID: 'divisionID' },
  { tcGroupID: 47, tcID: 66, tableName: 'dbo.crpNPCDivisions', columnName: 'leaderType', masterID: 'divisionID' },
  { tcGroupID: 53, tcID: 74, tableName: 'dbo.dgmEffects', columnName: 'displayName', masterID: 'effectID' },
  { tcGroupID: 53, tcID: 75, tableName: 'dbo.dgmEffects', columnName: 'description', masterID: 'effectID' },
  { tcGroupID: 84, tcID: 119, tableName: 'dbo.planetSchematics', columnName: 'schematicName', masterID: 'schematicID' },
  { tcGroupID: 41, tcID: 122, tableName: 'dbo.eveUnits', columnName: 'description', masterID: 'unitID' },
  { tcGroupID: 64, tcID: 138, tableName: 'dbo.crpNPCCorporations', columnName: 'description', masterID: 'corporationID' },
];

// ── Table schema definitions ──────────────────────────────────────────────────

type TableDefineFn = (table: Knex.CreateTableBuilder, isMysql: boolean) => void;

/**
 * Creates a boolean column: TINYINT(1) on MySQL (compatible with yamlloader),
 * native BOOLEAN on all other dialects (PostgreSQL, SQLite, MSSQL, CockroachDB).
 */
function boolCol(table: Knex.CreateTableBuilder, name: string, isMysql: boolean) {
  return isMysql ? table.tinyint(name, 1) : table.boolean(name);
}

/**
 * All table definitions. Each function receives the knex table builder and a
 * flag indicating whether the target dialect is MySQL (so mysql-specific
 * helpers like engine/charset can be applied).
 */
export const tableDefinitions: Record<string, TableDefineFn> = {
  agtAgentTypes: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('agentTypeID').notNullable().primary();
    table.string('agentType', 50).nullable();
  },

  agtAgents: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('agentID').notNullable().primary();
    table.integer('divisionID').nullable();
    table.integer('corporationID').nullable();
    table.integer('locationID').nullable();
    table.integer('level').nullable();
    table.integer('quality').nullable();
    table.integer('agentTypeID').nullable();
    boolCol(table, 'isLocator', isMysql).nullable();
    table.index(['corporationID'], 'ix_agtAgents_corporationID');
    table.index(['locationID'], 'ix_agtAgents_locationID');
    if (isMysql) table.check('?? in (0,1)', ['isLocator'], 'aa_isloc');
  },

  agtAgentsInSpace: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('agentID').notNullable().primary();
    table.integer('dungeonID').nullable();
    table.integer('solarSystemID').nullable();
    table.integer('spawnPointID').nullable();
    table.integer('typeID').nullable();
    table.index(['solarSystemID'], 'ix_agtAgentsInSpace_solarSystemID');
  },

  agtResearchAgents: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('agentID').notNullable();
    table.integer('typeID').notNullable();
    table.primary(['agentID', 'typeID']);
    table.index(['typeID'], 'ix_agtResearchAgents_typeID');
  },

  certCerts: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('certID').notNullable().primary();
    table.text('description').nullable();
    table.integer('groupID').nullable();
    table.string('name', 255).nullable();
  },

  certMasteries: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('typeID').nullable();
    table.integer('masteryLevel').nullable();
    table.integer('certID').nullable();
  },

  certSkills: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('certID').nullable();
    table.integer('skillID').nullable();
    table.integer('certLevelInt').nullable();
    table.integer('skillLevel').nullable();
    table.string('certLevelText', 8).nullable();
    table.index(['skillID'], 'ix_certSkills_skillID');
  },

  chrAncestries: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('ancestryID').notNullable().primary();
    table.string('ancestryName', 100).nullable();
    table.integer('bloodlineID').nullable();
    table.string('description', 1000).nullable();
    table.integer('perception').nullable();
    table.integer('willpower').nullable();
    table.integer('charisma').nullable();
    table.integer('memory').nullable();
    table.integer('intelligence').nullable();
    table.integer('iconID').nullable();
    table.string('shortDescription', 500).nullable();
  },

  chrAttributes: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('attributeID').notNullable().primary();
    table.string('attributeName', 100).nullable();
    table.string('description', 1000).nullable();
    table.integer('iconID').nullable();
    table.string('shortDescription', 500).nullable();
    table.string('notes', 500).nullable();
  },

  chrBloodlines: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('bloodlineID').notNullable().primary();
    table.string('bloodlineName', 100).nullable();
    table.integer('raceID').nullable();
    table.string('description', 1000).nullable();
    table.string('maleDescription', 1000).nullable();
    table.string('femaleDescription', 1000).nullable();
    table.integer('shipTypeID').nullable();
    table.integer('corporationID').nullable();
    table.integer('perception').nullable();
    table.integer('willpower').nullable();
    table.integer('charisma').nullable();
    table.integer('memory').nullable();
    table.integer('intelligence').nullable();
    table.integer('iconID').nullable();
    table.string('shortDescription', 500).nullable();
    table.string('shortMaleDescription', 500).nullable();
    table.string('shortFemaleDescription', 500).nullable();
  },

  chrFactions: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('factionID').notNullable().primary();
    table.string('factionName', 100).nullable();
    table.string('description', 2000).nullable();
    table.integer('raceIDs').nullable();
    table.integer('solarSystemID').nullable();
    table.integer('corporationID').nullable();
    table.specificType('sizeFactor', 'float').nullable();
    table.integer('stationCount').nullable();
    table.integer('stationSystemCount').nullable();
    table.integer('militiaCorporationID').nullable();
    table.integer('iconID').nullable();
  },

  chrRaces: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('raceID').notNullable().primary();
    table.string('raceName', 100).nullable();
    table.string('description', 1000).nullable();
    table.integer('iconID').nullable();
    table.string('shortDescription', 500).nullable();
  },

  crpActivities: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('activityID').notNullable().primary();
    table.string('activityName', 100).nullable();
    table.string('description', 1000).nullable();
  },

  crpNPCCorporations: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('corporationID').notNullable().primary();
    table.specificType('size', 'char(1)').nullable();
    table.specificType('extent', 'char(1)').nullable();
    table.integer('solarSystemID').nullable();
    table.integer('investorID1').nullable();
    table.integer('investorShares1').nullable();
    table.integer('investorID2').nullable();
    table.integer('investorShares2').nullable();
    table.integer('investorID3').nullable();
    table.integer('investorShares3').nullable();
    table.integer('investorID4').nullable();
    table.integer('investorShares4').nullable();
    table.integer('friendID').nullable();
    table.integer('enemyID').nullable();
    table.bigInteger('publicShares').nullable();
    table.integer('initialPrice').nullable();
    table.specificType('minSecurity', 'float').nullable();
    boolCol(table, 'scattered', isMysql).nullable();
    table.integer('fringe').nullable();
    table.integer('corridor').nullable();
    table.integer('hub').nullable();
    table.integer('border').nullable();
    table.integer('factionID').nullable();
    table.specificType('sizeFactor', 'float').nullable();
    table.integer('stationCount').nullable();
    table.integer('stationSystemCount').nullable();
    table.string('description', 4000).nullable();
    table.integer('iconID').nullable();
    if (isMysql) table.check('?? in (0,1)', ['scattered'], 'cnpcc_scatt');
  },

  crpNPCDivisions: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('divisionID').notNullable().primary();
    table.string('divisionName', 100).nullable();
    table.string('description', 1000).nullable();
    table.string('leaderType', 100).nullable();
  },

  dgmAttributeCategories: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('categoryID').notNullable().primary();
    table.string('categoryName', 50).nullable();
    table.string('categoryDescription', 200).nullable();
  },

  dgmAttributeTypes: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('attributeID').notNullable().primary();
    table.string('attributeName', 100).nullable();
    table.string('description', 1000).nullable();
    table.integer('iconID').nullable();
    table.specificType('defaultValue', 'float').nullable();
    boolCol(table, 'published', isMysql).nullable();
    table.string('displayName', 150).nullable();
    table.integer('unitID').nullable();
    boolCol(table, 'stackable', isMysql).nullable();
    boolCol(table, 'highIsGood', isMysql).nullable();
    table.integer('categoryID').nullable();
    if (isMysql) table.check('?? in (0,1)', ['published'], 'dat_pub');
    if (isMysql) table.check('?? in (0,1)', ['stackable'], 'dat_stack');
    if (isMysql) table.check('?? in (0,1)', ['highIsGood'], 'dat_hig');
  },

  dgmEffects: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('effectID').notNullable().primary();
    table.string('effectName', 400).nullable();
    table.integer('effectCategory').nullable();
    table.integer('preExpression').nullable();
    table.integer('postExpression').nullable();
    table.string('description', 1000).nullable();
    table.string('guid', 60).nullable();
    table.integer('iconID').nullable();
    boolCol(table, 'isOffensive', isMysql).nullable();
    boolCol(table, 'isAssistance', isMysql).nullable();
    table.integer('durationAttributeID').nullable();
    table.integer('trackingSpeedAttributeID').nullable();
    table.integer('dischargeAttributeID').nullable();
    table.integer('rangeAttributeID').nullable();
    table.integer('falloffAttributeID').nullable();
    boolCol(table, 'disallowAutoRepeat', isMysql).nullable();
    boolCol(table, 'published', isMysql).nullable();
    table.string('displayName', 100).nullable();
    boolCol(table, 'isWarpSafe', isMysql).nullable();
    boolCol(table, 'rangeChance', isMysql).nullable();
    boolCol(table, 'electronicChance', isMysql).nullable();
    boolCol(table, 'propulsionChance', isMysql).nullable();
    table.integer('distribution').nullable();
    table.string('sfxName', 20).nullable();
    table.integer('npcUsageChanceAttributeID').nullable();
    table.integer('npcActivationChanceAttributeID').nullable();
    table.integer('fittingUsageChanceAttributeID').nullable();
    table.text('modifierInfo').nullable();
    if (isMysql) table.check('?? in (0,1)', ['isOffensive'], 'de_offense');
    if (isMysql) table.check('?? in (0,1)', ['isAssistance'], 'de_assist');
    if (isMysql) table.check('?? in (0,1)', ['disallowAutoRepeat'], 'de_disallowar');
    if (isMysql) table.check('?? in (0,1)', ['published'], 'de_published');
    if (isMysql) table.check('?? in (0,1)', ['isWarpSafe'], 'de_warpsafe');
    if (isMysql) table.check('?? in (0,1)', ['rangeChance'], 'de_rangechance');
    if (isMysql) table.check('?? in (0,1)', ['electronicChance'], 'de_elecchance');
    if (isMysql) table.check('?? in (0,1)', ['propulsionChance'], 'de_propchance');
  },

  dgmTypeAttributes: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('typeID').notNullable();
    table.integer('attributeID').notNullable();
    table.bigInteger('valueInt').nullable();
    table.specificType('valueFloat', 'float').nullable();
    table.primary(['typeID', 'attributeID']);
    table.index(['attributeID'], 'ix_dgmTypeAttributes_attributeID');
  },

  dgmTypeEffects: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('typeID').notNullable();
    table.integer('effectID').notNullable();
    boolCol(table, 'isDefault', isMysql).nullable();
    table.primary(['typeID', 'effectID']);
    if (isMysql) table.check('?? in (0,1)', ['isDefault'], 'dte_default');
  },

  eveGraphics: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('graphicID').notNullable().primary();
    table.string('sofFactionName', 100).nullable();
    table.string('graphicFile', 256).nullable();
    table.string('sofHullName', 100).nullable();
    table.string('sofRaceName', 100).nullable();
    table.text('description').nullable();
  },

  eveIcons: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('iconID').notNullable().primary();
    table.string('iconFile', 500).nullable();
    table.text('description').nullable();
  },

  eveUnits: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('unitID').notNullable().primary();
    table.string('unitName', 100).nullable();
    table.string('displayName', 50).nullable();
    table.string('description', 1000).nullable();
  },

  industryActivity: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('typeID').notNullable();
    table.integer('activityID').notNullable();
    table.integer('time').nullable();
    table.primary(['typeID', 'activityID']);
    table.index(['activityID'], 'ix_industryActivity_activityID');
  },

  industryActivityMaterials: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('typeID').nullable();
    table.integer('activityID').nullable();
    table.integer('materialTypeID').nullable();
    table.integer('quantity').nullable();
    table.index(['typeID', 'activityID'], 'industryActivityMaterials_idx1');
    table.index(['typeID'], 'ix_industryActivityMaterials_typeID');
  },

  industryActivityProbabilities: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('typeID').nullable();
    table.integer('activityID').nullable();
    table.integer('productTypeID').nullable();
    table.decimal('probability', 3, 2).nullable();
    table.index(['typeID'], 'ix_industryActivityProbabilities_typeID');
    table.index(['productTypeID'], 'ix_industryActivityProbabilities_productTypeID');
  },

  industryActivityProducts: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('typeID').nullable();
    table.integer('activityID').nullable();
    table.integer('productTypeID').nullable();
    table.integer('quantity').nullable();
    table.index(['typeID'], 'ix_industryActivityProducts_typeID');
    table.index(['productTypeID'], 'ix_industryActivityProducts_productTypeID');
  },

  industryActivitySkills: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('typeID').nullable();
    table.integer('activityID').nullable();
    table.integer('skillID').nullable();
    table.integer('level').nullable();
    table.index(['typeID', 'activityID'], 'industryActivitySkills_idx1');
    table.index(['typeID'], 'ix_industryActivitySkills_typeID');
    table.index(['skillID'], 'ix_industryActivitySkills_skillID');
  },

  industryBlueprints: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('typeID').notNullable().primary();
    table.integer('maxProductionLimit').nullable();
  },

  invCategories: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('categoryID').notNullable().primary();
    table.string('categoryName', 100).nullable();
    table.integer('iconID').nullable();
    boolCol(table, 'published', isMysql).nullable();
    if (isMysql) table.check('?? in (0,1)', ['published'], 'invcat_published');
  },

  invContrabandTypes: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('factionID').notNullable();
    table.integer('typeID').notNullable();
    table.double('standingLoss').nullable();
    table.double('confiscateMinSec').nullable();
    table.double('fineByValue').nullable();
    table.double('attackMinSec').nullable();
    table.primary(['factionID', 'typeID']);
    table.index(['typeID'], 'ix_invContrabandTypes_typeID');
  },

  invControlTowerResources: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('controlTowerTypeID').notNullable();
    table.integer('resourceTypeID').notNullable();
    table.integer('purpose').nullable();
    table.integer('quantity').nullable();
    table.double('minSecurityLevel').nullable();
    table.integer('factionID').nullable();
    table.primary(['controlTowerTypeID', 'resourceTypeID']);
  },

  invFlags: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('flagID').notNullable().primary();
    table.string('flagName', 200).nullable();
    table.string('flagText', 100).nullable();
    table.integer('orderID').nullable();
  },

  invGroups: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('groupID').notNullable().primary();
    table.integer('categoryID').nullable();
    table.string('groupName', 100).nullable();
    table.integer('iconID').nullable();
    boolCol(table, 'useBasePrice', isMysql).nullable();
    boolCol(table, 'anchored', isMysql).nullable();
    boolCol(table, 'anchorable', isMysql).nullable();
    boolCol(table, 'fittableNonSingleton', isMysql).nullable();
    boolCol(table, 'published', isMysql).nullable();
    table.index(['categoryID'], 'ix_invGroups_categoryID');
    if (isMysql) table.check('?? in (0,1)', ['useBasePrice'], 'invgroup_usebaseprice');
    if (isMysql) table.check('?? in (0,1)', ['anchored'], 'invgroup_anchored');
    if (isMysql) table.check('?? in (0,1)', ['anchorable'], 'invgroup_anchorable');
    if (isMysql) table.check('?? in (0,1)', ['fittableNonSingleton'], 'invgroup_fitnonsingle');
    if (isMysql) table.check('?? in (0,1)', ['published'], 'invgroup_published');
  },

  invMarketGroups: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('marketGroupID').notNullable().primary();
    table.integer('parentGroupID').nullable();
    table.string('marketGroupName', 100).nullable();
    table.string('description', 3000).nullable();
    table.integer('iconID').nullable();
    boolCol(table, 'hasTypes', isMysql).nullable();
    if (isMysql) table.check('?? in (0,1)', ['hasTypes'], 'invmarketgroups_hastypes');
  },

  invMetaGroups: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('metaGroupID').notNullable().primary();
    table.string('metaGroupName', 100).nullable();
    table.string('description', 1000).nullable();
    table.integer('iconID').nullable();
  },

  invMetaTypes: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('typeID').notNullable().primary();
    table.integer('parentTypeID').nullable();
    table.integer('metaGroupID').nullable();
  },

  invNames: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('itemID').notNullable().primary();
    table.string('itemName', 200).notNullable();
  },

  invTraits: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.increments('traitID');
    table.integer('typeID').nullable();
    table.integer('skillID').nullable();
    table.specificType('bonus', 'float').nullable();
    table.text('bonusText').nullable();
    table.integer('unitID').nullable();
  },

  invTypeMaterials: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('typeID').notNullable();
    table.integer('materialTypeID').notNullable();
    table.integer('quantity').notNullable();
    table.primary(['typeID', 'materialTypeID']);
  },

  invTypes: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('typeID').notNullable().primary();
    table.integer('groupID').nullable();
    table.string('typeName', 255).nullable();
    table.text('description').nullable();
    table.double('mass').nullable();
    table.double('volume').nullable();
    table.double('capacity').nullable();
    table.integer('portionSize').nullable();
    table.integer('raceID').nullable();
    table.decimal('basePrice', 19, 4).nullable();
    boolCol(table, 'published', isMysql).nullable();
    table.integer('marketGroupID').nullable();
    table.integer('iconID').nullable();
    table.integer('soundID').nullable();
    table.integer('graphicID').nullable();
    table.index(['groupID'], 'ix_invTypes_groupID');
    if (isMysql) table.check('?? in (0,1)', ['published'], 'invtype_published');
  },

  invUniqueNames: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('itemID').notNullable().primary();
    table.string('itemName', 200).notNullable();
    table.integer('groupID').nullable();
    table.unique(['itemName'], { indexName: 'ix_invUniqueNames_itemName' });
    table.index(['groupID', 'itemName'], 'invUniqueNames_IX_GroupName');
  },

  invVolumes: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('typeID').notNullable().primary();
    table.bigInteger('volume').nullable();
  },

  mapCelestialGraphics: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('celestialID').notNullable().primary();
    table.integer('heightMap1').nullable();
    table.integer('heightMap2').nullable();
    table.integer('shaderPreset').nullable();
    boolCol(table, 'population', isMysql).nullable();
    if (isMysql) table.check('?? in (0,1)', ['population'], 'CONSTRAINT_1');
  },

  mapCelestialStatistics: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('celestialID').notNullable().primary();
    table.double('temperature').nullable();
    table.string('spectralClass', 10).nullable();
    table.double('luminosity').nullable();
    table.double('age').nullable();
    table.double('life').nullable();
    table.double('orbitRadius').nullable();
    table.double('eccentricity').nullable();
    table.double('massDust').nullable();
    table.double('massGas').nullable();
    boolCol(table, 'fragmented', isMysql).nullable();
    table.double('density').nullable();
    table.double('surfaceGravity').nullable();
    table.double('escapeVelocity').nullable();
    table.double('orbitPeriod').nullable();
    table.double('rotationRate').nullable();
    boolCol(table, 'locked', isMysql).nullable();
    table.double('pressure').nullable();
    table.double('radius').nullable();
    table.integer('mass').nullable();
    if (isMysql) table.check('?? in (0,1)', ['fragmented'], 'mapcelestialstats_frag');
    if (isMysql) table.check('?? in (0,1)', ['locked'], 'mapcelestialstats_locked');
  },

  mapConstellationJumps: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('fromRegionID').nullable();
    table.integer('fromConstellationID').notNullable();
    table.integer('toConstellationID').notNullable();
    table.integer('toRegionID').nullable();
    table.primary(['fromConstellationID', 'toConstellationID']);
  },

  mapConstellations: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('regionID').nullable();
    table.integer('constellationID').notNullable().primary();
    table.string('constellationName', 100).nullable();
    table.double('x').nullable();
    table.double('y').nullable();
    table.double('z').nullable();
    table.double('xMin').nullable();
    table.double('xMax').nullable();
    table.double('yMin').nullable();
    table.double('yMax').nullable();
    table.double('zMin').nullable();
    table.double('zMax').nullable();
    table.integer('factionID').nullable();
    table.specificType('radius', 'float').nullable();
  },

  mapDenormalize: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('itemID').notNullable().primary();
    table.integer('typeID').nullable();
    table.integer('groupID').nullable();
    table.integer('solarSystemID').nullable();
    table.integer('constellationID').nullable();
    table.integer('regionID').nullable();
    table.integer('orbitID').nullable();
    table.double('x').nullable();
    table.double('y').nullable();
    table.double('z').nullable();
    table.double('radius').nullable();
    table.string('itemName', 100).nullable();
    table.double('security').nullable();
    table.integer('celestialIndex').nullable();
    table.integer('orbitIndex').nullable();
    table.index(['solarSystemID'], 'ix_mapDenormalize_solarSystemID');
    table.index(['orbitID'], 'ix_mapDenormalize_orbitID');
    table.index(['groupID', 'constellationID'], 'mapDenormalize_IX_groupConstellation');
    table.index(['groupID', 'regionID'], 'mapDenormalize_IX_groupRegion');
    table.index(['regionID'], 'ix_mapDenormalize_regionID');
    table.index(['groupID', 'solarSystemID'], 'mapDenormalize_IX_groupSystem');
    table.index(['typeID'], 'ix_mapDenormalize_typeID');
    table.index(['constellationID'], 'ix_mapDenormalize_constellationID');
  },

  mapJumps: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('stargateID').notNullable().primary();
    table.integer('destinationID').nullable();
  },

  mapLandmarks: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('landmarkID').notNullable().primary();
    table.string('landmarkName', 100).nullable();
    table.text('description').nullable();
    table.integer('locationID').nullable();
    table.double('x').nullable();
    table.double('y').nullable();
    table.double('z').nullable();
    table.integer('iconID').nullable();
  },

  mapRegionJumps: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('fromRegionID').notNullable();
    table.integer('toRegionID').notNullable();
    table.primary(['fromRegionID', 'toRegionID']);
  },

  mapRegions: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('regionID').notNullable().primary();
    table.string('regionName', 100).nullable();
    table.double('x').nullable();
    table.double('y').nullable();
    table.double('z').nullable();
    table.double('xMin').nullable();
    table.double('xMax').nullable();
    table.double('yMin').nullable();
    table.double('yMax').nullable();
    table.double('zMin').nullable();
    table.double('zMax').nullable();
    table.integer('factionID').nullable();
    table.integer('nebula').nullable();
    table.specificType('radius', 'float').nullable();
  },

  mapSolarSystemJumps: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('fromRegionID').nullable();
    table.integer('fromConstellationID').nullable();
    table.integer('fromSolarSystemID').notNullable();
    table.integer('toSolarSystemID').notNullable();
    table.integer('toConstellationID').nullable();
    table.integer('toRegionID').nullable();
    table.primary(['fromSolarSystemID', 'toSolarSystemID']);
  },

  mapSolarSystems: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('regionID').nullable();
    table.integer('constellationID').nullable();
    table.integer('solarSystemID').notNullable().primary();
    table.string('solarSystemName', 100).nullable();
    table.double('x').nullable();
    table.double('y').nullable();
    table.double('z').nullable();
    table.double('xMin').nullable();
    table.double('xMax').nullable();
    table.double('yMin').nullable();
    table.double('yMax').nullable();
    table.double('zMin').nullable();
    table.double('zMax').nullable();
    table.double('luminosity').nullable();
    boolCol(table, 'border', isMysql).nullable();
    boolCol(table, 'fringe', isMysql).nullable();
    boolCol(table, 'corridor', isMysql).nullable();
    boolCol(table, 'hub', isMysql).nullable();
    boolCol(table, 'international', isMysql).nullable();
    boolCol(table, 'regional', isMysql).nullable();
    boolCol(table, 'constellation', isMysql).nullable();
    table.double('security').nullable();
    table.integer('factionID').nullable();
    table.double('radius').nullable();
    table.integer('sunTypeID').nullable();
    table.string('securityClass', 2).nullable();
    table.index(['regionID'], 'ix_mapSolarSystems_regionID');
    table.index(['security'], 'ix_mapSolarSystems_security');
    table.index(['constellationID'], 'ix_mapSolarSystems_constellationID');
    if (isMysql) table.check('?? in (0,1)', ['border'], 'mapss_border');
    if (isMysql) table.check('?? in (0,1)', ['fringe'], 'mapss_fringe');
    if (isMysql) table.check('?? in (0,1)', ['corridor'], 'mapss_corridor');
    if (isMysql) table.check('?? in (0,1)', ['hub'], 'mapss_hub');
    if (isMysql) table.check('?? in (0,1)', ['international'], 'mapss_internat');
    if (isMysql) table.check('?? in (0,1)', ['regional'], 'mapss_regional');
    if (isMysql) table.check('?? in (0,1)', ['constellation'], 'mapss_constel');
  },

  mapUniverse: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('universeID').notNullable().primary();
    table.string('universeName', 100).nullable();
    table.double('x').nullable();
    table.double('y').nullable();
    table.double('z').nullable();
    table.double('xMin').nullable();
    table.double('xMax').nullable();
    table.double('yMin').nullable();
    table.double('yMax').nullable();
    table.double('zMin').nullable();
    table.double('zMax').nullable();
    table.double('radius').nullable();
  },

  planetSchematics: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('schematicID').notNullable().primary();
    table.string('schematicName', 255).nullable();
    table.integer('cycleTime').nullable();
  },

  planetSchematicsPinMap: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('schematicID').notNullable();
    table.integer('pinTypeID').notNullable();
    table.primary(['schematicID', 'pinTypeID']);
  },

  planetSchematicsTypeMap: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('schematicID').notNullable();
    table.integer('typeID').notNullable();
    table.integer('quantity').nullable();
    boolCol(table, 'isInput', isMysql).nullable();
    table.primary(['schematicID', 'typeID']);
    if (isMysql) table.check('?? in (0,1)', ['isInput'], 'pstm_input');
  },

  skinLicense: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('licenseTypeID').notNullable().primary();
    table.integer('duration').nullable();
    table.integer('skinID').nullable();
  },

  skinMaterials: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('skinMaterialID').notNullable().primary();
    table.integer('displayNameID').nullable();
    table.integer('materialSetID').nullable();
  },

  skinShip: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('skinID').nullable();
    table.integer('typeID').nullable();
    table.index(['skinID'], 'ix_skinShip_skinID');
    table.index(['typeID'], 'ix_skinShip_typeID');
  },

  skins: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('skinID').notNullable().primary();
    table.string('internalName', 70).nullable();
    table.integer('skinMaterialID').nullable();
  },

  staOperationServices: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('operationID').notNullable();
    table.integer('serviceID').notNullable();
    table.primary(['operationID', 'serviceID']);
  },

  staOperations: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('activityID').nullable();
    table.integer('operationID').notNullable().primary();
    table.string('operationName', 100).nullable();
    table.text('description').nullable();
    table.integer('fringe').nullable();
    table.integer('corridor').nullable();
    table.integer('hub').nullable();
    table.integer('border').nullable();
    table.integer('ratio').nullable();
    table.integer('caldariStationTypeID').nullable();
    table.integer('minmatarStationTypeID').nullable();
    table.integer('amarrStationTypeID').nullable();
    table.integer('gallenteStationTypeID').nullable();
    table.integer('joveStationTypeID').nullable();
  },

  staServices: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('serviceID').notNullable().primary();
    table.string('serviceName', 100).nullable();
    table.text('description').nullable();
  },

  staStations: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.bigInteger('stationID').notNullable().primary();
    table.double('security').nullable();
    table.double('dockingCostPerVolume').nullable();
    table.double('maxShipVolumeDockable').nullable();
    table.integer('officeRentalCost').nullable();
    table.integer('operationID').nullable();
    table.integer('stationTypeID').nullable();
    table.integer('corporationID').nullable();
    table.integer('solarSystemID').nullable();
    table.integer('constellationID').nullable();
    table.integer('regionID').nullable();
    table.string('stationName', 100).nullable();
    table.double('x').nullable();
    table.double('y').nullable();
    table.double('z').nullable();
    table.double('reprocessingEfficiency').nullable();
    table.double('reprocessingStationsTake').nullable();
    table.integer('reprocessingHangarFlag').nullable();
    table.index(['stationTypeID'], 'ix_staStations_stationTypeID');
    table.index(['constellationID'], 'ix_staStations_constellationID');
    table.index(['corporationID'], 'ix_staStations_corporationID');
    table.index(['regionID'], 'ix_staStations_regionID');
    table.index(['solarSystemID'], 'ix_staStations_solarSystemID');
    table.index(['operationID'], 'ix_staStations_operationID');
  },

  translationTables: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.string('sourceTable', 200).notNullable();
    table.string('destinationTable', 200).nullable();
    table.string('translatedKey', 200).notNullable();
    table.integer('tcGroupID').nullable();
    table.integer('tcID').nullable();
    table.primary(['sourceTable', 'translatedKey']);
  },

  trnTranslationColumns: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('tcGroupID').nullable();
    table.integer('tcID').notNullable().primary();
    table.string('tableName', 256).notNullable();
    table.string('columnName', 128).notNullable();
    table.string('masterID', 128).nullable();
  },

  trnTranslationLanguages: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('numericLanguageID').notNullable().primary();
    table.string('languageID', 50).nullable();
    table.string('languageName', 200).nullable();
  },

  trnTranslations: (table, isMysql) => {
    if (isMysql) { table.engine('InnoDB'); table.charset('utf8mb4'); }
    table.integer('tcID').notNullable();
    table.integer('keyID').notNullable();
    table.string('languageID', 50).notNullable();
    table.text('text').notNullable();
    table.primary(['tcID', 'keyID', 'languageID']);
  },
};

/** Tables in the same order as the original schema.sql, for deterministic output. */
export const tableOrder: string[] = [
  'agtAgentTypes', 'agtAgents', 'agtAgentsInSpace', 'agtResearchAgents',
  'certCerts', 'certMasteries', 'certSkills',
  'chrAncestries', 'chrAttributes', 'chrBloodlines', 'chrFactions', 'chrRaces',
  'crpActivities', 'crpNPCCorporations', 'crpNPCDivisions',
  'dgmAttributeCategories', 'dgmAttributeTypes', 'dgmEffects', 'dgmTypeAttributes', 'dgmTypeEffects',
  'eveGraphics', 'eveIcons', 'eveUnits',
  'industryActivity', 'industryActivityMaterials', 'industryActivityProbabilities',
  'industryActivityProducts', 'industryActivitySkills', 'industryBlueprints',
  'invCategories', 'invContrabandTypes', 'invControlTowerResources', 'invFlags',
  'invGroups', 'invMarketGroups', 'invMetaGroups', 'invMetaTypes', 'invNames',
  'invTraits', 'invTypeMaterials', 'invTypes', 'invUniqueNames', 'invVolumes',
  'mapCelestialGraphics', 'mapCelestialStatistics', 'mapConstellationJumps',
  'mapConstellations', 'mapDenormalize', 'mapJumps', 'mapLandmarks',
  'mapRegionJumps', 'mapRegions', 'mapSolarSystemJumps', 'mapSolarSystems', 'mapUniverse',
  'planetSchematics', 'planetSchematicsPinMap', 'planetSchematicsTypeMap',
  'skinLicense', 'skinMaterials', 'skinShip', 'skins',
  'staOperationServices', 'staOperations', 'staServices', 'staStations',
  'translationTables', 'trnTranslationColumns', 'trnTranslationLanguages', 'trnTranslations',
];

// ── DDL generators ────────────────────────────────────────────────────────────

/** Ensure every SQL statement ends with a semicolon. */
function ensureSemicolons(sql: string): string {
  return sql
    .split('\n')
    .map(line => {
      const t = line.trimEnd();
      return t && !t.endsWith(';') ? t + ';' : t;
    })
    .join('\n');
}

/** Generate DROP + CREATE TABLE DDL for all tables using the MySQL dialect. */
export function generateMysqlDdl(): string {
  const k = knex({ client: 'mysql2' });
  const parts: string[] = [
    '/*!40101 SET NAMES utf8mb4 */;',
    '/*!40014 SET FOREIGN_KEY_CHECKS=0 */;',
    '',
  ];
  for (const name of tableOrder) {
    const fn = tableDefinitions[name];
    const sql = k.schema
      .dropTableIfExists(name)
      .createTable(name, (table) => fn(table, true))
      .toString();
    parts.push(ensureSemicolons(sql));
    parts.push('');
  }
  return parts.join('\n');
}

/** Generate DROP + CREATE TABLE DDL for all tables using the PostgreSQL dialect. */
export function generatePgsqlDdl(): string {
  const k = knex({ client: 'pg' });
  const parts: string[] = [
    "SET client_encoding = 'UTF8';",
    'SET standard_conforming_strings = on;',
    '',
  ];
  for (const name of tableOrder) {
    const fn = tableDefinitions[name];
    // PG uses CASCADE on drop to handle dependency ordering
    const dropSql = k.schema.dropTableIfExists(name).toString().replace(
      /drop table if exists/i,
      'DROP TABLE IF EXISTS',
    ).replace(/;?\s*$/, ' CASCADE;');
    const createSql = k.schema
      .createTable(name, (table) => fn(table, false))
      .toString();
    parts.push(ensureSemicolons(dropSql));
    parts.push(ensureSemicolons(createSql));
    parts.push('');
  }
  return parts.join('\n');
}

/** Generate DROP + CREATE TABLE DDL for all tables using the SQLite dialect. */
export function generateSqliteDdl(): string {
  const k = knex({ client: 'sqlite3', useNullAsDefault: true });
  const parts: string[] = [
    'PRAGMA foreign_keys = OFF;',
    '',
  ];
  for (const name of tableOrder) {
    const fn = tableDefinitions[name];
    const sql = k.schema
      .dropTableIfExists(name)
      .createTable(name, (table) => fn(table, false))
      .toString();
    parts.push(ensureSemicolons(sql));
    parts.push('');
  }
  return parts.join('\n');
}

/** Generate DROP + CREATE TABLE DDL for all tables using the SQL Server (MSSQL) dialect. */
export function generateMssqlDdl(): string {
  const k = knex({ client: 'mssql' });
  const parts: string[] = [
    'SET QUOTED_IDENTIFIER ON;',
    'SET ANSI_NULLS ON;',
    '',
  ];
  for (const name of tableOrder) {
    const fn = tableDefinitions[name];
    const sql = k.schema
      .dropTableIfExists(name)
      .createTable(name, (table) => fn(table, false))
      .toString();
    parts.push(ensureSemicolons(sql));
    parts.push('');
  }
  return parts.join('\n');
}



/** Generate DROP + CREATE TABLE DDL for all tables using the Oracle dialect.
 *  Uses Oracle 12c syntax (sequence + trigger for auto-increment).
 *  Note: ensure the Oracle database is created with AL32UTF8 character set
 *  (e.g. `CREATE DATABASE ... CHARACTER SET AL32UTF8`) to support full Unicode. */
export function generateOracleDdl(): string {
  // version is required by knex's Oracle dialect to compute identifier length limits
  const k = knex({ client: 'oracledb', version: '12.2' });
  const parts: string[] = [
    '-- Oracle 12c DDL',
    '-- Ensure the target database was created with: CHARACTER SET AL32UTF8',
    '',
  ];
  for (const name of tableOrder) {
    const fn = tableDefinitions[name];
    const dropSql = k.schema.dropTableIfExists(name).toString();
    const createSql = k.schema
      .createTable(name, (table) => fn(table, false))
      .toString();
    parts.push(ensureSemicolons(dropSql));
    parts.push(ensureSemicolons(createSql));
    parts.push('');
  }
  return parts.join('\n');
}
