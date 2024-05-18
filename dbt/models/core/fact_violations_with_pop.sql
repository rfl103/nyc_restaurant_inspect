--Joined inspection_data column with boro population data
{{
    config(
        materialized='table'
    )
}}

with inspection_data as (
    select *, 
    from {{ ref('stg_inspection_data') }}
), 
dim_pop_boro as (
    select * from {{ ref('dim_pop_boro') }}
)
select 
        --Removed some columns that will not be needed for further analysis.
        inspection_data.violation_id,
        inspection_data.camis_id,
        inspection_data.dba,
        inspection_data.boro,
        inspection_data.cuisine,
        inspection_data.inspection_date,
        CONCAT(inspection_data.camis_id, inspection_data.inspection_date) as inspection_id,
        inspection_data.inspection_performed,
        inspection_data.action_taken,
        inspection_data.violation_code,
        inspection_data.violation_description,
        inspection_data.critical_flag,
        inspection_data.score,
        inspection_data.grade,
        inspection_data.grade_date,
        inspection_data.record_date,
        inspection_data.inspection_type,
        dim_pop_boro.Borough,
        dim_pop_boro.Pop1,
        dim_pop_boro.LandAcres
from inspection_data
inner join dim_pop_boro
on inspection_data.boro = dim_pop_boro.Borough
