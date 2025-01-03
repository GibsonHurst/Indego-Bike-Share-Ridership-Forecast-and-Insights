CREATE EXTENSION postgis;

--Add geometry point columns
ALTER TABLE indego_data ADD COLUMN start_geom_point geometry(Point, 4326);
ALTER TABLE indego_data ADD COLUMN end_geom_point geometry(Point, 4326);

--Fill geometry point columns
UPDATE indego_data
SET start_geom_point = ST_SetSRID(ST_MakePoint(start_lon, start_lat), 4326);

UPDATE indego_data
SET end_geom_point = ST_SetSRID(ST_MakePoint(end_lon, end_lat), 4326);

--Add geometry lineString column between start and end of trip
ALTER TABLE indego_data ADD COLUMN route_geom_line geometry(LineString, 4326);

--Fill geometry lineString column
UPDATE indego_data
SET route_geom_line = ST_MakeLine(start_geom_point, end_geom_point);

--Add distance of route column
ALTER TABLE indego_data ADD COLUMN trip_miles numeric(10,5);

--Fill trip_miles
UPDATE indego_data
SET trip_miles = ST_Distance(
    ST_Transform(start_geom_point, 3857),
    ST_Transform(end_geom_point, 3857)
) * 0.000621371;

--Check results
SELECT
	start_lon,
	start_lat,
	end_lon,
	end_lat,
	start_geom_point,
	end_geom_point,
	route_geom_line,
	trip_miles
FROM indego_data
WHERE route_geom_line IS NOT NULL
LIMIT 2000;



