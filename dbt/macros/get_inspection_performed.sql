{#
    This macro returns if no inspection has been performed. 
#}

{% macro get_inspection_performed(inspection_date) -%}

    case {{ dbt.safe_cast("inspection_date", api.Column.translate_type("string")) }}  
        when '1900-01-01T00:00:00.000' then 'No'
        else 'Yes'
    end

{%- endmacro %}