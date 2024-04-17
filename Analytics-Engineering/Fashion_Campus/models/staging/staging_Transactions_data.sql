{{
    config(
        materialized='view'
    )
}}

with 
transactions as (
    select *,
    row_number() over(partition by booking_id, created_at) as rn
    from {{ source('staging', 'Transactions') }}
    where booking_id is not null 
)

select

    --identifiers
    {{ dbt_utils.generate_surrogate_key(['booking_id', 'created_at']) }} as transaction_id,
    {{ dbt.safe_cast("customer_id", api.Column.translate_type("integer")) }} as customer_id,
    cast(booking_id as string) as booking_id,
    cast(session_id as string) as session_id,
    {{ dbt.safe_cast("product_id", api.Column.translate_type("integer")) }} as product_id,

    --timestamps
    cast(created_at as timestamp) as created_at,
    cast(shipment_date_limit as timestamp) as shipment_date_limit,
    cast(date_diff(shipment_date_limit, created_at, day) as integer) as shipment_days,

    --shipment location
    cast(shipment_location_lat as string) as shipment_location_lat,
    cast(shipment_location_long as string) as shipment_location_long,

    --payment info
    cast(payment_method as string) as payment_method,
    cast(payment_status as string) as payment_status,
    cast(promo_code as string) as promo_code,
    {{ dbt.safe_cast("quantity", api.Column.translate_type("integer")) }} as quantity,

    --bill info
    cast(promo_amount as numeric) as promo_amount,
    cast(shipment_fee as numeric) as shipment_fee,
    cast(item_price as numeric) as item_price,
    cast(total_amount as numeric) as total_amount

from transactions
where rn = 1

--dbt build --select <model_name> --vars '{'is_test_run':'false'}'
{% if var('is_test_run', default=true) %}
    limit 100
{% endif %}