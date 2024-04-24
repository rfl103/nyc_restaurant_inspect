import pandas as pd

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data(*args, **kwargs):
    
    """
    Pulls data from API endpoint.  The API default is to only pull 1,000 records.  May need to eventually adjust limir 
    parameter in order to pull complete dataset. 
    """

    url = "https://data.cityofnewyork.us/resource/43nn-pn8j.csv?$limit=300000"
    
    rest_dtypes = {
        'CAMIS': str,
        'DBA': str,
        'BORO': str,
        'BUILDING': str,
        'STREET': str,
        'ZIPCODE': str,
        'PHONE': str,
        'CUISINE DESCRIPTION': str,
        'INSPECTION DATE': str,
        'ACTION': str,
        'VIOLATION CODE': str,
        'VIOLATION DESCRIPTION': str,
        'CRITICAL FLAG': str,
        'SCORE': pd.Int64Dtype(),
        'GRADE': str,
        'GRADE DATE': str,
        'RECORD DATE': str,
        'INSPECTION TYPE': str,
        'Latitude': float,
        'Longitude': float,
        'Community Board': str,
        'Council District': str,
        'Census Tract': str,
        'BIN': str,
        'BBL': str,
        'NTA': str,
        'Location Point1': str

    }

    #parse_dates = ['INSPECTION DATE','GRADE DATE','RECORD DATE']

    return pd.read_csv(url, sep=',', dtype=rest_dtypes)


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
