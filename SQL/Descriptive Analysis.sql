###################################################
## Descriptive Analysis
###################################################


##########
##Average and median nightly price

SELECT
    ROUND(AVG(price), 2) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM listings
WHERE price IS NOT NULL;

##########
## Room type distribution
SELECT 
    room_type,
    COUNT(*) AS total_listings,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM listings), 1) AS percentage,
    ROUND(AVG(price), 2) AS avg_price
FROM listings
WHERE price IS NOT NULL
GROUP BY room_type
ORDER BY total_listings DESC;

##########
## Active listings per neighbourhood
SELECT 
    neighbourhood,
    COUNT(*) AS total_listings,
    SUM(CASE WHEN number_of_reviews_ltm > 0 THEN 1 ELSE 0 END) AS active_listings,
    ROUND(AVG(price), 2) AS avg_price
FROM listings
WHERE price IS NOT NULL
GROUP BY neighbourhood
ORDER BY total_listings DESC
LIMIT 10;

##########
## Overall summary
SELECT
    COUNT(*) AS total_listings,
    COUNT(host_id) AS total_hosts,
    COUNT(DISTINCT neighbourhood) AS total_neighbourhoods,
    COUNT(DISTINCT room_type) AS room_types,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(AVG(minimum_nights), 1) AS avg_minimum_nights,
    ROUND(AVG(availability_365), 1) AS avg_availability_days
FROM listings
WHERE price IS NOT NULL;