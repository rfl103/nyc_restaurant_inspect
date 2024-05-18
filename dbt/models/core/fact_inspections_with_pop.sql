--Joined inspection_data column with boro population data
{{
    config(
        materialized='table'
    )
}}

with inspection_data as (
    select *
    from {{ ref('stg_inspection_data') }}
), 
dim_pop_boro as (
    select * from {{ ref('dim_pop_boro') }}
)
select 
        {{ dbt_utils.generate_surrogate_key(['camis_id', 'inspection_date']) }} as inspection_id,
        COUNT(inspection_data.violation_code) AS violation_count,
        inspection_data.camis_id,
        inspection_data.dba,
        inspection_data.boro,
        inspection_data.cuisine,
        inspection_data.inspection_date,
        inspection_data.inspection_performed,
        inspection_data.action_taken,
        inspection_data.score,
        inspection_data.grade,
        inspection_data.inspection_type,
        inspection_data.latitude,
        inspection_data.longitude,
        dim_pop_boro.Borough,
        dim_pop_boro.Pop1,
        dim_pop_boro.LandAcres
from inspection_data
inner join dim_pop_boro
on inspection_data.boro = dim_pop_boro.Borough
group by inspection_id, 
        inspection_data.camis_id, 
        inspection_data.dba, 
        inspection_data.boro, 
        inspection_data.cuisine,
        inspection_data.inspection_date,
        inspection_data.inspection_performed,
        inspection_data.action_taken,
        inspection_data.score,
        inspection_data.grade,
        inspection_data.inspection_type,
        inspection_data.latitude,
        inspection_data.longitude,
        dim_pop_boro.Borough,
        dim_pop_boro.Pop1,
        dim_pop_boro.LandAcres