# Chicago Taxi — dbt Analytics Project

Analytics engineering project built on 211 million real taxi trip 
records from the City of Chicago, using dbt Core and BigQuery.

## What it does

Transforms raw public taxi data into clean, tested fact and dimension 
tables ready for analysis — following the staging → intermediate → mart 
pattern used in production analytics engineering teams.

## What I built

- **Staging model** — deduplicates ~30 million duplicate source records 
using ROW_NUMBER(), producing a trusted foundation for downstream models
- **Intermediate model** — derives trip duration, revenue per mile, and 
time-based attributes using a custom `safe_divide` macro to handle 
division by zero
- **Fact table** — incremental model using BigQuery MERGE, avoiding full 
scans of 62GB on every run
- **Dimension table** — distinct payment types derived from trip data
- **15 data tests** across all layers with severity configured to 
distinguish known source gaps from genuine pipeline bugs

## Stack

dbt Core 1.11.8 · BigQuery · Python 3.11