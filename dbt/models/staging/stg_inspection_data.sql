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
        cast(dba as string) as dba,
        cast(boro as string) as boro,
        cast(building as string) as building_number,
        cast(street as string) as street,
        cast(zipcode as string) as zipcode,
        cast(phone as string) as phone,
        cast(cuisine_description as string) as cuisine,
        cast(inspection_date as timestamp) as insepction_date,
        {{ get_inspection_performed("inspection_date") }} as inspection_performed,
        cast(action as string) as action_taken,
        cast(violation_code as string) as violation_code,
        cast(violation_description as string) as violation_description,
        cast(critical_flag as string) as critical_flag,
        cast(score as numeric) as score,
        cast(grade as string) as grade,
        cast(grade_date as timestamp) as grade_date,
        cast(record_date as timestamp) as record_date,
        cast(inspection_type as string) as inspection_type,
        cast(latitude as numeric) as latitude,
        cast(longitude as numeric) as longitude,
        cast(community_board as string) as community_board,
        cast(council_district as string) as council_district,
        cast(census_tract as string) as census_tract,
        cast(bin as string) as bin,
        cast(bbl as string) as bbl,
        cast(nta as string) as nta,
        cast(location_point1 as string) as location_point1,

    from source
    where rn = 1
)

select * from renamed

-- allows test run with limit of 100 using syntax below
-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}