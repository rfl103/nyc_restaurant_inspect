import pandas as pd

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):

    #transform date columns to correct format

    data['inspection_data'] = pd.to_datetime(data['inspection_date']).dt.date
    data['grade_date'] = pd.to_datetime(data['grade_date']).dt.date

    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
