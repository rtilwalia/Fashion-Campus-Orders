{#
    This macro returns the description of the payment_method
#}

{% macro get_payment_method_description(payment_method) -%}

    case {{ dbt.safe_cast("payment_method", api.Column.translate_type("integer")) }} 
        when 1 then 'Credit Card'
        when 2 then 'OVO'
        when 3 then 'Gopay'
        when 4 then 'Debit Card'
        when 5 then 'LinkAja'
        else 'EMPTY'
    end

{%- endmacro %}
