#!/bin/bash
echo "Uploading data to the GCP Bucket"
# python3 process_data.py  

# Uploading files from GCS to HDFS
# echo "Creating a job in Dataproc to copy data from GCS to HDFS"
# gcloud dataproc jobs submit hadoop \
#     --cluster=hadoop-curso-infnet \
#     --region=us-central1 \
#     --class=org.apache.hadoop.tools.DistCp \
#     -- gs://ev-cars-bucket/* /user/hadoop/warehouse/input/processed
    
# Executing the DDL scripts to create the database and tables
echo "Creating the database"
gcloud dataproc jobs submit hive \
    --cluster=hadoop-curso-infnet \
    --region=us-central1 \
    --file=/home/joaovictor/projects/python/ev-cars-hadoop/gcp/jobs/dataproc/hive/ddl/create_database.sql

echo "Creating tables"
gcloud dataproc jobs submit hive \
    --cluster=hadoop-curso-infnet \
    --region=us-central1 \
    --file=/home/joaovictor/projects/python/ev-cars-hadoop/gcp/jobs/dataproc/hive/ddl/create_tables.sql

echo "Loading data into tables"
gcloud dataproc jobs submit hive \
    --cluster=hadoop-curso-infnet \
    --region=us-central1 \
    --file=/home/joaovictor/projects/python/ev-cars-hadoop/gcp/jobs/dataproc/hive/dml/load_data.sql

# Executing the analytics scripts
echo "Executing the analytics scripts"
gcloud dataproc jobs submit hive \
    --cluster=hadoop-curso-infnet \
    --region=us-central1 \
    --file=/home/joaovictor/projects/python/ev-cars-hadoop/gcp/jobs/dataproc/hive/scripts/analytics.sql

# echo "Dropping the database and tables"
# gcloud dataproc jobs submit hive \
#     --cluster=hadoop-curso-infnet \
#     --region=us-central1 \
#     --file=/home/joaovictor/projects/python/ev-cars-hadoop/gcp/jobs/dataproc/hive/ddl/drop_tables.sql

echo "Pipeline completed successfully"