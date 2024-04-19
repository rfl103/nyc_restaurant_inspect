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
        inspection_data.inspection_id,
        inspection_data.camis_id,
        inspection_data.dba,
        inspection_data.boro,
        inspection_data.building_number,
        inspection_data.street,
        inspection_data.zipcode,
        inspection_data.cuisine,
        inspection_data.insepction_date,
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
        inspection_data.latitude,
        inspection_data.longitude,
        inspection_data.census_tract,
        dim_pop_boro.Borough,
        dim_pop_boro.Name,
        dim_pop_boro.Pop1,
        dim_pop_boro.PopAcre,
        dim_pop_boro.LandAcres
from inspection_data
inner join dim_pop_boro
on inspection_data.boro = dim_pop_boro.Borough
