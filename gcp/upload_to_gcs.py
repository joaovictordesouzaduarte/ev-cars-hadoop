# Uploads data to a GCP bucket
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
    Uploads in-memory data (BytesIO) to a GCS bucket.

    Args:
        data_io: BytesIO object containing the data.
        bucket_name (str): Name of the GCS bucket.
        destination_blob_path (str): Path within the bucket where the data will be stored.
        service_account_json (str, optional): Path to the service account JSON file.
    """
    # Create GCS client
    if service_account_json:
        client = storage.Client.from_service_account_json(service_account_json)
    else:
        client = storage.Client()

    bucket = client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_path)

    # Detect IO type and upload
    if isinstance(data_io, BytesIO):
        blob.upload_from_file(data_io, rewind=True)
    elif isinstance(data_io, BytesIO):
        blob.upload_from_string(data_io.getvalue())
    else:
        raise ValueError("data_io must be a BytesIO object")

    print(f"✅ Data uploaded to '{destination_blob_path}' in bucket '{bucket_name}'.")

if __name__ == '__main__':
    pass