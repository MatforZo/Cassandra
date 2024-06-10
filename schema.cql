-- Create keyspace
CREATE KEYSPACE IF NOT EXISTS transport
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'};

-- Use the created keyspace
USE transport;

-- Create route_segment table
-- To find the travel time for a given service number of a given line on a specified day, the table needs to store the following data:
-- segment_id, date, line_number, passengers_count

CREATE TABLE IF NOT EXISTS route_segment (
    segment_id TEXT,
    date TEXT,
    line_number TEXT,
    passengers_count INT,
    PRIMARY KEY ((segment_id, date), line_number)
);

-- Create service_travel_time table
-- To find the travel time for a given service number of a given line on a specified day, the table needs to store following data:
-- line_number, service_no, date, start_time, end_time, travel_time

CREATE TABLE IF NOT EXISTS service_travel_time (
    line_number TEXT,
    service_no INT,
    date TEXT,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    travel_time INT,
    PRIMARY KEY ((line_number, service_no, date), start_time)
);

-- Below queries insert data into route_segment and service_travel_time tables for test purposes
INSERT INTO route_segment (segment_id, date, line_number, passengers_count)
VALUES ('seg1', '2024-06-10', 'L1', 120);

INSERT INTO route_segment (segment_id, date, line_number, passengers_count)
VALUES ('seg1', '2024-06-10', 'L2', 80);

INSERT INTO route_segment (segment_id, date, line_number, passengers_count)
VALUES ('seg2', '2024-06-10', 'L1', 150);

INSERT INTO service_travel_time (line_number, service_no, date, start_time, end_time, travel_time)
VALUES ('L1', 101, '2024-06-10', '2024-06-10T08:00:00', '2024-06-10T08:30:00', 30);

INSERT INTO service_travel_time (line_number, service_no, date, start_time, end_time, travel_time)
VALUES ('L1', 102, '2024-06-10', '2024-06-10T09:00:00', '2024-06-10T09:45:00', 45);

INSERT INTO service_travel_time (line_number, service_no, date, start_time, end_time, travel_time)
VALUES ('L2', 201, '2024-06-10', '2024-06-10T07:00:00', '2024-06-10T07:25:00', 25);

-- Use below query to retrieve data that answers following question:
-- What was the total number of passengers for a given route segment on a specified day?

SELECT SUM(passengers_count) AS total_passengers
FROM route_segment
WHERE segment_id = 'seg1' AND date = '2024-06-10';

-- Use below query to retrieve data that answers following question:
-- What was the travel time for a given service number of a given line on a specified day (from the first to the last stop)?

SELECT travel_time
FROM service_travel_time
WHERE line_number = 'L1' AND service_no = 101 AND date = '2024-06-10';

