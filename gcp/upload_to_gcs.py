# Insere dados num bucket do gcp
import logging
from google.cloud import storage
from io import BytesIO

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)

def upload_to_gcs_from_io(
    data_io,
    bucket_name: str,
    destination_blob_path: str,
    service_account_json: str = None
):
    """
    Faz upload de dados em memória (BytesIO ou BytesIO) para um bucket do GCS.

    Args:
        data_io: BytesIO ou BytesIO com os dados.
        bucket_name (str): nome do bucket.
        destination_blob_path (str): caminho dentro do bucket.
        service_account_json (str, opcional): caminho para o JSON da service account.
    """
    # Cria cliente
    if service_account_json:
        client = storage.Client.from_service_account_json(service_account_json)
    else:
        client = storage.Client()

    bucket = client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_path)

    # Detecta tipo de IO e faz upload
    if isinstance(data_io, BytesIO):
        blob.upload_from_file(data_io, rewind=True)
    elif isinstance(data_io, BytesIO):
        blob.upload_from_string(data_io.getvalue())
    else:
        raise ValueError("data_io deve ser BytesIO ou BytesIO")

    print(f"✅ Dados enviados para '{destination_blob_path}' no bucket '{bucket_name}'.")

if __name__ == '__main__':
    pass