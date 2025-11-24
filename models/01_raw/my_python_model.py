# models/staging/stg_exchange_rates.py

import requests
import pandas as pd
from datetime import datetime


def model(dbt, session):
    """
    Fetch exchange rates from a free API and return as DataFrame
    """

    api_url = "https://api.exchangerate-api.com/v4/latest/USD"

    # Fetch data from API
    response = requests.get(api_url, timeout=10)
    response.raise_for_status()
    data = response.json()

    # Extract base currency and date
    base_currency = data.get('base', 'USD')
    rate_date = data.get('date')
    last_updated = data.get('time_last_updated')

    # Convert rates dict to DataFrame
    rates = data.get('rates', {})

    rows = []
    for currency, rate in rates.items():
        rows.append({
            'base_currency': base_currency,
            'rate_date': pd.to_datetime(rate_date),
            'currency_code': currency,
            'exchange_rate': float(rate),
            'last_updated_timestamp': pd.to_datetime(last_updated, unit='s') if last_updated else None,
            'loaded_at': pd.Timestamp.now(),
            'inverse_rate': 1.0 / float(rate) if rate != 0 else None
        })

    df = pd.DataFrame(rows)

    return df

# Configure the model
def config():
    return {
        "materialized": "table",
        "tags": ["api", "exchange_rates"],
    }

if __name__ == "__main__":
    df = model(None, '')
    print(df)