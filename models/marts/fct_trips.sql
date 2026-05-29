 {{ config(
    materialized='incremental',
    unique_key='unique_key'
) }}
 
 with source as 
 (SELECT * 
  FROM {{ref('int_trips_enriched')}}
  {% if is_incremental() %}
    WHERE trip_start_timestamp > (SELECT MAX(trip_start_timestamp) FROM {{ this }})
{% endif %}
  ),
final as (SELECT unique_key,
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
    pickup_time,
    pickup_day,
    revenue_per_mile,
    trip_duration
FROM source)
SELECT * from final