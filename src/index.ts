#!/usr/bin/env node

import { Command } from 'commander';
import * as fs from 'fs';
import * as path from 'path';
import {
  getLatestBuildNumber,
  downloadZip,
  unzipFile,
  generateMySqlDump,
  convertToSqlite,
  generatePgsqlDump,
  generateMssqlDump,
  generateOracleDump,
  getChangeSummary
} from './processor';

const program = new Command();

program
  .name('eve-sde-converter')
  .description('A pure CLI project for EVE SDE conversion')
  .version('1.0.0');

const ALL_DIALECTS = ['mysql', 'postgres', 'sqlite', 'mssql', 'oracle'] as const;
type Dialect = typeof ALL_DIALECTS[number];

program.command('convert')
  .description('Convert EVE SDE from JSONL to SQL dumps and SQLite')
  .option('--local-zip <path>', 'Path to local ZIP file to use instead of downloading')
  .option('--unzipped-dir <path>', 'Path to unzipped directory to use instead of downloading and unzipping')
  .option('--table <tableName>', 'Process only the specified table')
  .option(
    '--dialects <list>',
    `Comma-separated list of dialects to generate (default: all). Available: ${ALL_DIALECTS.join(', ')}`,
    ALL_DIALECTS.join(','),
  )
  .action(async (options) => {
    try {
      console.log('Starting EVE SDE conversion...');

      // Parse and validate dialect selection
      const selectedDialects = new Set<Dialect>(
        (options.dialects as string)
          .split(',')
          .map((d: string) => d.trim().toLowerCase())
          .filter((d: string): d is Dialect => (ALL_DIALECTS as readonly string[]).includes(d)),
      );
      if (selectedDialects.size === 0) {
        console.error(`No valid dialects specified. Available: ${ALL_DIALECTS.join(', ')}`);
        process.exit(1);
      }
      console.log(`Generating dialects: ${[...selectedDialects].join(', ')}`);

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

      // Ensure output directory exists
      const outputDir = path.join(__dirname, '..', 'output');
      if (!fs.existsSync(outputDir)) {
        fs.mkdirSync(outputDir, { recursive: true });
      }

      // Generate MySQL dump (always required as the source for SQLite conversion)
      const mysqlDumpPath = path.join(outputDir, 'sde.sql');
      const needsMysql = selectedDialects.has('mysql') || selectedDialects.has('sqlite');
      if (needsMysql) {
        console.log('Generating MySQL dump...');
        generateMySqlDump(unzippedDir, mysqlDumpPath, options.table);
      }

      // Convert to SQLite (reads from MySQL dump)
      if (selectedDialects.has('sqlite')) {
        const sqlitePath = path.join(outputDir, 'sde.sqlite');
        if (!fs.existsSync(sqlitePath)) {
          fs.writeFileSync(sqlitePath, '');
        }
        fs.truncateSync(sqlitePath, 0);
        console.log('Converting to SQLite...');
        convertToSqlite(mysqlDumpPath, sqlitePath);
      }

      if (selectedDialects.has('postgres')) {
        const pgsqlPath = path.join(outputDir, 'sde-postgres.sql');
        console.log('Generating PostgreSQL dump...');
        generatePgsqlDump(unzippedDir, pgsqlPath, options.table);
      }

      if (selectedDialects.has('mssql')) {
        const mssqlPath = path.join(outputDir, 'sde-mssql.sql');
        console.log('Generating SQL Server dump...');
        generateMssqlDump(unzippedDir, mssqlPath, options.table);
      }

      if (selectedDialects.has('oracle')) {
        const oraclePath = path.join(outputDir, 'sde-oracle.sql');
        console.log('Generating Oracle dump...');
        generateOracleDump(unzippedDir, oraclePath, options.table);
      }

      console.log('Conversion completed successfully!');
    } catch (error) {
      if (error instanceof Error) {
        console.error('Error during conversion:', error, error.stack);
      } else {
        console.error('Unknown error during conversion:', error);
      }
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

program.command('get-change-summary <buildNumber>')
  .description('Get change summary for a specific build')
  .action(async (buildNumber: string) => {
    try {
      const buildNum = parseInt(buildNumber, 10);
      const summary = await getChangeSummary(buildNum);
      console.log(summary);
    } catch (error) {
      console.error('Error getting change summary:', error);
      process.exit(1);
    }
  });

program.parse();