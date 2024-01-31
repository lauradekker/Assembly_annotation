#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40000M
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,error
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_fastqc_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_fastqc_%j.e
#SBATCH --partition=pall

#Set working directory
cd /data/users/ldekker/assembly_annotation_course

#Load fastqc module
module load UHTS/Quality_control/fastqc/0.11.9

#Create data directory variables
DATA=/data/users/ldekker/assembly_annotation_course/participant_2
RESULTS=/data/users/ldekker/assembly_annotation_course/qc

#Loop over the directories
for i in ${DATA}/*/
do i=${i%/} ; i=${i##*/} 	#Strip trailing / and get last directory of path
mkdir ${RESULTS}/${i}		#Create new directory for results per seq method
fastqc -t 2 ${DATA}/${i}/* -o ${RESULTS}/${i} 	#Run fastqc
	# -t 2 specifies to run 2 files simultaneously (2 in each directory)
	# ${DATA}/${i}/* specifies the input files
	# -o specifies the output directory
done


