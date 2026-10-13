# Anopheles stephensi RNA seq analysis workflow after treatment with histamine and serotonin


The analysis workflow documented here were used in a SLURM-based high-performance computing environment. It is not currently
an automated, end-to-end pipeline. File paths, module names, and input patterns must be adapted before use.

This includes adapter trimming, reference-genome indexing, read alignment, alignment-file processing, transcript assembly, and abundance estimation


## Repository contents



## Workflow

1. Prepare the reference genome and HISAT2 index.
2. Trim adapters and filter reads.
3. Align trimmed reads to the reference genome.
4. Convert, sort, and index alignment files.
5. Assemble transcripts, merge assemblies, and estimate abundances.


## Input requirements

1. Bash
2. Trimmomatic 0.39
3. HISAT2 2.2.1
4. SAMtools
5. StringTie
6. Single-end FASTQ files, adapter sequences, and reference genome
  and annotation files


## Important notes
Raw data are not included
  
