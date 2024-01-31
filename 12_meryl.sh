#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=06:00:00
#SBATCH --job-name=meryl
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_fastqc_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_fastqc_%j.e
#SBATCH --partition=pall

# Load meryl, a part of canu
module add UHTS/Assembler/canu/2.1.1

# Define input and output variables
INPUTDIR=/data/courses/assembly-annotation-course/raw_data/Cvi-0/participant_2/Illumina
	#not softlink
OUTPUTDIR=/data/users/ldekker/assembly_annotation_course/results/merqury_evaluation/meryl

# Set working directory for outpur files
#cd ${OUTPUTDIR}

# Run meryl and make a kmer database
meryl k=19 count output $SCRATCH/read_1.meryl ${INPUTDIR}/*1.fastq.gz
meryl k=19 count output $SCRATCH/read_2.meryl ${INPUTDIR}/*2.fastq.gz
meryl union-sum output ${OUTPUTDIR}/genome.meryl $SCRATCH/read*.meryl



