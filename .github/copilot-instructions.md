# EVE SDE Converter AI Instructions

## Project Overview
Project Goal: Convert JSONL to MySQL dump files, then convert a copy to SQLite files.
The project needs to be able to complete CLI tasks in GitHub Actions.
Note: Generate MySQL version first, then generate SQLite from MySQL.

## Implementation Steps

### 1. General Reading Tools
- [ ] Get the latest build number from https://developers.eveonline.com/static-data/tranquility/latest.jsonl, format: {"_key": "sde", "buildNumber": 3049853, "releaseDate": "2025-10-07T11:13:28Z"}
- [ ] For GitHub Actions, if there is a corresponding buildNumber tag, stop execution; if not in GitHub Actions environment, or no corresponding tag, continue execution
- [ ] Download the zip file from https://developers.eveonline.com/static-data/tranquility/eve-online-static-data-{buildNumber}-jsonl.zip, extract to get a series of files under unzipped/
- [ ] Provide a method to read JSONL, use yield syntax to provide a generator, JSON decode and return values, skip empty lines

### 2. General Data Processor
- [ ] For tables in schema.sql, design multiple field mapping objects, and design appropriate processing tools, each file processed at most once, map data to schema.sql
- [ ] Specific data reference for schema.sql, see sde-20250707-TRANQUILITY.sql
- [ ] Note that these two formats may not necessarily correspond; if you find data in JSONL that cannot be found, ask how to find it

## Execution Guidelines
- Ensure the project can run CLI tasks in GitHub Actions
- The environment must have awk and sqlite3 installed
- GitHub Actions workflows should install sqlite3
- Implement using TypeScript
- Follow the project's package.json and tsconfig.json configurations
- Implement general reading tools and data processors
- Generate MySQL dump and SQLite files