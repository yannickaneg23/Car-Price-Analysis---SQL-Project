


CREATE DATABASE IF NOT EXISTS car_data_cleaning;

USE car_data_cleaning;

   CREATE TABLE cars_raw (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    year INT,
    selling_price INT,
    km_driven INT,
    fuel VARCHAR(20),
    seller_type VARCHAR(20),
    transmission VARCHAR(20),
    owner VARCHAR(30),
    mileage VARCHAR(30),
    engine VARCHAR(30),
    max_power VARCHAR(30),
    torque VARCHAR(50),
    seats INT
);


LOAD DATA LOCAL INFILE 'C:\Users\USER\Downloads\archive (1) (1).zip'
INTO TABLE cars_raw
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE 'C:/path/to/user/Car_details_v3.csv'
INTO TABLE cars_raw
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/path/to/user/Car_details_v3.csv'
INTO TABLE cars_raw
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_rows FROM cars_raw;

SELECT * FROM cars_raw LIMIT 10;


SELECT COUNT(*) FROM cars_raw;

SELECT * FROM cars_raw LIMIT 10;



DESCRIBE cars_raw;

SELECT COUNT(*) AS total_rows FROM cars_raw;

SELECT * FROM cars_raw LIMIT 10;

SELECT COUNT(*) AS total_rows FROM cars_raw;

SELECT * FROM cars_raw LIMIT 10;

SELECT COUNT(*) AS total_rows FROM cars_raw;

SELECT * FROM cars_raw LIMIT 10;

SELECT DATABASE();

USE car_data_cleaning;

SHOW TABLES;

SELECT COUNT(*) AS total_rows FROM cars_raw;

SELECT * FROM cars_raw LIMIT 10;

SELECT 
    SUM(name IS NULL) AS name_nulls,
    SUM(year IS NULL) AS year_nulls,
    SUM(selling_price IS NULL) AS selling_price_nulls,
    SUM(km_driven IS NULL) AS km_driven_nulls,
    SUM(fuel IS NULL) AS fuel_nulls,
    SUM(seller_type IS NULL) AS seller_type_nulls,
    SUM(transmission IS NULL) AS transmission_nulls,
    SUM(owner IS NULL) AS owner_nulls,
    SUM(mileage IS NULL) AS mileage_nulls,
    SUM(engine IS NULL) AS engine_nulls,
    SUM(max_power IS NULL) AS max_power_nulls,
    SUM(torque IS NULL) AS torque_nulls,
    SUM(seats IS NULL) AS seats_nulls
FROM cars_raw;


SELECT name, year, selling_price, km_driven, COUNT(*) AS duplicate_count
FROM cars_raw
GROUP BY name, year, selling_price, km_driven
HAVING COUNT(*) > 1;

SELECT 
    SUM(name IS NULL) AS name_nulls,
    SUM(year IS NULL) AS year_nulls,
    SUM(selling_price IS NULL) AS selling_price_nulls,
    SUM(km_driven IS NULL) AS km_driven_nulls,
    SUM(fuel IS NULL) AS fuel_nulls,
    SUM(seller_type IS NULL) AS seller_type_nulls,
    SUM(transmission IS NULL) AS transmission_nulls,
    SUM(owner IS NULL) AS owner_nulls,
    SUM(mileage IS NULL) AS mileage_nulls,
    SUM(engine IS NULL) AS engine_nulls,
    SUM(max_power IS NULL) AS max_power_nulls,
    SUM(torque IS NULL) AS torque_nulls,
    SUM(seats IS NULL) AS seats_nulls
FROM cars_raw;

SELECT name, year, selling_price, km_driven, COUNT(*) AS duplicate_count
FROM cars_raw
GROUP BY name, year, selling_price, km_driven
HAVING COUNT(*) > 1;
SELECT name, year, selling_price, km_driven, COUNT(*) AS duplicate_count
FROM cars_raw
GROUP BY name, year, selling_price, km_driven
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS total_duplicate_rows
FROM (
    SELECT name, year, selling_price, km_driven
    FROM cars_raw
    GROUP BY name, year, selling_price, km_driven
    HAVING COUNT(*) > 1
) AS dup;

SELECT name, year, selling_price, km_driven, COUNT(*) AS duplicate_count
FROM cars_raw
GROUP BY name, year, selling_price, km_driven
HAVING COUNT(*) > 1;


SELECT COUNT(*) - COUNT(DISTINCT name, year, selling_price, km_driven) AS duplicate_count
FROM cars_raw;


CREATE TABLE cars_clean AS
SELECT DISTINCT *
FROM cars_raw;


DROP TABLE cars_raw;

