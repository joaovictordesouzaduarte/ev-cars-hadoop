-- =====================================================
-- Hive DML Scripts - Load Data
-- Project: EV Cars Hadoop Analysis
-- =====================================================

-- Set database context
USE ev_cars;

-- =====================================================
-- Load Charging Stations Data
-- =====================================================

-- Load data into TEXTFILE table

-- O comando LOAD DATA deve ser executado separadamente:
LOAD DATA INPATH '/user/hadoop/warehouse/input/processed/charging_stations_2025_world.csv' 
OVERWRITE INTO TABLE charging_stations;

-- =====================================================
-- Load Electric Vehicles Models Data
-- =====================================================
LOAD DATA INPATH '/user/hadoop/warehouse/input/processed/ev_models_2025.csv'
OVERWRITE INTO TABLE ev_models;

-- =====================================================
-- Load Country Summary Data
-- =====================================================
LOAD DATA INPATH '/user/hadoop/warehouse/input/processed/country_summary_2025.csv'
OVERWRITE INTO TABLE country_summary;

-- =====================================================
-- Load World Summary Data
-- =====================================================
LOAD DATA INPATH '/user/hadoop/warehouse/input/processed/world_summary_2025.csv'
OVERWRITE INTO TABLE world_summary;

-- =====================================================
-- Verify data loading
-- =====================================================

-- Check row counts
-- SELECT 'charging_stations' as table_name, COUNT(*) as row_count FROM charging_stations
-- UNION ALL
-- SELECT 'ev_models' as table_name, COUNT(*) as row_count FROM ev_models
-- UNION ALL
-- SELECT 'country_summary' as table_name, COUNT(*) as row_count FROM country_summary
-- UNION ALL
-- SELECT 'world_summary' as table_name, COUNT(*) as row_count FROM world_summary;

-- -- Sample data from charging stations
-- SELECT * FROM charging_stations LIMIT 10;
