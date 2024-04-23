#!/bin/bash
cd $SLURM_SUBMIT_DIR
echo "running on"
hostname
source /usr/modules/init/bash

module load hisat2/2.2.1

# Define variables
INDEX_PATH="/mnt/ceph/bent4061/RNA_seq/7161/for_project/trimmed/An_stephensi_ref"
OUT_DIR="mapping_results"

# Create output directory if it doesn't exist
mkdir -p $OUT_DIR

# Loop over each single-end FASTQ file
for FASTQ_FILE in REP*.fastq.gz; do
    # Extract sample name from the filename
    SAMPLE=$(basename $FASTQ_FILE .fastq.gz)

    # Run HISAT2 alignment for single-end reads
    hisat2 --dta -x $INDEX_PATH -U $FASTQ_FILE -S $OUT_DIR/$SAMPLE.sam --summary-file $OUT_DIR/$SAMPLE.summary.txt
done
echo "finished"
