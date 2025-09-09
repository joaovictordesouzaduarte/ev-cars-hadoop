-- =====================================================
-- Hive DDL Scripts - Criar tabelas
-- Project: EV Cars Hadoop Analysis
-- =====================================================

-- Set ev_cars como db usado
USE ev_cars;

-- =====================================================
-- Charging Stations Table
-- =====================================================

CREATE TABLE IF NOT EXISTS charging_stations (
    id BIGINT COMMENT 'Unique station identifier',
    name STRING COMMENT 'Charging station name',
    city STRING COMMENT 'City location',
    country_code STRING COMMENT 'ISO country code',
    state_province STRING COMMENT 'State or province',
    latitude DOUBLE COMMENT 'Geographic latitude',
    longitude DOUBLE COMMENT 'Geographic longitude',
    ports INT COMMENT 'Number of charging ports',
    power_kw DOUBLE COMMENT 'Power rating in kW',
    power_class STRING COMMENT 'Power class (AC_L2, AC_HIGH, DC_ULTRA, etc.)',
    is_fast_dc BOOLEAN COMMENT 'Fast DC charging capability'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES (
    'skip.header.line.count'='1',
    'created.by'='ev-cars-hadoop-project',
    'created.date'='2025-09-07'
);


-- -- =====================================================
-- -- Electric Vehicles Models Table
-- -- =====================================================
CREATE TABLE IF NOT EXISTS ev_models (
    maker STRING COMMENT 'Vehicle maker',
    model STRING COMMENT 'Vehicle model',
    market_regions STRING COMMENT 'Regions where the model is available, short name separated by ,',
    powertrain STRING COMMENT 'Powertrain type, BEV, PHEV, FCEV',
    first_year STRING COMMENT 'First year of production',
    body_style STRING COMMENT 'Body style, SUV, Sedan, etc.',
    origin_country STRING COMMENT 'Country of origin'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES (
    'skip.header.line.count'='1',
    'created.by'='ev-cars-hadoop-project',
    'created.date'='2025-09-07'
);

-- -- =====================================================
-- -- Country Summary Table
-- -- =====================================================
CREATE TABLE IF NOT EXISTS country_summary (
    country_code STRING COMMENT 'ISO country code',
    stations STRING COMMENT 'Number of stations'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES (
    'skip.header.line.count'='1',
    'created.by'='ev-cars-hadoop-project',
    'created.date'='2025-09-07'
);

-- -- =====================================================
-- -- World Summary Table
-- -- =====================================================
CREATE TABLE IF NOT EXISTS world_summary (
    country_code STRING COMMENT 'ISO country code',
    country STRING COMMENT 'Country name, ex: United States, Germany, Canada, etc',
    count INT COMMENT 'Count of EV models',
    max_power_kw_max DOUBLE COMMENT 'Max power rating in kW'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES (
    'skip.header.line.count'='1',
    'created.by'='ev-cars-hadoop-project',
    'created.date'='2025-09-07'
);

-- -- =====================================================
-- -- Show created tables
-- -- =====================================================
SHOW TABLES;
