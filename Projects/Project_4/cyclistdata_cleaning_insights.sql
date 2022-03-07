/* Analysis of Cyclistics, a bike sharing company */
/* renamed all columns to have a uniform naming convention */
/* updating columns to remove "quotes" from all varchar columns*/
update dbo.all_trips_v2 SET [rideable_type] = replace([rideable_type], '"', '');
update dbo.all_trips_v2 SET [start_station_name] = replace([start_station_name], '"', '');
update dbo.all_trips_v2 SET [end_station_name] = replace([end_station_name], '"', '');
update dbo.all_trips_v2 SET [member_casual] = replace([member_casual], '"', '');
update dbo.all_trips_v2 SET [month] = replace([month], '"', '');
update dbo.all_trips_v2 SET [day] = replace([day], '"', '');
update dbo.all_trips_v2 SET [year] = replace([year], '"', '');
update dbo.all_trips_v2 SET [day_of_week] = replace([day_of_week], '"', '');

/* total trips by start and end stations */
//* most rides seem to end at the same station they began *//
SELECT 
	start_station_name, 
	COUNT(start_station_name) AS total_start,
	end_station_name,
	COUNT(end_station_name) AS total_end
FROM dbo.all_trips_v2
GROUP BY start_station_name, end_station_name
ORDER BY start_station_name, end_station_name;


/* create value for average ride length */
//* warmer months have a longer average ride time *//
/* Why would casual riders buy Cylcistics annual membership? */
/* Run an ad campaign in the warmer months to appeal to casual riders with shorter membership plans */
WITH cte AS(
SELECT
	COUNT(rideable_type) AS total_rides,
	SUM(CAST(ride_length AS DECIMAL)) AS sum_ride_length,
	month,
	year
FROM dbo.all_trips_v2
GROUP BY month, year
)
SELECT
	month,
	year,
	sum_ride_length/total_rides AS average_ride_length
FROM cte
ORDER BY month, year;


DECLARE @meterspermile FLOAT =1609.344;
DECLARE @origstart GEOGRAPHY = GEOGRAPHY::Point(start_lat, start_lng)
DECLARE @origend GEOGRAPHY = GEOGRAPHY::Point(end_lat, end_lng)
SELECT @origend.STDistance(@origend)/@meterspermile AS distance FROM dbo.all_trips_v2

/* How do annual members and casual riders use Cyclistics bikes differently */
/* Casual riders average longer rides than members and go further than members */
SELECT 
	member_casual,
	ride_length
FROM dbo.all_trips_v2
ORDER BY ride_length DESC;

SELECT
	member_casual,
	SUM(CAST (ride_length AS DECIMAL))/COUNT(CAST (ride_length AS DECIMAL)) AS average_length,
	COUNT(date) AS number_of_rides
FROM  dbo.all_trips_v2
WHERE member_casual LIKE 'casual'
GROUP BY member_casual;

SELECT
	member_casual,
	SUM(CAST (ride_length AS DECIMAL))/COUNT(CAST (ride_length AS DECIMAL)) AS average_length,
	COUNT(date) AS number_of_rides
FROM  dbo.all_trips_v2
WHERE member_casual LIKE 'member'
GROUP BY member_casual;












/* CREATE VIEWS FOR VISUALIZATION USES */

