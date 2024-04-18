import pandas as pd
if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    # Specify your transformation logic here
    df_transactions = pd.DataFrame(data)

    df_transactions['promo_code'] = df_transactions['promo_code'].fillna(" ")
    df_transactions['item_price'] = df_transactions['item_price'].fillna(0)
    df_transactions['promo_amount'] = df_transactions['promo_amount'].fillna(0)
    df_transactions['shipment_fee'] = df_transactions['shipment_fee'].fillna(0)
    df_transactions['total_amount'] = df_transactions['total_amount'].fillna(0)

    #converting the data type of the year to int
    df_transactions['customer_id'] = df_transactions['customer_id'].astype(int)
    df_transactions['promo_amount'] = df_transactions['promo_amount'].astype(int)
    df_transactions['shipment_fee'] = df_transactions['shipment_fee'].astype(int)
    df_transactions['total_amount'] = df_transactions['total_amount'].astype(int)
    df_transactions['quantity'] = df_transactions['quantity'].astype(int)
    df_transactions['item_price'] = df_transactions['item_price'].astype(int)
    df_transactions['product_id'] = df_transactions['product_id'].astype(int)

    # filtering data
    df_transactions = df_transactions.drop(df_transactions[df_transactions['item_price']<= 0].index)
    df_transactions = df_transactions.drop(df_transactions[df_transactions['total_amount']<= 0].index)

    df_transactions.created_at = pd.to_datetime(df_transactions.created_at)
    df_transactions.shipment_date_limit = pd.to_datetime(df_transactions.shipment_date_limit)

    #removing null values
    df_transactions = df_transactions[~df_transactions['customer_id'].isnull()]
    df_transactions = df_transactions[~df_transactions['booking_id'].isnull()]
    df_transactions = df_transactions[~df_transactions['session_id'].isnull()]
    df_transactions = df_transactions[~df_transactions['product_id'].isnull()]

    return df_transactions


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