ALTER TABLE cars_clean RENAME TO cars_raw;

SELECT COUNT(*) AS total_rows FROM cars_raw;



SELECT 
    SUM(name = '') AS name_blanks,
    SUM(fuel = '') AS fuel_blanks,
    SUM(seller_type = '') AS seller_blanks,
    SUM(transmission = '') AS transmission_blanks,
    SUM(owner = '') AS owner_blanks,
    SUM(mileage = '') AS mileage_blanks,
    SUM(engine = '') AS engine_blanks,
    SUM(max_power = '') AS max_power_blanks,
    SUM(torque = '') AS torque_blanks
FROM cars_raw;

SELECT DISTINCT fuel FROM cars_raw;
SELECT DISTINCT seller_type FROM cars_raw;
SELECT DISTINCT transmission FROM cars_raw;
SELECT DISTINCT owner FROM cars_raw;


SELECT 
    SUM(selling_price <= 0) AS price_zero_or_neg,
    SUM(year < 1980) AS year_too_old,
    SUM(year > 2024) AS year_future,
    SUM(km_driven <= 0) AS km_zero_or_neg,
    SUM(engine = 0) AS engine_zero,
    SUM(max_power = 0) AS max_power_zero,
    SUM(seats <= 0) AS seats_zero_or_neg
FROM cars_raw;


SELECT MIN(selling_price) AS min_price, MAX(selling_price) AS max_price,
       MIN(km_driven) AS min_km, MAX(km_driven) AS max_km,
       MIN(year) AS min_year, MAX(year) AS max_year
FROM cars_raw;

SELECT MIN(selling_price) AS min_price, MAX(selling_price) AS max_price,
       MIN(km_driven) AS min_km, MAX(km_driven) AS max_km,
       MIN(year) AS min_year, MAX(year) AS max_year
FROM cars_raw;

SELECT 
    AVG(selling_price) AS avg_price,
    PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY selling_price) AS p95_price,
    PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY selling_price) AS p99_price
FROM cars_raw;

SELECT name, year, selling_price, km_driven, fuel, transmission
FROM cars_raw
WHERE selling_price > 5000000
ORDER BY selling_price DESC;


SELECT name, year, selling_price, km_driven, fuel, transmission
FROM cars_raw
WHERE km_driven > 1000000
ORDER BY km_driven DESC;

SELECT name, year, selling_price, km_driven, fuel, seller_type, transmission, owner, COUNT(*) AS dup_count
FROM cars_raw
GROUP BY name, year, selling_price, km_driven, fuel, seller_type, transmission, owner
HAVING COUNT(*) > 1;


CREATE TABLE cars_clean AS
SELECT DISTINCT *
FROM cars_raw;

DROP TABLE cars_raw;

ALTER TABLE cars_clean RENAME TO cars_raw;


SELECT COUNT(*) AS total_rows FROM cars_raw;


SELECT name, year, selling_price, km_driven, fuel, seller_type, transmission, owner, COUNT(*) AS dup_count
FROM cars_raw
GROUP BY name, year, selling_price, km_driven, fuel, seller_type, transmission, owner
HAVING COUNT(*) > 1;

SELECT *
FROM cars_raw
WHERE name = 'Maruti Omni 8 Seater BSIV' 
  AND year = 2012 
  AND selling_price = 150000 
  AND km_driven = 35000;
  
  SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'cars_raw'
ORDER BY ordinal_position;

DELETE c1
FROM cars_raw c1
INNER JOIN cars_raw c2
WHERE 
    c1.id > c2.id
    AND c1.name = c2.name
    AND c1.year = c2.year
    AND c1.selling_price = c2.selling_price
    AND c1.km_driven = c2.km_driven
    AND c1.fuel = c2.fuel
    AND c1.seller_type = c2.seller_type
    AND c1.transmission = c2.transmission
    AND c1.owner = c2.owner
    AND c1.mileage = c2.mileage
    AND c1.engine = c2.engine
    AND c1.max_power = c2.max_power
    AND c1.torque = c2.torque
    AND c1.seats = c2.seats;
    
    
    SELECT COUNT(*) AS total_rows FROM cars_raw;
    
    
    SELECT 
    id,
    name,
    year,
    selling_price,
    km_driven,
    fuel,
    seller_type,
    transmission,
    owner,
    mileage,
    engine,
    max_power,
    torque,
    seats,
    LENGTH(mileage) AS mileage_len,
    LENGTH(engine) AS engine_len,
    LENGTH(max_power) AS max_power_len,
    LENGTH(torque) AS torque_len
