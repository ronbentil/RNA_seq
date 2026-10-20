#!/bin/bash
cd $SLURM_SUBMIT_DIR
echo "running on"
hostname
source /usr/modules/init/bash

module load hisat2/2.2.1

# Define variables
TRIM_DIR="/mnt/ceph/bent4061/RNA_seq/7161/for_project/trimmed"
INDEX_PATH="/mnt/ceph/bent4061/RNA_seq/7161/for_project/trimmed/An_stephensi_ref"
# FIXED: output now goes to mapping_results/sam_files, where the SAMtools script looks for it
OUT_DIR="/mnt/ceph/bent4061/RNA_seq/7161/for_project/trimmed/mapping_results/sam_files"

# Create output directory if it doesn't exist
mkdir -p $OUT_DIR

# Loop over each single-end FASTQ file
# FIXED: full path to trimmed reads, so the script works from any submit folder
for FASTQ_FILE in $TRIM_DIR/REP*.fastq.gz; do
    # Extract sample name from the filename
    SAMPLE=$(basename $FASTQ_FILE .fastq.gz)

    # Run HISAT2 alignment for single-end reads
    hisat2 --dta -x $INDEX_PATH -U $FASTQ_FILE -S $OUT_DIR/$SAMPLE.sam --summary-file $OUT_DIR/$SAMPLE.summary.txt
done
echo "finished"
