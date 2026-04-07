CREATE DATABASE IF NOT EXISTS airbnb;
USE airbnb;

### Listings table
DROP TABLE IF EXISTS listings;
CREATE TABLE listings (
    id BIGINT PRIMARY KEY,
    name VARCHAR(255),
    host_id BIGINT,
    host_name VARCHAR(100),
    neighbourhood_group VARCHAR(10),
    neighbourhood VARCHAR(100),
    latitude FLOAT,
    longitude FLOAT,
    room_type VARCHAR(50),
    price INT,
    minimum_nights INT,
    number_of_reviews INT,
    last_review DATE,
    reviews_per_month FLOAT,
    calculated_host_listings_count INT,
    availability_365 INT,
    number_of_reviews_ltm INT,
    license VARCHAR(100)
);

### Neighbourhoods table
DROP TABLE IF EXISTS neighbourhoods;
CREATE TABLE neighbourhoods (
    neighbourhood_group VARCHAR(100),
    neighbourhood VARCHAR(100)
);

### Reviews table
DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
    listing_id INT,
    date DATE
);


### Load data
LOAD DATA LOCAL INFILE 'D:/study/MBA/SQL/project/Asheville Airbnb Listings Analysis/listings.csv'
INTO TABLE listings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, name, host_id, host_name, neighbourhood_group, neighbourhood,
latitude, longitude, room_type, @price, minimum_nights, number_of_reviews,
@last_review, reviews_per_month, calculated_host_listings_count,
availability_365, number_of_reviews_ltm, license)
SET 
    last_review = NULLIF(@last_review, ''),
    price = NULLIF(@price, '');

    
 

LOAD DATA LOCAL INFILE 'D:/study/MBA/SQL/project/Asheville Airbnb Listings Analysis/neighbourhoods.csv'
INTO TABLE neighbourhoods
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'D:/study/MBA/SQL/project/Asheville Airbnb Listings Analysis/reviews.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

### Verify row counts
SELECT 'listings' AS table_name, COUNT(*) AS total_rows FROM listings
UNION ALL
SELECT 'neighbourhoods', COUNT(*) FROM neighbourhoods
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews;

###
SELECT *
FROM neighbourhoods
;
SELECT *
FROM listings
;
SELECT *
FROM reviews
;


### Check missing prices
SELECT COUNT(*) AS missing_price FROM listings WHERE price IS NULL;

### Check price outliers
SELECT MIN(price) AS min_price, 
       MAX(price) AS max_price, 
       ROUND(AVG(price), 2) AS avg_price
FROM listings 
WHERE price IS NOT NULL;

### Quick preview
SELECT id, name, neighbourhood, room_type, price, minimum_nights
FROM listings
LIMIT 5;