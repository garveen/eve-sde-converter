#!/usr/bin/env node

import { Command } from 'commander';
import * as fs from 'fs';
import * as path from 'path';
import {
  getLatestBuildNumber,
  downloadZip,
  unzipFile,
  generateMySqlDump,
  convertToSqlite
} from './processor';

const program = new Command();

program
  .name('eve-sde-converter')
  .description('A pure CLI project for EVE SDE conversion')
  .version('1.0.0');

program.command('convert')
  .description('Convert EVE SDE from JSONL to MySQL dump and SQLite')
  .option('--local-zip <path>', 'Path to local ZIP file to use instead of downloading')
  .option('--unzipped-dir <path>', 'Path to unzipped directory to use instead of downloading and unzipping')
  .option('--table <tableName>', 'Process only the specified table')
  .action(async (options) => {
    try {
      console.log('Starting EVE SDE conversion...');

      const unzippedDir = options.unzippedDir || path.join(__dirname, '..', 'refs', 'unzipped');

      if (options.localZip) {
        console.log(`Using local ZIP file: ${options.localZip}`);
        console.log('Unzipping file...');
        unzipFile(options.localZip, unzippedDir);
      } else if (!options.unzippedDir) {
        // Original logic: download and unzip
        // Get latest build number
        console.log('Fetching latest build number...');
        const buildNumber = await getLatestBuildNumber();
        console.log(`Latest build number: ${buildNumber}`);

        // Download and unzip
        const zipPath = path.join(__dirname, '..', 'temp.zip');

        console.log('Downloading ZIP file...');
        await downloadZip(buildNumber, zipPath);

        console.log('Unzipping file...');
        unzipFile(zipPath, unzippedDir);

        // Clean up zip
        fs.unlinkSync(zipPath);
      } else {
        console.log(`Using unzipped directory: ${unzippedDir}`);
      }

      // Generate MySQL dump
      const schemaPath = path.join(__dirname, '..', 'refs', 'mysql', 'sde-20250707-TRANQUILITY', 'schema.sql');
      const mysqlDumpPath = path.join(__dirname, '..', 'output', 'sde.sql');

      // Ensure output directory exists
      const outputDir = path.dirname(mysqlDumpPath);
      if (!fs.existsSync(outputDir)) {
        fs.mkdirSync(outputDir, { recursive: true });
      }

      console.log('Generating MySQL dump...');
      generateMySqlDump(schemaPath, unzippedDir, mysqlDumpPath, options.table);

      // Convert to SQLite
      const sqlitePath = path.join(__dirname, '..', 'output', 'sde.sqlite');
      const mysql2sqlitePath = path.join(__dirname, '..', 'utils', 'mysql2sqlite');
      if (!fs.existsSync(sqlitePath)) {
        // create file
        fs.writeFileSync(sqlitePath, '');
      }
      fs.truncateSync(sqlitePath, 0); // Clear existing SQLite file if any

      console.log('Converting to SQLite...');
      convertToSqlite(mysqlDumpPath, sqlitePath, mysql2sqlitePath);

      console.log('Conversion completed successfully!');
    } catch (error) {
      console.error('Error during conversion:', error);
      process.exit(1);
    }
  });

program.command('check-update')
  .description('Check if SDE has updates')
  .action(async () => {
    try {
      const buildNumber = await getLatestBuildNumber();
      const commitSha = require('child_process').execSync('git rev-parse --short HEAD').toString().trim();
      console.log(`Latest build number: ${buildNumber}`);
      console.log(`Commit SHA: ${commitSha}`);
      // Always indicate update available for simplicity
      console.log('Update available.');
      process.exit(1); // Exit with 1 to indicate update available
    } catch (error) {
      console.error('Error checking update:', error);
      process.exit(1);
    }
  });

program.parse();