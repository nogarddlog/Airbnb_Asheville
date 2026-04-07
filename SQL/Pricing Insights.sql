## Average price by neighbourhood
SELECT 
    neighbourhood,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM listings
WHERE price IS NOT NULL
GROUP BY neighbourhood
ORDER BY avg_price DESC;

###################
## Top 5 most expensive neighbourhoods
SELECT 
    neighbourhood,
    ROUND(AVG(price), 2) AS avg_price,
    COUNT(*) AS total_listings
FROM listings
WHERE price IS NOT NULL
GROUP BY neighbourhood
ORDER BY avg_price DESC
LIMIT 5;

###################
## Does minimum nights affect average price?
SELECT 
    CASE 
        WHEN minimum_nights = 1 THEN '1 night'
        WHEN minimum_nights BETWEEN 2 AND 3 THEN '2-3 nights'
        WHEN minimum_nights BETWEEN 4 AND 7 THEN '4-7 nights'
        WHEN minimum_nights BETWEEN 8 AND 30 THEN '8-30 nights'
        ELSE '30+ nights'
    END AS minimum_stay,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS avg_price
FROM listings
WHERE price IS NOT NULL
GROUP BY minimum_stay
ORDER BY avg_price DESC;