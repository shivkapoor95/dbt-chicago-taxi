SELECT *
FROM {{ ref('int_trips_enriched') }}
WHERE trip_duration < 0