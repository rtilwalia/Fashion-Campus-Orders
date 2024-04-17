{{
    config(
        materialized='table'
    )
}}

with customer_data as (
    select *,
    from {{ ref('staging_Customer_data') }}
),

product_data as (
    select *,
    from {{ ref('staging_Product_data') }}
),

clickstream_data as (
    select *,
    from {{ ref('staging_clickstream_data') }}
),

transaction_data as (
    select *,
    from {{ ref('staging_Transactions_data') }}
)

select 
    cd.customer_unique_id,
    td.customer_id,
    td.product_id,
    cld.clickstream_id,
    td.session_id,
    cld.event_id,
    td.transaction_id,
    td.booking_id,
    pd.gender,
    pd.mastercategory,
    pd.subcategory,
    pd.articletype,
    pd.basecolour,
    pd.season,
    pd.usage,
    pd.productdisplayname,
    td.created_at as order_date,
    td.shipment_date_limit,
    td.shipment_days,
    td.shipment_location_lat,
    td.shipment_location_long,
    cd.home_location_lat,
    cd.home_location_long,
    td.payment_method,
    -- td.payment_method_description,
    td.payment_status,
    -- td.payment_status_description,
    td.promo_code,
    pd.year as product_release_year,
    td.quantity,
    td.promo_amount,
    td.shipment_fee,
    td.item_price,
    td.total_amount
from transaction_data td 
left join customer_data cd on td.customer_id = cd.customer_id
left join clickstream_data cld on td.session_id = cld.session_id
left join product_data pd on td.product_id = pd.product_id