FROM cars_raw
WHERE name = 'Maruti Omni 8 Seater BSIV' 
  AND year = 2012 
  AND selling_price = 150000 
  AND km_driven = 35000;
  
  SELECT 
    id,
    QUOTE(mileage) AS mileage_quoted,
    QUOTE(engine) AS engine_quoted,
    QUOTE(max_power) AS max_power_quoted,
    QUOTE(torque) AS torque_quoted,
    QUOTE(name) AS name_quoted
FROM cars_raw
WHERE name = 'Maruti Omni 8 Seater BSIV' 
  AND year = 2012 
  AND selling_price = 150000 
  AND km_driven = 35000;
  
  
  CREATE TABLE cars_temp AS
SELECT MIN(id) AS keep_id
FROM cars_raw
GROUP BY name, year, selling_price, km_driven, fuel, seller_type, transmission, owner, 
         mileage, engine, max_power, torque, seats;
         
       DELETE FROM cars_raw
WHERE id NOT IN (SELECT keep_id FROM cars_temp);

  DROP TABLE cars_temp;
  
  SET SQL_SAFE_UPDATES = 0;
  
  
  DELETE FROM cars_raw
WHERE id NOT IN (SELECT keep_id FROM cars_temp);

DELETE FROM cars_raw
WHERE id NOT IN (SELECT keep_id FROM cars_temp);


CREATE TABLE cars_temp AS
SELECT MIN(id) AS keep_id
FROM cars_raw
GROUP BY name, year, selling_price, km_driven, fuel, seller_type, transmission, owner, 
         mileage, engine, max_power, torque, seats;
         
         SELECT DATABASE();
         
         CREATE TABLE cars_temp (
    keep_id INT
);

CREATE TABLE cars_temp AS
SELECT MIN(id) AS keep_id
FROM cars_raw
GROUP BY name, year, selling_price, km_driven, fuel, seller_type, transmission, owner, mileage, engine, max_power, torque, seats;   


SELECT COUNT(*) AS temp_count FROM cars_temp;


SET SQL_SAFE_UPDATES = 0;

DELETE FROM cars_raw
WHERE id NOT IN (SELECT keep_id FROM cars_temp);

SELECT COUNT(*) AS total_rows FROM cars_raw;

SELECT COUNT(*) AS total_rows FROM cars_raw;

DELETE FROM cars_raw
WHERE id NOT IN (SELECT keep_id FROM cars_temp);

SELECT COUNT(*) AS total_rows FROM cars_raw;

DROP TABLE cars_temp;


SELECT 
    SUM(CASE WHEN name IS NULL OR name = '' THEN 1 ELSE 0 END) AS name_missing,
    SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS year_missing,
    SUM(CASE WHEN selling_price IS NULL THEN 1 ELSE 0 END) AS selling_price_missing,
    SUM(CASE WHEN km_driven IS NULL THEN 1 ELSE 0 END) AS km_driven_missing,
    SUM(CASE WHEN fuel IS NULL OR fuel = '' THEN 1 ELSE 0 END) AS fuel_missing,
    SUM(CASE WHEN seller_type IS NULL OR seller_type = '' THEN 1 ELSE 0 END) AS seller_type_missing,
    SUM(CASE WHEN transmission IS NULL OR transmission = '' THEN 1 ELSE 0 END) AS transmission_missing,
    SUM(CASE WHEN owner IS NULL OR owner = '' THEN 1 ELSE 0 END) AS owner_missing,
    SUM(CASE WHEN mileage IS NULL OR mileage = '' THEN 1 ELSE 0 END) AS mileage_missing,
    SUM(CASE WHEN engine IS NULL OR engine = '' THEN 1 ELSE 0 END) AS engine_missing,
    SUM(CASE WHEN max_power IS NULL OR max_power = '' THEN 1 ELSE 0 END) AS max_power_missing,
    SUM(CASE WHEN torque IS NULL OR torque = '' THEN 1 ELSE 0 END) AS torque_missing,
    SUM(CASE WHEN seats IS NULL THEN 1 ELSE 0 END) AS seats_missing
FROM cars_raw;

SELECT *
FROM cars_raw
WHERE torque IS NULL OR torque = '';

DELETE FROM cars_raw
WHERE id = 4796;

SELECT COUNT(*) AS total_rows FROM cars_raw;


SHOW COLUMNS FROM cars_raw;


SELECT 
    SUM(CASE WHEN mileage = '' OR mileage IS NULL THEN 1 ELSE 0 END) AS mileage_empty,
    SUM(CASE WHEN engine = '' OR engine IS NULL THEN 1 ELSE 0 END) AS engine_empty,
    SUM(CASE WHEN max_power = '' OR max_power = ' bhp' OR max_power IS NULL THEN 1 ELSE 0 END) AS max_power_empty,
    SUM(CASE WHEN torque = '' OR torque IS NULL THEN 1 ELSE 0 END) AS torque_empty
