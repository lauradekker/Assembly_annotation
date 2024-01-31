#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=10:00:00
#SBATCH --job-name=bowtie_align
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_fastqc_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_fastqc_%j.e
#SBATCH --partition=pall

# Align Illumina

# Load bowtie module
module add UHTS/Aligner/bowtie2/2.3.4.1

# Define directories for input and output
WORKDIR=/data/users/ldekker/assembly_annotation_course
INPUTDIR=${WORKDIR}/participant_2/Illumina
OUTPUTDIR=${WORKDIR}/results/polishing

# Flye
cd ${OUTPUTDIR}/flye

bowtie2 -p 4 -x flye -1 ${INPUTDIR}/*_1* -2 ${INPUTDIR}/*_2* \
-S flye.sam --sensitive-local
	#-p = amount of threads
	#-x = basename of indeces files
	#-1 -2 = path to illumina input files
	#-S = specify SAM format for output
	#--sensitive-local = automatic settings i dont fully get

# Canu
cd ${OUTPUTDIR}/canu

bowtie2 -p 4 -x canu -1 ${INPUTDIR}/*_1* -2 ${INPUTDIR}/*_2* \
-S canu.sam --sensitive-local





