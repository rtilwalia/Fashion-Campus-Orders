{{
    config(
        materialized='view'
    )
}}

with 
clickstream as (

    select *,
    row_number() over(partition by event_id, event_time) as rn
    from {{ source('staging', 'clickstream') }}
    where event_id is not null

)

select 
    -- identifiers
    {{ dbt_utils.generate_surrogate_key(['event_id', 'event_time']) }} as clickstream_id,
    cast(session_id as string) as session_id,
    coalesce({{ dbt.safe_cast("product_id", api.Column.translate_type("integer")) }},0) as product_id,
    cast(event_id as string) as event_id,
    
    -- events
    cast(event_name as string) as event_name,
    cast(event_time as timestamp) as event_time,

    -- click info
    cast(traffic_source as string) as traffic_source,
    cast(search_keywords as string) as search_keywords,

    -- payment details
    {{ dbt.safe_cast("quantity", api.Column.translate_type("integer")) }} as quantity,
    cast(item_price as numeric) as item_price,
    cast(payment_status as string) as payment_status,
    cast(promo_code as string) as promo_code,
    cast(promo_amount as numeric) as promo_amount,

from clickstream
where rn = 1

-- dbt build --select <model.sql> --vars '{'is_test_run: false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}
