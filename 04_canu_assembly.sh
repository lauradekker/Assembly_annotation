#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=01:00:00
#SBATCH --job-name=canu
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,error
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_fastqc_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_fastqc_%j.e
#SBATCH --partition=pall


#Load fastqc module
module load UHTS/Assembler/canu/2.1.1

#Create data directory variables
WORKDIR=/data/users/ldekker/assembly_annotation_course
DATA=${WORKDIR}/participant_2
RESULTS=${WORKDIR}/results/assembly/canu

#Set working directory
cd ${WORKDIR}

#Run canu
canu \
 -p canu_pacbio -d ${RESULTS} \
 genomeSize=125m \
 -pacbio ${DATA}/pacbio/* \
 maxThreads=16 \
 maxMemory=64 \
 gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY" \
 gridOptions="--mail-user=laura.dekker@students.unibe.ch"
	#-p: names used for end and intermediate files
	#-d: directory used to deposit results in
	#-pacbio: define data input type and input directory


