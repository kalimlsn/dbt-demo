
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

    select
    to_varchar(get_path(parse_json(_airbyte_data), '"base"')) as BASE,
    to_varchar(get_path(parse_json(_airbyte_data), '"date"')) as DATE,
    
        get_path(parse_json(table_alias._airbyte_data), '"rates"')
     as RATES,
    _AIRBYTE_AB_ID,
    _AIRBYTE_EMITTED_AT,
    convert_timezone('UTC', current_timestamp()) as _AIRBYTE_NORMALIZED_AT
from "WTTDEMO".PUBLIC._AIRBYTE_RAW_EXCHANGE_RATES as table_alias

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
