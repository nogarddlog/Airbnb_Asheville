## Hosts with most listings
SELECT
    host_id,
    host_name,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS avg_price,
    SUM(number_of_reviews) AS total_reviews
FROM listings
WHERE price IS NOT NULL
GROUP BY host_id, host_name
ORDER BY total_listings DESC
LIMIT 10;

###################
## Superhosts vs regular hosts
## (superhost = calculated_host_listings_count > 1)
SELECT
    CASE 
        WHEN calculated_host_listings_count > 1 THEN 'Multi-listing host'
        ELSE 'Single listing host'
    END AS host_type,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(AVG(number_of_reviews), 1) AS avg_reviews,
    ROUND(AVG(availability_365), 1) AS avg_availability
FROM listings
WHERE price IS NOT NULL
GROUP BY host_type;

####################################
## Do hosts with more listings charge more?
#### Price is not NUL
SELECT
    CASE
        WHEN calculated_host_listings_count = 1 THEN '1 listing'
        WHEN calculated_host_listings_count BETWEEN 2 AND 5 THEN '2-5 listings'
        WHEN calculated_host_listings_count BETWEEN 6 AND 10 THEN '6-10 listings'
        ELSE '10+ listings'
    END AS host_size,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(AVG(number_of_reviews), 1) AS avg_reviews
FROM listings
WHERE price IS NOT NULL    #############  HERE #######
GROUP BY host_size
ORDER BY avg_price DESC;

SELECT
    CASE
        WHEN calculated_host_listings_count = 1 THEN '1 listing'
        WHEN calculated_host_listings_count BETWEEN 2 AND 5 THEN '2-5 listings'
        WHEN calculated_host_listings_count BETWEEN 6 AND 10 THEN '6-10 listings'
        ELSE '10+ listings'
    END AS host_size,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(AVG(number_of_reviews), 1) AS avg_reviews
FROM listings
GROUP BY host_size
ORDER BY avg_price DESC;