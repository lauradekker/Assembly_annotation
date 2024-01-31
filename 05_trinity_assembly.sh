#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=trinity
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,error
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_fastqc_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_fastqc_%j.e
#SBATCH --partition=pall


#Load fastqc module
module load UHTS/Assembler/trinityrnaseq/2.5.1

#Create data directory variables
WORKDIR=/data/users/ldekker/assembly_annotation_course
DATA=${WORKDIR}/participant_2/RNAseq
RESULTS=${WORKDIR}/results/assembly/trinity

#Set working directory
cd ${WORKDIR}

#Run trinity
Trinity --seqType fq --left ${DATA}/*_1.fastq.gz --right ${DATA}/*_2.fastq.gz --CPU 6 --max_memory 20G --output ${RESULTS}


