--SUMMARY STATISTICS
SELECT 
	count(trip_id) AS total_trips,
	min(duration) AS min_duration,
	avg(duration) AS avg_duration,
	max(duration) AS max_duration,
	percentile_cont(ARRAY[0.25,0.50,0.75]) WITHIN GROUP (ORDER BY duration) AS duration_quartiles,
	count(DISTINCT start_station) AS total_stations,
	count(DISTINCT bike_id) AS total_bikes,
	min(trip_miles) AS min_trip_miles,
	avg(trip_miles) AS avg_trip_miles,
	max(trip_miles) AS max_trip_miles,
	percentile_cont(ARRAY[0.25,0.50,0.75]) WITHIN GROUP (ORDER BY trip_miles) AS trip_miles_quartiles
FROM indego_data;

--Starting and ending trip count by station
WITH station_trip_count AS (
	SELECT s.start_station, s.start_count, e.end_station, e.end_count
	FROM (
		SELECT start_station, count(trip_id) AS start_count
		FROM indego_data
		WHERE trip_route_category = 'Round Trip'
		GROUP BY start_station
	) AS s
	JOIN (
		SELECT end_station, count(trip_id) AS end_count
		FROM indego_data
		WHERE trip_route_category = 'Round Trip'
		GROUP BY end_station
	) AS e
	ON s.start_station = e.end_station 
	ORDER BY start_count DESC
)
SELECT
	start_station as station_id, 
	start_count, 
	end_count,
	CAST(start_count AS NUMERIC)/CAST(end_count AS NUMERIC) AS demand,
	indego_stations.station_name
FROM station_trip_count
LEFT JOIN indego_stations
ON station_trip_count.start_station = indego_stations.station_id
ORDER BY end_count DESC;
--STATION 90018, 90010, 3000, 90007 are placeholders for something

--Trip count by bike_id
SELECT bike_id, count(trip_id)
FROM indego_data 
GROUP BY bike_id
ORDER BY count(trip_id) DESC;

--Trip count by plan_duration
SELECT plan_duration, count(trip_id)
FROM indego_data 
GROUP BY plan_duration
ORDER BY count(trip_id) DESC;

--Trip count by trip_route_category
SELECT trip_route_category, count(trip_id)
FROM indego_data
GROUP BY trip_route_category
ORDER BY count(trip_id);

--Trip count by passholder_type
SELECT passholder_type, count(trip_id)
FROM indego_data
WHERE start_date > '2018-05-01'
GROUP BY passholder_type
ORDER BY count(trip_id);

-- Trip count by passholder_type over time
SELECT 
	TO_CHAR(start_time, 'YYYY-MM') AS date,
    COUNT(CASE WHEN passholder_type = 'Day Pass' THEN trip_id END) AS day_pass_count,
    COUNT(CASE WHEN passholder_type = 'Indego30' THEN trip_id END) AS indego30_count,
    COUNT(CASE WHEN passholder_type = 'Indego365' THEN trip_id END) AS indego365_count
FROM indego_data
GROUP BY date
ORDER BY date;

--Round trip percentage over time
SELECT 
	TO_CHAR(start_time, 'YYYY-MM') AS date,
    count(CASE WHEN passholder_type = 'Day Pass' AND trip_route_category = 'Round Trip' THEN trip_id END)::NUMERIC / count(CASE WHEN passholder_type = 'Day Pass' THEN trip_id END) AS day_pass_round_trip_perc,
    count(CASE WHEN passholder_type = 'Indego30' AND trip_route_category = 'Round Trip' THEN trip_id END)::NUMERIC / count(CASE WHEN passholder_type = 'Indego30' THEN trip_id END) AS indego30_round_trip_perc,
    count(CASE WHEN passholder_type = 'Indego365' AND trip_route_category = 'Round Trip' THEN trip_id END)::NUMERIC / count(CASE WHEN passholder_type = 'Indego365' THEN trip_id END) AS indego365_round_trip_perc
FROM indego_data
WHERE start_date > '2018-05-01'
GROUP BY date
ORDER BY date;

--Round trip percent by passholder type
SELECT 
	passholder_type, 
	count(CASE WHEN trip_route_category = 'Round Trip' THEN trip_id END)::NUMERIC / count(trip_id) AS round_trip_perc
FROM indego_data
WHERE start_date > '2018-04-01'
GROUP BY passholder_type;

