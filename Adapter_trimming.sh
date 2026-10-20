#!/bin/bash
cd $SLURM_SUBMIT_DIR
echo "running on"
hostname
source /usr/modules/init/bash

module load trimmomatic/0.39

# Define input directory
input_dir=$(pwd)

# Define output directory
output_dir="${input_dir}/trimmed"

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Define adapter file
adapter_file="adapters.fa"

# Loop through each .fastq.gz file in the input directory
# FIXED: *.gz -> *.fastq.gz so other .gz files are not picked up
for input_file in "$input_dir"/*.fastq.gz; do
    # Extract the file name without extension
    filename=$(basename "$input_file" .fastq.gz)

    # Define output file name
    output_file="${output_dir}/${filename}_trimmed.fastq.gz"

    # Run Trimmomatic
    trimmomatic SE -phred33 "$input_file" "$output_file" \
        ILLUMINACLIP:"$adapter_file":2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done
# FIXED: curly quotes replaced with straight quotes
echo "finished"
