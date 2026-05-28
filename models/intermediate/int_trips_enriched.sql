with source as(
SELECT unique_key,
    taxi_id,
    trip_start_timestamp,
    trip_end_timestamp,
    trip_seconds,
    trip_miles,
    fare,
    tips,
    tolls,
    extras,
    trip_total,
    payment_type,
    company,
    pickup_community_area,
    dropoff_community_area,
    pickup_latitude,
    pickup_longitude,
    dropoff_latitude,
    dropoff_longitude  
FROM {{ ref('stg_taxi_trips') }}
),
final as (
    SELECT unique_key,
    taxi_id,
    trip_start_timestamp,
    trip_end_timestamp,
    trip_seconds,
    trip_miles,
    fare,
    tips,
    tolls,
    extras,
    trip_total,
    payment_type,
    company,
    pickup_community_area,
    dropoff_community_area,
    pickup_latitude,
    pickup_longitude,
    dropoff_latitude,
    dropoff_longitude,
    EXTRACT(hour from trip_start_timestamp) as pickup_time,
    EXTRACT(DAYOFWEEK from trip_start_timestamp) as pickup_day,  
    trip_total/ NULLIF(trip_miles, 0) as revenue_per_mile,
    CASE 
    WHEN trip_end_timestamp > trip_start_timestamp 
    THEN TIMESTAMP_DIFF(trip_end_timestamp, trip_start_timestamp, MINUTE)
    ELSE NULL
    END as trip_duration
    FROM source
)
SELECT *
FROM final