--Round trip percent by location
SELECT
	start_station,
	indego_stations.station_name,
	count(CASE WHEN trip_route_category = 'Round Trip' THEN trip_id END)::NUMERIC / count(trip_id) AS round_trip_perc
FROM indego_data
LEFT JOIN indego_stations
ON indego_data.start_station = indego_stations.station_id
WHERE start_date > '2018-04-01'
GROUP BY start_station, indego_stations.station_name
ORDER BY round_trip_perc DESC
LIMIT 17;

--Trip count by start_date
SELECT start_date, count(trip_id) AS total_trips
FROM indego_data
GROUP BY start_date
ORDER BY start_date ;

--Trip count by date & hour
SELECT TO_CHAR(start_time, 'YYYY-MM-DD HH24') AS date_hour, count(trip_id) AS total_trips
FROM indego_data
GROUP BY date_hour
ORDER BY date_hour ASC;

--Trip count by hour of day
SELECT date_part('hour', start_time) AS start_hour, count(trip_id)
FROM indego_data
GROUP BY start_hour
ORDER by start_hour ASC;

--Trip count in hours
SELECT date_part('hour', start_time) AS start_hour, count(trip_id)
FROM indego_data
GROUP BY start_hour
ORDER by start_hour ASC;

--Trip count by day of week
SELECT date_part('dow', start_time) AS start_dow, count(trip_id)
FROM indego_data
GROUP BY start_dow
ORDER by start_dow ASC;

--Trip count by month of year
SELECT date_part('month', start_time) AS start_month, count(trip_id)
FROM indego_data
GROUP BY start_month
ORDER by start_month ASC;

--Trip count by year (year to date)
SELECT date_part('year', start_time) AS start_year, count(trip_id) AS trip_count_YTD
FROM indego_data
WHERE date_part('month', start_time) < 10
GROUP BY start_year
ORDER by start_year ASC;

--Trip count by duration
SELECT duration, count(trip_id) AS trip_count
FROM indego_data
GROUP BY duration
ORDER BY duration ASC;

--Total duration by start_date
SELECT sum(duration) AS total_duration, start_date
FROM indego_data
GROUP BY start_date
ORDER BY start_date ASC;



--Median trip length by hour
SELECT 
	date_part('hour', start_time) AS start_hour,
	percentile_cont(0.5) WITHIN GROUP (ORDER BY duration) AS median_trip
FROM indego_data
GROUP BY start_hour
ORDER BY start_hour ASC;

--Median trip length by day of week
SELECT 
	date_part('dow', start_time) AS start_dow,
	percentile_cont(0.5) WITHIN GROUP (ORDER BY duration) AS median_trip
FROM indego_data
GROUP BY start_dow
ORDER BY start_dow ASC;

--Median trip length by month of year
SELECT 
	date_part('month', start_time) AS start_month,
	percentile_cont(0.5) WITHIN GROUP (ORDER BY duration) AS median_trip
FROM indego_data
GROUP BY start_month
ORDER BY start_month ASC;

--Median trip length by start_date
SELECT
	percentile_cont(0.5) WITHIN GROUP (ORDER BY duration) AS median_trip,
	start_date
FROM indego_data
GROUP BY start_date
ORDER BY start_date ASC;

--Percentage Round-Trips
SELECT 
	start_date, 
	COUNT(trip_id) FILTER (WHERE trip_route_category = 'Round Trip')::FLOAT / COUNT(trip_id) AS round_trip_perc
FROM indego_data
GROUP BY start_date
ORDER BY start_date ASC;

--First & Last trip of each bike
WITH bike_life  AS (
	SELECT 
		min(start_date) AS first_trip, 
		max(start_date) AS last_trip, 
		bike_id
	FROM indego_data
	GROUP BY bike_id
) SELECT 
	AGE(last_trip, first_trip) AS bike_age,
	count(bike_id)
FROM bike_life
GROUP BY bike_age
ORDER BY bike_age;

--Percentage of bike electric vs percentage of trips electric
WITH bike_info AS (
	SELECT DISTINCT bike_id, bike_type
	FROM indego_data
	WHERE start_date > '2024-01-01'
	ORDER BY bike_id
) SELECT count(bike_id), bike_type
FROM bike_info
GROUP BY bike_type;

SELECT count(trip_id), bike_type
FROM indego_data
WHERE start_date > '2024-01-01'
GROUP BY bike_type

--Trip count by trip distance
CREATE EXTENSION postgis;
SELECT count(trip_id), round(trip_miles,1) AS trip_distance
FROM indego_data
GROUP BY round(trip_miles,1)


