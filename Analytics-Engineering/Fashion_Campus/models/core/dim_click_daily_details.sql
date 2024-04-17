{{
    config(
        materialized='table'
    )
}}

with click_details as
(
    select * from {{ ref('staging_clickstream_data') }}
)

select
    event_name,
    {{ dbt.date_trunc("day", "event_time") }} as event_date, 
    traffic_source,
    product_id,
    count(product_id) as product_clicks_per_day,


from click_details
group by 1,2,3,4