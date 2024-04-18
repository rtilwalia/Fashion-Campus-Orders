import pandas as pd
import json
if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):

    df_product = pd.DataFrame(data)

    #columns that has null values
    df_product['usage'] = df_product['usage'].fillna(0) 
    df_product['baseColour'] = df_product['baseColour'].fillna(" ")
    df_product['season'] = df_product['season'].fillna(" ")
    df_product['productDisplayName'] = df_product['productDisplayName'].fillna(" ")
    df_product['year'] = df_product['year'].fillna(0)

    #converting the data type of the year to int
    df_product['year'] = df_product['year'].astype(int)

    #changing the name of the id column
    df_product = df_product.rename(columns={'id': 'product_id'})

    #cleaning the data
    #year should not be less than 2000
    df_product = df_product.drop(df_product[df_product['year']<= 2000].index)

    #product_id should not be null
    df_product = df_product[~df_product['product_id'].isnull()]
    
    return df_product


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
