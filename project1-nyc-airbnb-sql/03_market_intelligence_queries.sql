-- Total NYC Revenue
SELECT SUM(price * (365 - availability_365)) AS Total_Revenue_USD FROM airbnb_data.Pricing p JOIN airbnb_data.BookingPolicies b ON p.id_FK = b.id_FK;
-- Average Nightly Rate
SELECT AVG(price) AS Average_Nightly_Rate FROM airbnb_data.Pricing;
-- Total Listing Count: 
SELECT COUNT(id_PK) AS Total_Listing_Count FROM airbnb_data.Listings;
-- Highest Price
SELECT MAX(price) AS Highest_Price FROM airbnb_data.Pricing;
-- Lowest Price 
SELECT MIN(price) AS Lowest_Price FROM airbnb_data.Pricing;
-- Total Market Reviews 
SELECT SUM(number_of_reviews) AS Total_Reviews FROM airbnb_data.ReviewMetrics;
-- Average NYC Availability
SELECT ROUND(AVG(availability_365)) AS Average_Availability FROM airbnb_data.BookingPolicies;
-- Total Estimated Profit
SELECT ROUND(SUM((price * (365 - availability_365)) * 0.70)) AS Total_Estimated_Profit FROM airbnb_data.Pricing p JOIN airbnb_data.BookingPolicies b ON p.id_FK = b.id_FK; 
-- Average Minimum Stay
SELECT Round(AVG(minimum_nights)) AS Average_Min_Stay FROM airbnb_data.BookingPolicies;
-- Average Monthly Review Rate
SELECT AVG(reviews_per_month) AS Average_Reviews_per_Month FROM airbnb_data.ReviewMetrics;
-- Listings per Borough
SELECT n.neighbourhood_group, COUNT(l.id_PK) AS Number_of_listings FROM airbnb_data.Listings l JOIN airbnb_data.Neighborhoods n ON l.neighbourhood_FK = n.neighbourhood_PK GROUP BY n.neighbourhood_group;
-- Avg Price per Room Type
SELECT rt.room_type_name, AVG(p.price) AS Average_Price FROM airbnb_data.Pricing p JOIN airbnb_data.Listings l ON p.id_FK = l.id_PK JOIN airbnb_data.RoomTypes rt ON l.room_type_id_FK = rt.room_type_id_PK GROUP BY rt.room_type_name;
-- Total Reviews by Borough
SELECT n.neighbourhood_group, SUM(r.number_of_reviews) AS Reviews FROM airbnb_data.ReviewMetrics r JOIN airbnb_data.Listings l ON r.id_FK = l.id_PK JOIN airbnb_data.Neighborhoods n ON l.neighbourhood_FK = n.neighbourhood_PK GROUP BY n.neighbourhood_group;
-- Profit by Room Type
SELECT rt.room_type_name, SUM(p.price * 0.7) AS Profit FROM airbnb_data.Pricing p JOIN airbnb_data.Listings l ON p.id_FK = l.id_PK JOIN airbnb_data.RoomTypes rt ON l.room_type_id_FK = rt.room_type_id_PK GROUP BY rt.room_type_name;
-- Avg Availability per Borough
SELECT n.neighbourhood_group, round(AVG(b.availability_365)) AS Average_Availability FROM airbnb_data.BookingPolicies b JOIN airbnb_data.Listings l ON b.id_FK = l.id_PK JOIN airbnb_data.Neighborhoods n ON l.neighbourhood_FK = n.neighbourhood_PK GROUP BY n.neighbourhood_group;
-- Max Price per Host
SELECT host_id_FK, MAX(price) AS Max_Price FROM airbnb_data.Listings l JOIN airbnb_data.Pricing p ON l.id_PK = p.id_FK GROUP BY host_id_FK;
-- Min Nights by Room Type
SELECT rt.room_type_name, AVG(b.minimum_nights) AS Average_Min_Nights FROM airbnb_data.BookingPolicies b JOIN airbnb_data.Listings l ON b.id_FK = l.id_PK JOIN airbnb_data.RoomTypes rt ON l.room_type_id_FK = rt.room_type_id_PK GROUP BY rt.room_type_name;
-- Reviews per Month by Borough
SELECT n.neighbourhood_group, round(AVG(r.reviews_per_month)) AS Average_Reviews_per_Month FROM airbnb_data.ReviewMetrics r JOIN airbnb_data.Listings l ON r.id_FK = l.id_PK JOIN airbnb_data.Neighborhoods n ON l.neighbourhood_FK = n.neighbourhood_PK GROUP BY n.neighbourhood_group;
-- Listing Count per Neighborhood
SELECT neighbourhood_FK, COUNT(*) Listings_Count FROM airbnb_data.Listings GROUP BY neighbourhood_FK;
-- Average Host Experience (Listings Count)
SELECT host_id_PK, AVG(calculated_host_listings_count) AS Calculated_Host_Listings_Count FROM airbnb_data.Hosts GROUP BY host_id_PK;
--Premium Neighborhoods
SELECT neighbourhood_FK, AVG(price) as Average_Price FROM airbnb_data.Listings l JOIN airbnb_data.Pricing p ON l.id_PK = p.id_FK GROUP BY neighbourhood_FK HAVING Average_Price > 250;
-- High-Density Hosts
SELECT host_id_FK, COUNT(*) as c FROM airbnb_data.Listings GROUP BY host_id_FK HAVING c > 10;
-- Long-Term Stay Districts
SELECT neighbourhood_FK, AVG(minimum_nights) as average_min_nights FROM airbnb_data.Listings l JOIN airbnb_data.BookingPolicies b ON l.id_PK = b.id_FK GROUP BY neighbourhood_FK HAVING average_min_nights > 7;
-- Profitable Neighborhood Groups
SELECT n.neighbourhood_group, SUM(p.price) as Price FROM airbnb_data.Listings l JOIN airbnb_data.Pricing p ON l.id_PK = p.id_FK JOIN airbnb_data.Neighborhoods n ON l.neighbourhood_FK = n.neighbourhood_PK GROUP BY n.neighbourhood_group HAVING Price > 500000;
-- High-Value Hosts
SELECT host_id_FK, SUM(price) as total_price FROM airbnb_data.Listings l JOIN airbnb_data.Pricing p ON l.id_PK = p.id_FK GROUP BY host_id_FK HAVING total_price > 5000;
-- Popular Neighborhoods
SELECT neighbourhood_FK, COUNT(*) as C1 FROM airbnb_data.Listings GROUP BY neighbourhood_FK HAVING C1 > 1000;
-- Budget Boroughs
SELECT n.neighbourhood_group, AVG(p.price) as budget_price FROM airbnb_data.Listings l JOIN airbnb_data.Pricing p ON l.id_PK = p.id_FK JOIN airbnb_data.Neighborhoods n ON l.neighbourhood_FK = n.neighbourhood_PK GROUP BY n.neighbourhood_group HAVING budget_price < 100;
-- Above Average Price
SELECT name FROM airbnb_data.Listings WHERE id_PK IN (SELECT id_FK FROM airbnb_data.Pricing WHERE price > (SELECT AVG(price) FROM airbnb_data.Pricing));
-- Top 5% Most Reviewed
SELECT name FROM airbnb_data.Listings WHERE id_PK IN (SELECT id_FK FROM airbnb_data.ReviewMetrics WHERE number_of_reviews > (SELECT AVG(number_of_reviews) * 5 FROM airbnb_data.ReviewMetrics));
-- Listings in Brooklyn
SELECT name FROM airbnb_data.Listings WHERE neighbourhood_FK IN (SELECT neighbourhood_PK FROM airbnb_data.Neighborhoods WHERE neighbourhood_group = 'Brooklyn');
-- Hosts with Pricey Listings
SELECT host_name FROM airbnb_data.Hosts WHERE host_id_PK IN (SELECT host_id_FK FROM airbnb_data.Listings WHERE id_PK IN (SELECT id_FK FROM airbnb_data.Pricing WHERE price > 5000));
-- Cheapest "Entire home/apt"
SELECT name FROM airbnb_data.Listings WHERE room_type_id_FK = (SELECT room_type_id_PK FROM airbnb_data.RoomTypes WHERE room_type_name = 'Entire home/apt') AND id_PK IN (SELECT id_FK FROM airbnb_data.Pricing WHERE price < 50);
-- Available All Year
SELECT name FROM airbnb_data.Listings WHERE id_PK IN (SELECT id_FK FROM airbnb_data.BookingPolicies WHERE availability_365 = 365);
-- Listings with Zero / No Reviews
SELECT name FROM airbnb_data.Listings WHERE id_PK NOT IN (SELECT id_FK FROM airbnb_data.ReviewMetrics WHERE number_of_reviews = 0);
-- Top Host's Listings 
SELECT name FROM airbnb_data.Listings WHERE host_id_FK = (SELECT host_id_FK FROM airbnb_data.Listings GROUP BY host_id_FK ORDER BY COUNT(*) DESC LIMIT 1);
-- Average Price of Private Rooms
SELECT AVG(price) AS Average_Price_Private_Room FROM airbnb_data.Pricing WHERE id_FK IN (SELECT id_PK FROM airbnb_data.Listings WHERE room_type_id_FK = (SELECT room_type_id_PK FROM airbnb_data.RoomTypes WHERE room_type_name = 'Private room'));
-- Neighborhood with Max Listings
SELECT neighbourhood_group FROM airbnb_data.Neighborhoods WHERE neighbourhood_PK = (SELECT neighbourhood_FK FROM airbnb_data.Listings GROUP BY neighbourhood_FK ORDER BY COUNT(*) DESC LIMIT 1);
