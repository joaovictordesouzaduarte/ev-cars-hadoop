-- =====================================================
-- Hive Analytics Scripts
-- Project: EV Cars Hadoop Analysis
-- =====================================================

-- Set database context
USE ev_cars;

-- =====================================================
-- The largest countries by number of charging stations
-- =====================================================

-- =====================================================
-- Add more questions here for me to answer:
-- =====================================================

-- 1. Country with the highest number of charging stations
SELECT 
    country_code,
    COUNT(*) as total_stations
FROM charging_stations
GROUP BY country_code
ORDER BY total_stations DESC
LIMIT 20;

-- 2. Who are the top 10 electric vehicle manufacturers by number of available models?
-- 3. What is the average power (kW) of charging stations by country, considering countries with more than 1000 stations?
SELECT 
    world_summary.country,
    AVG(power_kw) as avg_power_kw
FROM charging_stations
left join world_summary on charging_stations.country_code = world_summary.country_code
WHERE world_summary.count >= 1000
GROUP BY world_summary.country
ORDER BY avg_power_kw DESC
LIMIT 10;

-- 4. What is the number of electric vehicle models per manufacturer in 2025?
SELECT 
    maker,
    COUNT(*) as total_models
FROM ev_models
GROUP BY maker
ORDER BY total_models DESC
LIMIT 10;

-- 5. What is the number of electric models by body style in 2025?
SELECT 
    body_style,
    COUNT(*) as total_models
FROM ev_models
GROUP BY body_style
ORDER BY total_models DESC
LIMIT 10;

-- 6. Top 15 cities with the most charging stations
SELECT 
    city,
    COUNT(*) as total_stations
FROM charging_stations
GROUP BY city
ORDER BY total_stations DESC
LIMIT 15;

-- 7. What is the distribution of powertrain types (BEV, PHEV, FCEV) by market region in 2025?
SELECT 
    market_regions,
    powertrain,
    COUNT(*) as total_models
FROM ev_models
GROUP BY market_regions, powertrain
ORDER BY total_models DESC
LIMIT 10;

-- 8. Which cities have the most fast charging stations in the world?
SELECT 
    city,
    sum(is_fast_dc) as total_stations
FROM charging_stations
GROUP BY city
ORDER BY total_stations DESC
LIMIT 10;

-- 10. Which countries have the greatest diversity of electric vehicle models?

-- 11. What is the relationship between the number of stations and the number of available models by country?
SELECT 
    world_summary.country,
    COUNT(*) as total_models
FROM ev_models
left join world_summary on ev_models.origin_country = world_summary.country_code
GROUP BY world_summary.country
ORDER BY total_models DESC
LIMIT 10;
-- 9. What are the most common power classes in charging stations?
-- 12. What are the most common power classes in charging stations?































-- -- =====================================================
-- -- Power Class Distribution
-- -- =====================================================
-- SELECT 
--     power_class,
--     COUNT(*) as station_count,
--     SUM(ports) as total_ports,
--     AVG(power_kw) as avg_power_kw,
--     ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
-- FROM charging_stations_parquet
-- WHERE power_class IS NOT NULL
-- GROUP BY power_class
-- ORDER BY station_count DESC;

-- -- =====================================================
-- -- Geographic Analysis by Latitude/Longitude
-- -- =====================================================
-- SELECT 
--     CASE 
--         WHEN latitude BETWEEN -90 AND -60 THEN 'South Polar'
--         WHEN latitude BETWEEN -60 AND -30 THEN 'South Temperate'
--         WHEN latitude BETWEEN -30 AND 0 THEN 'South Tropical'
--         WHEN latitude BETWEEN 0 AND 30 THEN 'North Tropical'
--         WHEN latitude BETWEEN 30 AND 60 THEN 'North Temperate'
--         WHEN latitude BETWEEN 60 AND 90 THEN 'North Polar'
--         ELSE 'Unknown'
--     END as climate_zone,
--     COUNT(*) as station_count,
--     AVG(power_kw) as avg_power_kw,
--     SUM(ports) as total_ports
-- FROM charging_stations_parquet
-- WHERE latitude IS NOT NULL AND longitude IS NOT NULL
-- GROUP BY 
--     CASE 
--         WHEN latitude BETWEEN -90 AND -60 THEN 'South Polar'
--         WHEN latitude BETWEEN -60 AND -30 THEN 'South Temperate'
--         WHEN latitude BETWEEN -30 AND 0 THEN 'South Tropical'
--         WHEN latitude BETWEEN 0 AND 30 THEN 'North Tropical'
--         WHEN latitude BETWEEN 30 AND 60 THEN 'North Temperate'
--         WHEN latitude BETWEEN 60 AND 90 THEN 'North Polar'
--         ELSE 'Unknown'
--     END
-- ORDER BY station_count DESC;

-- -- =====================================================
-- -- Fast DC Charging Analysis
-- -- =====================================================
-- SELECT 
--     country_code,
--     COUNT(*) as total_stations,
--     SUM(CASE WHEN is_fast_dc = true THEN 1 ELSE 0 END) as fast_dc_stations,
--     ROUND(SUM(CASE WHEN is_fast_dc = true THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as fast_dc_percentage,
--     AVG(CASE WHEN is_fast_dc = true THEN power_kw END) as avg_fast_dc_power
-- FROM charging_stations_parquet
-- GROUP BY country_code
-- HAVING COUNT(*) >= 100  -- Only countries with significant station count
-- ORDER BY fast_dc_percentage DESC
-- LIMIT 15;

-- -- =====================================================
-- -- Station Density by City
-- -- =====================================================
-- SELECT 
--     city,
--     country_code,
--     COUNT(*) as station_count,
--     SUM(ports) as total_ports,
--     AVG(power_kw) as avg_power_kw
-- FROM charging_stations_parquet
-- WHERE city IS NOT NULL AND city != ''
-- GROUP BY city, country_code
-- HAVING COUNT(*) >= 10  -- Cities with at least 10 stations
-- ORDER BY station_count DESC
-- LIMIT 20;

-- -- =====================================================
-- -- Power Rating Distribution
-- -- =====================================================
-- SELECT 
--     CASE 
--         WHEN power_kw < 10 THEN 'Low (< 10kW)'
--         WHEN power_kw BETWEEN 10 AND 50 THEN 'Medium (10-50kW)'
--         WHEN power_kw BETWEEN 50 AND 150 THEN 'High (50-150kW)'
--         WHEN power_kw > 150 THEN 'Ultra High (> 150kW)'
--         ELSE 'Unknown'
--     END as power_category,
--     COUNT(*) as station_count,
--     SUM(ports) as total_ports,
--     ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
-- FROM charging_stations_parquet
-- WHERE power_kw IS NOT NULL
-- GROUP BY 
--     CASE 
--         WHEN power_kw < 10 THEN 'Low (< 10kW)'
--         WHEN power_kw BETWEEN 10 AND 50 THEN 'Medium (10-50kW)'
--         WHEN power_kw BETWEEN 50 AND 150 THEN 'High (50-150kW)'
--         WHEN power_kw > 150 THEN 'Ultra High (> 150kW)'
--         ELSE 'Unknown'
--     END
-- ORDER BY station_count DESC;
