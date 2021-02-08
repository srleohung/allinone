#!/bin/bash

# Configuration parameter
source_path="/var/log/zakkaya"
file_path="zakkaya-gui.log.1.gz"
destination_path="/tmp/hft-data"
raw_data_path="output.txt"
csv_path="output.csv"

# Delete the old directory (if it exists)
if [ -d $destination_path ]; then
    rm -R $destination_path
fi

# Create a data directory, copy the original data to the directory and unzip
mkdir $destination_path
cp $source_path/*$file_path $destination_path
gunzip $destination_path/*

# Filter raw data
cat -A $destination_path/* | grep 'hftai-recommend' >$raw_data_path

# Set CSV header
echo "lunar_term,very_hot_warning,humidity,air_quality_index,gender,result,img_id,timestamp" >$csv_path

# Read raw data line by line
for ((i = 1; i <= $(wc -l $raw_data_path | awk '{print $1}'); i++)); do

    # Get column value
    record=$(head -n $i $raw_data_path | tail -n 1 | awk -F 'hftai-recommend: ' '{print $2}' | awk -F '","timestamp"' '{print $1}' | sed 's/\\//g')
    lunar_term=$(echo $record | jq .lunar_term)
    very_hot_warning=$(echo $record | jq .very_hot_warning)
    humidity=$(echo $record | jq .humidity)
    air_quality_index=$(echo $record | jq .air_quality_index)
    gender=$(echo $record | jq .gender)
    result=$(echo $record | jq .result)
    img_id=$(echo $record | jq .img_id)
    timestamp=$(head -n $i $raw_data_path | tail -n 1 | awk -F 'timestamp":"' '{print $2}' | awk -F '"}' '{print $1}')

    # Insert column value into CSV
    echo "$lunar_term,$very_hot_warning,$humidity,$air_quality_index,$gender,$result,$img_id,$timestamp" >>$csv_path

done
