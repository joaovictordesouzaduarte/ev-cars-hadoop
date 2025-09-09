-- =====================================================
-- Hive DDL Scripts - Drop Tables
-- Project: EV Cars Hadoop Analysis
-- WARNING: This will permanently delete tables and data!
-- =====================================================

-- Set database context
USE ev_cars;

-- =====================================================
-- Drop Tables (Use with caution!)
-- =====================================================

-- Drop charging stations tables
DROP TABLE IF EXISTS charging_stations;

-- Drop electric vehicles models table
DROP TABLE IF EXISTS ev_models;

-- Drop summary tables
DROP TABLE IF EXISTS country_summary;
DROP TABLE IF EXISTS world_summary;

-- =====================================================
-- Verify tables dropped
-- =====================================================
SHOW TABLES;

-- Drop database
DROP DATABASE IF EXISTS ev_cars;
