{{
    config(
        materialized='table'
    )
}}

with 

products as (

    select *,
    row_number() over(partition by product_id) as rn
     from {{ source('staging', 'Product') }}
     where product_id is not null

)

select
    {{ dbt.safe_cast("product_id", api.Column.translate_type("integer")) }} as product_id,
    cast(gender as string) as gender,
    cast(mastercategory as string) as mastercategory,
    cast(subcategory as string) as subcategory,
    cast(articletype as string) as articletype,
    cast(basecolour as string) as basecolour,
    cast(season as string) as season,
    {{ dbt.safe_cast("year", api.Column.translate_type("integer")) }} as year,
    cast(usage as string) as usage,
    cast(productdisplayname as string) as productdisplayname,

from products
where rn = 1

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}