{#
    This macro returns the description of the payment_type 
#}

{% macro get_payment_status_description(payment_status) -%}

    case {{ dbt.safe_cast("payment_status", api.Column.translate_type("integer")) }}
        when 1 then 'Success'
        when 2 then 'Failed'
        else 'EMPTY'
    end

{%- endmacro %}