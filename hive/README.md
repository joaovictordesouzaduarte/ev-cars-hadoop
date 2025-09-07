# Hive Commands Directory

This directory contains all Hive CLI commands organized following best practices for Hive projects.

## Directory Structure

```
hive/
├── ddl/           # Data Definition Language (CREATE, ALTER, DROP)
├── dml/           # Data Manipulation Language (INSERT, UPDATE, DELETE)
├── scripts/       # Complex scripts and procedures
├── config/        # Configuration files and properties
└── README.md      # This file
```

## Usage

### DDL Commands
- `ddl/create_tables.sql` - Create all tables
- `ddl/alter_tables.sql` - Modify table structures
- `ddl/drop_tables.sql` - Drop tables (use with caution)

### DML Commands
- `dml/load_data.sql` - Load data into tables
- `dml/insert_data.sql` - Insert new records
- `dml/update_data.sql` - Update existing records

### Scripts
- `scripts/data_processing.sql` - Complex data processing logic
- `scripts/analytics.sql` - Analytics and reporting queries

### Configuration
- `config/hive.properties` - Hive configuration properties
- `config/warehouse.properties` - Warehouse-specific settings

## Best Practices

1. **Always use IF NOT EXISTS** when creating tables
2. **Include comments** for all columns and tables
3. **Use appropriate data types** (STRING, BIGINT, DOUBLE, etc.)
4. **Specify storage format** (TEXTFILE, PARQUET, ORC)
5. **Set proper location** for tables
6. **Use partitioning** for large tables
7. **Include table properties** for optimization

## Running Commands

```bash
# Execute a single SQL file
hive -f hive/ddl/create_tables.sql

# Execute multiple files
hive -f hive/ddl/create_tables.sql -f hive/dml/load_data.sql

# Interactive mode
hive
```

## Environment Setup

Make sure you have the following environment variables set:
- `HADOOP_HOME`
- `HIVE_HOME`
- `HADOOP_CONF_DIR`
- `HIVE_CONF_DIR`
