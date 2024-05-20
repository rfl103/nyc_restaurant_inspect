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
        inspection_data.violation_id,
        inspection_data.camis_id,
        inspection_data.dba,
        coalesce(inspection_data.boro, 'Unknown') as boro,
        coalesce(inspection_data.cuisine, 'Unknown') as cuisine,
        inspection_data.inspection_date,
        CONCAT(inspection_data.camis_id, inspection_data.inspection_date) as inspection_id,
        inspection_data.inspection_performed,
        coalesce(inspection_data.action_taken, 'No action') as action_taken,
        inspection_data.violation_code,
        coalesce(inspection_data.violation_description, 'Unknown') as violation_description,
        coalesce(inspection_data.critical_flag, 'Unknown') as critical_flag,
        inspection_data.score,
        coalesce(inspection_data.grade, 'Unknown') as grade,
        coalesce(inspection_data.inspection_type, 'Unknown') as inspection_type,
        dim_pop_boro.Pop1,
        dim_pop_boro.LandAcres
from inspection_data
inner join dim_pop_boro
on inspection_data.boro = dim_pop_boro.Borough
