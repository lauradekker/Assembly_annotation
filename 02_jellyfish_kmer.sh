#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40000M
#SBATCH --time=01:00:00
#SBATCH --job-name=jellyfish
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_fastqc_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_fastqc_%j.e
#SBATCH --partition=pall

#Set working directory
cd /data/users/ldekker/assembly_annotation_course

#Load jellyfish module
module load UHTS/Analysis/jellyfish/2.3.0

#Define data and results directory as variables
DATA=/data/users/ldekker/assembly_annotation_course/participant_2
RESULTS=/data/users/ldekker/assembly_annotation_course/results/kmer_count

#Run jellyfish for each of the sequencing methods
for i in ${DATA}/*/
do i=${i%/} ; i=${i##*/} 	#Strip trailing / and get last directory of path
OUTDIR=${RESULTS}/${i}		#Create new directory for results per seq method
DATADIR=${DATA}/${i}
mkdir ${OUTDIR}
jellyfish count -C -m 19 -s 5G -t 10 -o ${OUTDIR}/reads.jf <(zcat ${DATADIR}/*)
jellyfish histo -t 10 ${OUTDIR}/reads.jf > ${OUTDIR}/reads.histo
done






