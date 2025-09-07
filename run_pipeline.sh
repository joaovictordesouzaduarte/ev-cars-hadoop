#!/bin/bash
echo "Uploading data to the GCP Bucket"
# Uploading data to the GCP Bucket
python3 process_data.py

# Creating a JOB to insert data into Hive
# echo "Creating a JOB to insert data into Hive"
# chmod +x create_hive_job.sh
# ./create_hive_job.sh

# Running the JOB to insert data into Hive
# echo "Running the JOB to insert data into Hive"
# chmod +x run_hive_job.sh
# ./run_hive_job.sh

# echo "Inserting data into Hive"
# chmod +x run_hive_commands.sh
# ./run_hive_commands.sh

# echo "Inserting data into BigQuery"
# chmod +x run_bigquery_commands.sh
# ./run_bigquery_commands.sh