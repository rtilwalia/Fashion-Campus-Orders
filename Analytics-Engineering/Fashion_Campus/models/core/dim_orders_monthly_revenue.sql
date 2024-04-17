{{
    config(
        materialized='table'
    )
}}

with orders_data as (
    select * from {{ ref('fact_orders') }}
)

select 
    -- Reveneue grouping 
    product_id,
    {{ dbt.date_trunc("month", "order_date") }} as order_month, 
    {{ dbt.date_trunc("year", "order_date") }} as order_year,
    gender,
    mastercategory,

    --revenue calculations
    sum(promo_amount) as revenue_promo_amount,
    sum(shipment_fee) as revenue_shipment_fee,
    sum(item_price) as revenue_item_price,
    sum(total_amount) as revenue_total_amount,

    --other calculations
    count(product_id) as total_monthly_product,
    avg(shipment_days) as avg_shipment_days,
    avg(quantity) as avg_quantity

from orders_data
group by 1,2,3,4,5