--Loading in the seed file with the population data

{{ config(materialized='table') }}

select 
    Year,
    GeoType,
    Borough,
    Name,
    Pop1,
    PopAcre,
    LandAcres
from {{ ref('pop_boro') }}