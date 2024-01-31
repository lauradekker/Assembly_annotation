#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=sam2bam
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,error
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_fastqc_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_fastqc_%j.e
#SBATCH --partition=pall

# Translate SAM files to BAM files

# Add samtools module
module add UHTS/Analysis/samtools/1.8

# Define directories
WORKDIR=/data/users/ldekker/assembly_annotation_course
DATADIR=${WORKDIR}/results/polishing

# Flye
#cd ${DATADIR}/flye
#samtools view -h -b -S -@ 16 -o flye_unsorted.bam flye.sam 
#samtools sort flye_unsorted.bam -o flye.bam
#samtools index flye.bam
 	#-h = header
	#-b = translate to bam
	#-S = sam file as input
	#-@ = amount of threads
	#-o = output file specification

# Canu
cd ${DATADIR}/canu
samtools view -h -b -S -@ 16 -o canu_unsorted.bam canu.sam
samtools sort canu_unsorted.bam -o canu.bam
samtools index canu.bam





