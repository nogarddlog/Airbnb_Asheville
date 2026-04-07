## Total reviews per listing and average reviews per month
SELECT
    ROUND(AVG(number_of_reviews), 1) AS avg_reviews_per_listing,
    MAX(number_of_reviews) AS max_reviews,
    SUM(number_of_reviews) AS total_reviews
FROM listings;

###################
## Neighbourhoods with most guest activity
SELECT
    neighbourhood,
    SUM(number_of_reviews) AS total_reviews,
    ROUND(AVG(reviews_per_month), 2) AS avg_reviews_per_month,
    COUNT(*) AS total_listings
FROM listings
GROUP BY neighbourhood
ORDER BY total_reviews DESC;

###################
## Review trends by year and month
SELECT
    YEAR(date) AS review_year,
    COUNT(*) AS total_reviews
FROM reviews
WHERE date IS NOT NULL
GROUP BY review_year
ORDER BY review_year;

###################
## Peak months for reviews
SELECT
    MONTH(date) AS month_number,
    MONTHNAME(date) AS month_name,
    COUNT(*) AS total_reviews
FROM reviews
WHERE date IS NOT NULL
GROUP BY month_number, month_name
ORDER BY total_reviews DESC;