with 

source as (
    --checks for data with null camis id and for duplicated data 
    select * ,
    row_number() over(partition by camis, inspection_date) as rn
    from {{ source('staging', 'inspection_data') }}
    where camis is not null

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['camis', 'inspection_date']) }} as inspection_id,
        cast(camis as integer) as camis_id,
        cast(dba as text) as dba,
        cast(boro as text) as boro,
        cast(building as text) as building_number,
        cast(street as text) as street,
        cast(zipcode as text) as zipcode,
        cast(phone as text) as phone,
        cast(cuisine_description as text) as cuisine,
        cast(inspection_date as timestamp) as insepction_date,
        {{ get_inspection_performed("inspection_date") }} as inspection_performed,
        cast(action as text) as action_taken,
        cast(violation_code as text) as violation_code,
        cast(violation_description as text) as violation_description,
        cast(critical_flag as text) as critical_flag,
        cast(score as numeric) as score,
        cast(grade as text) as grade,
        cast(grade_date as timestamp) as grade_date,
        cast(record_date as timestamp) as record_date,
        cast(inspection_type as text) as inspection_type,
        cast(latitude as numeric) as latitude,
        cast(longitude as numeric) as longitude,
        cast(community_board as text) as community_board,
        cast(council_district as text) as council_district,
        cast(census_tract as text) as census_tract,
        cast(bin as text) as bin,
        cast(bbl as text) as bbl,
        cast(nta as text) as nta,
        cast(location_point1 as text) as location_point1,

    from source
    where rn = 1
)

select * from renamed

-- allows test run with limit of 100 using syntax below
-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}