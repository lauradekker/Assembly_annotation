#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=flye
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,error
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_fastqc_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_fastqc_%j.e
#SBATCH --partition=pall


#Load fastqc module
module load UHTS/Assembler/flye/2.8.3

#Create data directory variables
WORKDIR=/data/users/ldekker/assembly_annotation_course
DATA=${WORKDIR}/participant_2/pacbio
RESULTS=${WORKDIR}/results/assembly/flye

#Set working directory
cd ${WORKDIR}

flye --pacbio-raw ${DATA}/ERR3415822.fastq.gz ${DATA}/ERR3415821.fastq.gz --out-dir ${RESULTS} --threads 16



