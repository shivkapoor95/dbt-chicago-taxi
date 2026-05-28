SELECT * 
FROM {{ref('int_trips_enriched')}}
WhERE revenue_per_mile < 0