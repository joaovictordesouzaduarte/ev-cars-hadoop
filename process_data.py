import pandas as pd
import re
from io import BytesIO
from gcp.upload_to_gcs import upload_to_gcs_from_io

BUCKET_NAME = 'ev-cars-bucket'

def _clean_market_region(value):
    # Capture anything inside parentheses
    matches = re.findall(r"\((.*?)\)", value)
    
    regions = []
    for m in matches:
        # If inside there are only acronyms (US/EU/UK/ME/CN/CA/JP etc.), keep them
        if re.match(r"^[A-Z/]+$", m):
            regions.append(m)
        # If it's text (discontinued, Limited), ignore
    
    # Remove all parentheses from the original text
    value = re.sub(r"\(.*?\)", "", value)
    
    # Join the pieces: original + valid regions
    full = value.strip()
    if regions:
        full += "/" + "/".join(regions)
    
    # Replace "/" with underscore
    full = full.replace("/", "_")
    # Remove double underscores and spaces
    full = re.sub(r"_+", "_", full).strip("_")
    
    return full

def process_charging_stations_df(df_charging_stations: pd.DataFrame) -> pd.DataFrame:
    
    # Convert "is_fast_dc" from boolean to int (0 = True, 1 = False)
    df_charging_stations['is_fast_dc'] = df_charging_stations['is_fast_dc'].astype(int)

    # Process power_class by removing values inside parentheses
    # Use regex to get only what is before the first parenthesis
    df_charging_stations['power_class'] = df_charging_stations['power_class'].str.extract(r'^([^(]+)_')
    return df_charging_stations

def process_electric_vehicles_models_df(df_electric_vehicles_models: pd.DataFrame) -> pd.DataFrame:  

    # Remove "/" from the origin_country column and replace with "_"
    df_electric_vehicles_models['origin_country'] = df_electric_vehicles_models['origin_country'].str.replace('/', '_')

    # Process market_regions
    # Replace "Global" and parentheses with nothing and "/" with "_" using regex
    df_electric_vehicles_models['market_regions'] = df_electric_vehicles_models['market_regions'].str \
        .replace(r'Global|Global\)', '', regex=True)
    df_electric_vehicles_models['market_regions'] = df_electric_vehicles_models['market_regions'].apply(_clean_market_region)
    return df_electric_vehicles_models

def process_world_summary_df(df_world_summary: pd.DataFrame) -> pd.DataFrame:
    return df_world_summary

def process_data_files():
    # Import charging stations data
    df_charging_stations = pd.read_csv('data/charging_stations_2025_world.csv')
    df_charging_stations = process_charging_stations_df(df_charging_stations)
    
    # Import electric vehicle models data
    df_eletric_vehicles_models = pd.read_csv('data/ev_models_2025.csv')
    df_eletric_vehicles_models = process_electric_vehicles_models_df(df_eletric_vehicles_models)

    # Import charging stations data again
    df_charging_stations = pd.read_csv('data/charging_stations_2025_world.csv')
    df_charging_stations = process_charging_stations_df(df_charging_stations)
    
    # Import country summary data
    df_country_summary = pd.read_csv('data/country_summary_2025.csv')

    # Import world summary data for 2025
    df_world_summary = pd.read_csv('data/world_summary_2025.csv')
    df_world_summary = process_world_summary_df(df_world_summary)

    # Create a dictionary with the data in IO and the file name
    data_dict = {
        'charging_stations_2025_world': df_charging_stations,
        'ev_models_2025': df_eletric_vehicles_models,
        'world_summary_2025': df_world_summary,
        'country_summary_2025': df_country_summary
    }
    return data_dict

def main():
    # Get and process the data
    data_dict = process_data_files()
    for key, value in data_dict.items():
        io = BytesIO()
        value.to_csv(io, index=False)
        try:
            print(f"Inserting data into GCS: {key}")
            upload_to_gcs_from_io(io, BUCKET_NAME, f'{key}.csv')
        except Exception as e:
            print(f"Error inserting data into GCS: {e}")
        finally:
            io.close()

if __name__ == '__main__':
    main()