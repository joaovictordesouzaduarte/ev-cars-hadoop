import pandas as pd
import re
from io import BytesIO
from gcp.upload_to_gcs import upload_to_gcs_from_io

BUCKET_NAME = 'ev-cars-bucket'

def _clean_market_region(value):
    # Captura qualquer coisa entre parênteses
    matches = re.findall(r"\((.*?)\)", value)
    
    regions = []
    for m in matches:
        # Se dentro tiver só siglas (US/EU/UK/ME/CN/CA/JP etc.), mantemos
        if re.match(r"^[A-Z/]+$", m):
            regions.append(m)
        # Se for texto (discontinued, Limited), ignoramos
    
    # Remove todos os parênteses do texto original
    value = re.sub(r"\(.*?\)", "", value)
    
    # Junta os pedaços: original + regiões válidas
    full = value.strip()
    if regions:
        full += "/" + "/".join(regions)
    
    # Substitui "/" por vírgula
    full = full.replace("/", ",")
    # Remove vírgulas duplas e espaços
    full = re.sub(r",+", ",", full).strip(", ")
    
    return full

def process_charging_stations_df(df_charging_stations: pd.DataFrame) -> pd.DataFrame:
    
    # Tratando "is_fast_dc" de boolean para int (0 = True, 1 = False)
    df_charging_stations['is_fast_dc'] = df_charging_stations['is_fast_dc'].astype(int)

    # Tratando power_class removendo os valores entre ()
    # Utilizando regex para obter apenas o que está antes do primeiro parênteses
    df_charging_stations['power_class'] = df_charging_stations['power_class'].str.extract(r'^([^(]+)_')
    return df_charging_stations

def process_electric_vehicles_models_df(df_electric_vehicles_models: pd.DataFrame) -> pd.DataFrame:  

    # Removendo o / da coluna origin_country e substituindo por _
    df_electric_vehicles_models['origin_country'] = df_electric_vehicles_models['origin_country'].str.replace('/', '_')

    # Tratando market_regions
    # Substituindo "Global" e parenteses por nada e / por _ utilziando regex
    df_electric_vehicles_models['market_regions'] = df_electric_vehicles_models['market_regions'].str \
        .replace(r'Global|Global\)', '', regex=True)
    df_electric_vehicles_models['market_regions'] = df_electric_vehicles_models['market_regions'].apply(_clean_market_region)
    return df_electric_vehicles_models

def process_world_summary_df(df_world_summary: pd.DataFrame) -> pd.DataFrame:
    return df_world_summary

def process_data_files():
    # Importando dados de estações de carregamento
    df_charging_stations = pd.read_csv('data/charging_stations_2025_world.csv')
    df_charging_stations = process_charging_stations_df(df_charging_stations)
    
    # Importando dados de modelos de veículos elétricos
    df_eletric_vehicles_models = pd.read_csv('data/ev_models_2025.csv')
    df_eletric_vehicles_models = process_electric_vehicles_models_df(df_eletric_vehicles_models)

    # Importando dados de estações de carregamento
    df_charging_stations = pd.read_csv('data/charging_stations_2025_world.csv')
    df_charging_stations = process_charging_stations_df(df_charging_stations)
    
    # Importando dados de resumo dos países
    df_country_summary = pd.read_csv('data/country_summary_2025.csv')

    # Importando dados de resumo no mundo em 2025
    df_world_summary = pd.read_csv('data/world_summary_2025.csv')
    df_world_summary = process_world_summary_df(df_world_summary)

    # Criando dicionário com os dados em IO e o nome do arquivo
    data_dict = {
        'charging_stations_2025_world': df_charging_stations,
        'ev_models_2025': df_eletric_vehicles_models,
        'world_summary_2025': df_world_summary,
        'country_summary_2025': df_country_summary
    }
    return data_dict

def main():
    # Obtendo e processando os dados
    data_dict = process_data_files()
    
    for key, value in data_dict.items():
        io = BytesIO()
        value.to_csv(io, index=False)

        upload_to_gcs_from_io(io, BUCKET_NAME, f'{key}.csv')
        io.close()

if __name__ == '__main__':
    main()