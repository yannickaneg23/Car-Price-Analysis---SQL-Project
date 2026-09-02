# Final Queries

   Production-ready or presentation queries.
-- ============================================================
-- Script: 03_insights.sql
-- Project: Car Price Analysis (MySQL 8.0)
-- Purpose: Production-ready queries delivering executive insights,
--          value rankings, and comparative trends for presentation.
-- ============================================================

USE car_price_analysis;

-- ------------------------------------------------------------
-- Query 1: Top 10 High-Value Vehicle Rankings
-- Business Insight: Identifies top-tier listings by selling price
--                   and extracts brand level metrics.
-- ------------------------------------------------------------
SELECT 
    SUBSTRING_INDEX(name, ' ', 1) AS brand,
    name AS vehicle_fullname,
    year,
    fuel,
    transmission,
    km_driven,
    selling_price
FROM cars_raw
ORDER BY selling_price DESC
LIMIT 10;


-- ------------------------------------------------------------
-- Query 2: Distance Value Efficiency Index (Price per KM)
-- Business Insight: Ranks vehicles by cost efficiency per kilometer
--                   driven to isolate high-value secondary market deals.
-- ------------------------------------------------------------
WITH ValueEfficiency AS (
    SELECT 
        SUBSTRING_INDEX(name, ' ', 1) AS brand,
        name AS vehicle_name,
        year,
        km_driven,
        selling_price,
        ROUND(selling_price / NULLIF(km_driven, 0), 2) AS price_per_km
    FROM cars_raw
    WHERE mileage > 0 AND km_driven > 5000
)
SELECT 
    brand,
    vehicle_name,
    year,
    km_driven,
    selling_price,
    price_per_km
FROM ValueEfficiency
ORDER BY price_per_km ASC
LIMIT 10;


-- ------------------------------------------------------------
-- Query 3: Diesel vs. Petrol Valuation Spread over Time
-- Business Insight: Tracks annual price differentials between
--                   diesel and petrol powertrains.
-- ------------------------------------------------------------
SELECT 
    year,
    COUNT(*) AS total_listings,
    ROUND(AVG(CASE WHEN fuel = 'Diesel' THEN selling_price END), 2) AS diesel_avg_price,
    ROUND(AVG(CASE WHEN fuel = 'Petrol' THEN selling_price END), 2) AS petrol_avg_price,
    ROUND(
        AVG(CASE WHEN fuel = 'Diesel' THEN selling_price END) - 
        AVG(CASE WHEN fuel = 'Petrol' THEN selling_price END), 
    2) AS diesel_premium_amount
FROM cars_raw
GROUP BY year
HAVING diesel_avg_price IS NOT NULL AND petrol_avg_price IS NOT NULL
ORDER BY year DESC;


-- ------------------------------------------------------------
-- Query 4: Multi-Dimensional Pivot (Transmission x Seller Type)
-- Business Insight: Evaluates average price and market share across
--                   sales channels and gearbox configurations.
-- ------------------------------------------------------------
SELECT 
    seller_type,
    ROUND(AVG(CASE WHEN transmission = 'Automatic' THEN selling_price END), 2) AS automatic_avg_price,
    COUNT(CASE WHEN transmission = 'Automatic' THEN 1 END) AS automatic_count,
    ROUND(AVG(CASE WHEN transmission = 'Manual' THEN selling_price END), 2) AS manual_avg_price,
    COUNT(CASE WHEN transmission = 'Manual' THEN 1 END) AS manual_count
FROM cars_raw
GROUP BY seller_type
ORDER BY automatic_avg_price DESC;
