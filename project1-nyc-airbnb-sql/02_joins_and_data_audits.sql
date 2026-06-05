-- 1. Core Internal Intersections (Inner Join Mapping)
SELECT h.host_name, l.name AS listing_name, p.price
FROM `airbnb-nyc-database.airbnb_data.Hosts` AS h
INNER JOIN `airbnb-nyc-database.airbnb_data.Listings` AS l  ON h.host_id_PK = l.host_id_FK
INNER JOIN `airbnb-nyc-database.airbnb_data.Pricing` AS p   ON l.id_PK = p.id_FK;

-- 2. Directional Market Mapping (Left Join Layout)
SELECT n.neighbourhood_group, l.name AS property_name, bp.availability_365
FROM `airbnb-nyc-database.airbnb_data.Neighborhoods` AS n
LEFT JOIN `airbnb-nyc-database.airbnb_data.Listings` AS l     ON n.neighbourhood_PK = l.neighbourhood_FK
LEFT JOIN `airbnb-nyc-database.airbnb_data.BookingPolicies` AS bp ON l.id_PK = bp.id_FK;

-- 3. Downstream Matrix Matching (Right Join Layout)
SELECT l.name AS listing_name, rm.number_of_reviews, rm.last_review
FROM `airbnb-nyc-database.airbnb_data.Listings` AS l
RIGHT JOIN `airbnb-nyc-database.airbnb_data.ReviewMetrics` AS rm ON l.id_PK = rm.id_FK;

-- 4. Relational Structural Exception Audit (Full Outer Join Filtering)
-- Isolates data anomalies where listings or review counters lack parent pairs
SELECT l.name AS listing_name, rm.number_of_reviews
FROM `airbnb-nyc-database.airbnb_data.Listings` AS l
FULL OUTER JOIN `airbnb-nyc-database.airbnb_data.ReviewMetrics` AS rm ON l.id_PK = rm.id_FK
WHERE l.name IS NULL OR rm.number_of_reviews IS NULL;
