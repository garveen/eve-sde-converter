import * as fs from 'fs';
import * as path from 'path';

function commentUnprocessedTables() {
  const unprocessedTablesPath = path.join(__dirname, '..', 'unprocessed_tables.txt');
  const schemaPath = path.join(__dirname, 'schema.sql');

  // Read unprocessed tables
  const unprocessedContent = fs.readFileSync(unprocessedTablesPath, 'utf-8');
  const unprocessedTables = unprocessedContent
    .split('\n')
    .map(line => line.trim())
    .filter(line => line && !line.startsWith('#'))
    .map(line => line.replace(/^- /, ''))
    .filter(line => line && !line.includes('以下表格') && !line.includes('未被处理'));

  console.log('Unprocessed tables:', unprocessedTables);

  // Read schema.sql
  let schemaContent = fs.readFileSync(schemaPath, 'utf-8');
  const lines = schemaContent.split('\n');

  const commentedLines: string[] = [];
  let inTableBlock = false;
  let currentTable = '';
  let blockStart = -1;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];

    if (line.includes('-- Table structure for table')) {
      const match = line.match(/`([^`]+)`/);
      if (match) {
        if (inTableBlock) {
          // End previous block
          const blockEnd = i - 1;
          // Comment the block
          for (let j = blockStart; j <= blockEnd; j++) {
            if (!lines[j].trim().startsWith('--')) {
              commentedLines[j] = '-- ' + lines[j];
            } else {
              commentedLines[j] = lines[j];
            }
          }
          inTableBlock = false;
        }
        currentTable = match[1];
        if (unprocessedTables.includes(currentTable)) {
          inTableBlock = true;
          blockStart = i;
        }
      }
    }

    commentedLines.push(line);
  }

  // Handle last block if still in
  if (inTableBlock) {
    for (let j = blockStart; j < lines.length; j++) {
      if (!lines[j].trim().startsWith('--')) {
        commentedLines[j] = '-- ' + lines[j];
      } else {
        commentedLines[j] = lines[j];
      }
    }
  }

  // Write back
  const newContent = commentedLines.join('\n');
  fs.writeFileSync(schemaPath, newContent, 'utf-8');

  console.log('Commented unprocessed tables in schema.sql');
}

// Run the function
commentUnprocessedTables();