-- 1. Create Normalized Hosts Dimension Table
CREATE OR REPLACE TABLE `airbnb_data.Hosts` AS
SELECT DISTINCT 
    host_id AS host_id_PK, 
    host_name, 
    calculated_host_listings_count
FROM `airbnb_data.raw_data`;

-- 2. Create Normalized Neighborhoods Dimension Table
CREATE OR REPLACE TABLE `airbnb_data.Neighborhoods` AS
SELECT DISTINCT 
    neighbourhood AS neighbourhood_PK, 
    neighbourhood_group
FROM `airbnb_data.raw_data`;

-- 3. Create RoomTypes Dimension Table using Analytic Windows
CREATE OR REPLACE TABLE `airbnb_data.RoomTypes` AS
SELECT 
    ROW_NUMBER() OVER(ORDER BY room_type) AS room_type_id_PK,
    room_type AS room_type_name
FROM (SELECT DISTINCT room_type FROM `airbnb_data.raw_data`);

-- 4. Create Core Listings Fact Table and Map Foreign Keys
CREATE OR REPLACE TABLE `airbnb_data.Listings` AS
SELECT 
    r.id AS id_PK, 
    r.name, 
    r.host_id AS host_id_FK, 
    r.neighbourhood AS neighbourhood_FK, 
    rt.room_type_id_PK AS room_type_id_FK
FROM `airbnb_data.raw_data` AS r
JOIN `airbnb_data.RoomTypes` AS rt ON r.room_type = rt.room_type_name;

-- 5. Create Supporting Operational Extension Tables
CREATE OR REPLACE TABLE `airbnb_data.Pricing` AS
SELECT id AS id_FK, price FROM `airbnb_data.raw_data`;

CREATE OR REPLACE TABLE `airbnb_data.LocationDetails` AS
SELECT id AS id_FK, latitude, longitude FROM `airbnb_data.raw_data`;

CREATE OR REPLACE TABLE `airbnb_data.BookingPolicies` AS
SELECT id AS id_FK, minimum_nights, availability_365 FROM `airbnb_data.raw_data`;

CREATE OR REPLACE TABLE `airbnb_data.ReviewMetrics` AS
SELECT id AS id_FK, number_of_reviews, last_review, reviews_per_month FROM `airbnb_data.raw_data`;
