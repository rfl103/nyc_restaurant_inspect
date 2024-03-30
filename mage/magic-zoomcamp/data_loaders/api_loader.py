import pandas as pd
from sodapy import Socrata

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data(*args, **kwargs):
    
    client = Socrata("data.cityofnewyork.us", None)

    results = client.get("43nn-pn8j", limit=300000)

    # Convert to pandas DataFrame
    results_df = pd.DataFrame.from_records(results)

    return {}


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
