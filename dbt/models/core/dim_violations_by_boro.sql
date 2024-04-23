--Creating a summary data table for violations by boro 
{{ config(materialized='table') }}

with inspection_data as (
    select * from {{ ref('fact_inspect_with_pop') }}
)

    select
    COUNT(violation_id) AS number_of_violations,
    AVG(score) as average_score,
    Borough,
    Pop1 as borough_population,
    ROUND(COUNT(violation_id)/Pop1, 2) as violations_per_capita

    from inspection_data

    where action_taken LIKE "%Violations%"

    group by 
    Borough,
    Pop1 
   