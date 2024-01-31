#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=bowtie_idx
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,error
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_fastqc_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_fastqc_%j.e
#SBATCH --partition=pall

# Index the Flye and Canu files to prep Illumina polish

# Set working directory for output files
cd /data/users/ldekker/assembly_annotation_course/results/polishing

# Load bowtie module
module add UHTS/Aligner/bowtie2/2.3.4.1

# Flye
assembly_flye=/data/users/ldekker/assembly_annotation_course/results/assembly/flye
bowtie2-build --threads 4 ${assembly_flye}/assembly.fasta flye
	#threads = amount of cpu's
	#$assembly_flye = path to flye assemblies
	#flye = tag to name files

# Canu
assembly_canu=/data/users/ldekker/assembly_annotation_course/results/assembly/canu
bowtie2-build --threads 4 ${assembly_canu}/canu_pacbio.contigs.fasta canu




