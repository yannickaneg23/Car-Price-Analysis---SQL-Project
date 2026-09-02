# Exploratory Queries

   Ad-hoc SQL queries used during initial data exploration.
-- ============================================================
-- Section: Initial Exploratory Data Queries (Ad-Hoc Inspection)
-- Purpose: Inspect data distributions, schema health, and zero/null values
-- ============================================================

-- 1. Total record count & sample preview
SELECT COUNT(*) AS total_raw_records 
FROM cars_raw;

SELECT * 
FROM cars_raw 
LIMIT 10;

-- 2. Check for NULLs or missing values across critical pricing dimensions
SELECT 
    SUM(CASE WHEN selling_price IS NULL THEN 1 ELSE 0 END) AS null_price,
    SUM(CASE WHEN km_driven IS NULL THEN 1 ELSE 0 END) AS null_km,
    SUM(CASE WHEN fuel IS NULL THEN 1 ELSE 0 END) AS null_fuel,
    SUM(CASE WHEN transmission IS NULL THEN 1 ELSE 0 END) AS null_transmission,
    SUM(CASE WHEN mileage IS NULL THEN 1 ELSE 0 END) AS null_mileage
FROM cars_raw;

-- 3. Inspect unique values and distribution across key categorical fields
SELECT fuel, COUNT(*) AS volume
FROM cars_raw
GROUP BY fuel
ORDER BY volume DESC;

SELECT seller_type, COUNT(*) AS volume
FROM cars_raw
GROUP BY seller_type
ORDER BY volume DESC;

SELECT owner, COUNT(*) AS volume
FROM cars_raw
GROUP BY owner
ORDER BY volume DESC;

-- 4. Check target variable range and anomaly detection (e.g., zero mileage or extreme prices)
SELECT 
    MIN(selling_price) AS min_price,
    MAX(selling_price) AS max_price,
    ROUND(AVG(selling_price), 2) AS avg_price,
    MIN(km_driven) AS min_km,
    MAX(km_driven) AS max_km,
    MIN(mileage) AS min_mileage
FROM cars_raw;

-- 5. Identify anomalous 0-mileage records before data cleaning phase
SELECT COUNT(*) AS zero_mileage_count 
FROM cars_raw 
WHERE mileage <= 0;
