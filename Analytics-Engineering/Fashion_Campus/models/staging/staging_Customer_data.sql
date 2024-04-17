{{
    config(
        materialized='view'
    )
}}

with 

customer as (

    select *, 
    row_number() over(partition by customer_id, first_join_date) as rn
     from {{ source('staging', 'Customer') }}
     where customer_id is not null

)

select 
    --identifiers
    {{ dbt_utils.generate_surrogate_key(['customer_id', 'first_join_date']) }} as customer_unique_id, 
    {{ dbt.safe_cast("customer_id", api.Column.translate_type("integer")) }} as customer_id,

    -- dates
    cast(first_join_date as date) as first_join_date,
    cast(birthdate as date) as birthdate,

    -- customer details
    cast(first_name as string) as first_name,
    cast(last_name as string) as last_name,
    cast(username as string) as username,
    cast(email as string) as email,
    cast(gender as string) as gender,
    

    -- device details
    cast(device_id as string) as device_id,
    cast(device_type as string) as device_type,
    cast(device_version as string) as device_version,

    -- home details
    cast(home_location_lat as numeric) as home_location_lat,
    cast(home_location_long as numeric) as home_location_long,
    cast(home_location as string) as home_location,
    cast(home_country as string) as home_country

from customer
where rn = 1

-- dbt build --select <model.sql> --vars '{'is_test_run: false}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}
