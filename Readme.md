# Metropolitan Public Transport Data Analysis

## Overview
This project provides a solution for storing and analyzing data from a metropolitan public transport system using Apache Cassandra. The data includes route segments, number of passengers, travel time, line numbers, and service numbers. The solution is designed to efficiently answer specific queries regarding the total number of passengers on a route segment for a specified day and the travel time for a given service number of a given line on a specified day.

## Prerequisites
- Docker installed on your machine
- Internet connection to download the necessary Docker images

## Files
- `Dockerfile`: Creates a Docker image with Cassandra and sets up the data model
- `schema.cql`: CQL script to create the desired schema
- `example.log`: MySQL logs (not used in this guide)
- `log_analysis.txt`: Log analysis of example.log (not used in this guide)

<img width="1440" alt="Screenshot 2024-06-10 at 17 15 34" src="https://github.com/MatforZo/Cassandra/assets/121509790/784046fe-4e6f-419a-a969-d2116d7b2a64">

## Step 1: Build a docker image:

sudo docker build -t my_cassandra_image .

## Step 2: Run the Docker Container:

docker run --name my_cassandra_container -d -p 9042:9042 my_cassandra_image

## Step 3: Access CassandraDB

docker exec -it my_cassandra_container cqlsh

## Use below query to retrieve data that answers following question: What was the total number of passengers for a given route segment on a specified day?

SELECT SUM(passengers_count) AS total_passengers
FROM route_segment
WHERE segment_id = 'seg1' AND date = '2024-06-10';

## Use below query to retrieve data that answers following question: What was the travel time for a given service number of a given line on a specified day (from the first to the last stop)?

SELECT travel_time
FROM service_travel_time
WHERE line_number = 'L1' AND service_no = 101 AND date = '2024-06-10';
