# EVE SDE Converter

A CLI tool built with TypeScript to convert EVE Online Static Data Export (SDE) from JSONL format to MySQL dump and SQLite database files. The project is designed to run in GitHub Actions.

## Features

- Fetches the latest EVE Online SDE build number from the official API
- Downloads and extracts the JSONL data archive
- Processes JSONL files and maps data to MySQL schema
- Generates MySQL dump files
- Converts MySQL dump to SQLite format using the included mysql2sqlite utility
- Supports incremental updates by checking for existing build tags in GitHub Actions

## Prerequisites

- Node.js (version 18 or higher)
- pnpm
- awk (for data processing)
- sqlite3 (for SQLite database operations)

## Installation

Clone the repository and install dependencies:

```bash
git clone https://github.com/garveen/eve-sde-converter.git
cd eve-sde-converter
pnpm install
```

## Build

Build the TypeScript project:

```bash
pnpm run build
```

## Usage

Run the converter:

```bash
pnpm run start
```

Or directly with Node.js:

```bash
node dist/index.js
```

The tool will:
1. Check for the latest SDE build number
2. Skip processing if the build is already tagged (in GitHub Actions)
3. Download and extract the JSONL archive
4. Process each JSONL file and generate MySQL dump
5. Convert the MySQL dump to SQLite format

## Output

- `sde.sql.bz2` and `sde.sql.zip`: Compressed MySQL dump files
- `sde.sqlite.zip`: Compressed SQLite database file
- `sqlite.sql`: Uncompressed SQLite SQL file

## Project Structure

- `src/`: TypeScript source files
  - `index.ts`: Main entry point
  - `processor.ts`: Data processing logic
  - `schema.sql`: MySQL schema definition
- `utils/mysql2sqlite`: Utility script to convert MySQL dump to SQLite
- `refs/`: Reference data and schema files
- `output/`: Generated output files

## Development

### GitHub Actions

The project includes GitHub Actions workflows for automated processing of SDE updates.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

See LICENSE file for details.

## Disclaimer

This project is not affiliated with CCP Games or EVE Online. EVE Online and the EVE logo are the registered trademarks of CCP hf. All rights are reserved worldwide. All other trademarks are the property of their respective owners.

## Acknowledgments

Special thanks to fuzzwork for years of providing for SDE conversion, and for this project being based on fuzzwork's data structure.