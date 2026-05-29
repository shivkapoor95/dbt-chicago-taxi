with source as (SELECT * 
FROM {{ref('int_trips_enriched')}}),
final as (SELECT distinct payment_type
FROM source)
SELECT * FROM final