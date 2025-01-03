DROP TABLE IF EXISTS indego_data;

-- Create the main table
CREATE TABLE indego_data (
    trip_id TEXT,
    duration INTEGER,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    start_station TEXT,
    start_lat NUMERIC(20,10),
    start_lon NUMERIC(20,10),
    end_station TEXT,
    end_lat NUMERIC(20,10),
    end_lon NUMERIC(20,10),
    bike_id TEXT,
    plan_duration NUMERIC(20,10),
    trip_route_category TEXT,
    passholder_type TEXT,
    bike_type TEXT,
    start_date DATE
);

-- Create a temporary table with the same structure to load raw data
CREATE TEMP TABLE temp_indego_data (
    trip_id TEXT,
    duration INTEGER,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    start_station TEXT,
    start_lat NUMERIC(20,10),
    start_lon NUMERIC(20,10),
    end_station TEXT,
    end_lat NUMERIC(20,10),
    end_lon NUMERIC(20,10),
    bike_id TEXT,
    plan_duration NUMERIC(20,10),
    trip_route_category TEXT,
    passholder_type TEXT,
    bike_type TEXT,
    start_date DATE
);

-- Load data into the temporary table
COPY temp_indego_data
FROM '/Users/gibsonhurst/Desktop/Indego/indego_18_to_24'
WITH (FORMAT CSV, HEADER);

-- Insert distinct records into the main table
INSERT INTO indego_data
SELECT DISTINCT ON (trip_id) * FROM temp_indego_data;

-- Verify that distinct rows were inserted
SELECT * FROM indego_data LIMIT 10;