FROM cars_raw;

SELECT 
    MIN(year) AS min_year, MAX(year) AS max_year,
    MIN(selling_price) AS min_price, MAX(selling_price) AS max_price,
    MIN(km_driven) AS min_km, MAX(km_driven) AS max_km,
    MIN(seats) AS min_seats, MAX(seats) AS max_seats
FROM cars_raw;


SELECT *
FROM cars_raw
WHERE selling_price < 10000
ORDER BY selling_price ASC
LIMIT 20;

SELECT fuel, COUNT(*) AS count
FROM cars_raw
GROUP BY fuel;
SELECT seller_type, COUNT(*) AS count
FROM cars_raw
GROUP BY seller_type;

SELECT transmission, COUNT(*) AS count
FROM cars_raw
GROUP BY transmission;


SELECT owner, COUNT(*) AS count
FROM cars_raw
GROUP BY owner;


SELECT mileage, engine, max_power, torque
FROM cars_raw
LIMIT 10;

UPDATE cars_raw
SET mileage = CAST(REGEXP_SUBSTR(mileage, '[0-9.]+') AS DECIMAL(10,2));


UPDATE cars_raw
SET engine = CAST(REGEXP_SUBSTR(engine, '[0-9]+') AS UNSIGNED);

UPDATE cars_raw
SET max_power = CAST(REGEXP_SUBSTR(max_power, '[0-9.]+') AS DECIMAL(10,2));

UPDATE cars_raw
SET torque = CAST(REGEXP_SUBSTR(torque, '[0-9.]+') AS DECIMAL(10,2));

SELECT mileage, engine, max_power, torque
FROM cars_raw
LIMIT 10;

UPDATE cars_raw
SET mileage = CAST(REGEXP_SUBSTR(mileage, '[0-9]+\\.[0-9]+|[0-9]+') AS DECIMAL(10,2));

UPDATE cars_raw
SET max_power = CAST(REGEXP_SUBSTR(max_power, '[0-9]+\\.[0-9]+|[0-9]+') AS DECIMAL(10,2));

UPDATE cars_raw
SET torque = CAST(REGEXP_SUBSTR(torque, '[0-9]+\\.[0-9]+|[0-9]+') AS DECIMAL(10,2));
SELECT mileage, engine, max_power, torque
FROM cars_raw
LIMIT 10;
SHOW COLUMNS FROM cars_raw;



SELECT 
    MIN(mileage) AS min_mileage, MAX(mileage) AS max_mileage,
    MIN(engine) AS min_engine, MAX(engine) AS max_engine,
    MIN(max_power) AS min_power, MAX(max_power) AS max_power,
    MIN(torque) AS min_torque, MAX(torque) AS max_torque
FROM cars_raw;

ALTER TABLE cars_raw 
    MODIFY mileage DECIMAL(10,2),
    MODIFY engine INT,
    MODIFY max_power DECIMAL(10,2),
    MODIFY torque DECIMAL(10,2);
    
    SELECT *
FROM cars_raw
WHERE mileage <= 0 OR max_power <= 10 OR torque <= 10 OR engine < 500;

DELETE FROM cars_raw
WHERE mileage <= 0 OR max_power <= 10 OR torque <= 10 OR engine < 500;


DELETE FROM cars_raw
WHERE mileage <= 0;


SELECT COUNT(*) AS total_rows,
       SUM(CASE WHEN mileage <= 0 THEN 1 ELSE 0 END) AS invalid_mileage
FROM cars_raw;

SELECT 
    fuel,
    COUNT(*) AS count,
    ROUND(AVG(selling_price), 2) AS avg_price,
    MIN(selling_price) AS min_price,
    MAX(selling_price) AS max_price
FROM cars_raw
GROUP BY fuel
ORDER BY avg_price DESC;


SELECT 
    transmission,
    COUNT(*) AS count,
    ROUND(AVG(selling_price), 2) AS avg_price
FROM cars_raw
GROUP BY transmission
ORDER BY avg_price DESC;

SELECT 
    seller_type,
    COUNT(*) AS count,
    ROUND(AVG(selling_price), 2) AS avg_price
FROM cars_raw
GROUP BY seller_type
ORDER BY avg_price DESC;
SELECT 
    owner,
    COUNT(*) AS count,
    ROUND(AVG(selling_price), 2) AS avg_price
FROM cars_raw
GROUP BY owner
ORDER BY avg_price DESC;

