# Anopheles stephensi RNA-seq analysis workflow after treatment with histamine and serotonin

This analysis workflow was used in a SLURM-based high-performance computing environment. It is not an automated, end-to-end pipeline. File paths, module names, and input patterns must be adapted before use.

It covers adapter trimming, reference-genome indexing, read alignment, alignment-file processing, transcript assembly, and abundance estimation.

## Repository contents

| File | Description |
| --- | --- |
| [Ref_genome_build.txt](Ref_genome_build.txt) | Reference-genome download and HISAT2 index build |
| [Adapter_trimming.sh](Adapter_trimming.sh) | Adapter trimming and read filtering with Trimmomatic |
| [Read_mapping.sh](Read_mapping.sh) | Read alignment with HISAT2 |
| [Transcript_quantification.txt](Transcript_quantification.txt) | SAM-to-BAM conversion, sorting, and indexing with SAMtools |
| [Running_stringtie.txt](Running_stringtie.txt) | Three StringTie scripts (01 assembly, 02 merge, 03 abundance estimation) |

## Workflow

1. Prepare the reference genome and HISAT2 index (`Ref_genome_build.txt`).
2. Trim adapters and filter reads (`Adapter_trimming.sh`).
3. Align trimmed reads to the reference genome (`Read_mapping.sh`).
4. Convert, sort, and index alignment files (`Transcript_quantification.txt`).
5. Assemble transcripts, merge assemblies, and estimate abundances (`Running_stringtie.txt`, scripts 01–03 in order).

## Requirements

Software:

1. Bash
2. Trimmomatic 0.39
3. HISAT2 2.2.1
4. SAMtools
5. StringTie
6. wget and unzip (for the reference download)

Inputs:

1. Single-end FASTQ files (`.fastq.gz`)
2. Adapter sequence file (`adapters.fa`)
3. Reference genome and annotation (NCBI GCF_013141755.1), downloaded by `Ref_genome_build.txt`

## Important notes

- Raw data are not included.
- Scripts use full paths beginning with `/mnt/ceph/bent4061/RNA_seq/7161/for_project/trimmed`. (May be replaced with your own project folder).
- Run `Adapter_trimming.sh` from the folder containing the raw FASTQ files and `adapters.fa`.
- `Read_mapping.sh` expects trimmed files named `REP*.fastq.gz`.
- The `.txt` files contain SLURM scripts; copy each script into its own `.sh` file before submitting.
- `Transcript_quantification.txt` processes alignment files; abundance estimation is done in StringTie script 03.
- Final abundance files were converted to CSV for differential gene expression analysis, which is not included here.
