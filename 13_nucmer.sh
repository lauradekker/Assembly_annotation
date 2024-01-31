#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=10:00:00
#SBATCH --job-name=nucmer
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_fastqc_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_fastqc_%j.e
#SBATCH --partition=pall

# Map assembled polished genomes against the reference genome and each other

# Load module
module add UHTS/Analysis/mummer/4.0.0beta1

# Define directories
WORKDIR=/data/users/ldekker/assembly_annotation_course
OUTPUTDIR=${WORKDIR}/results/mummer_compare
REFGEN=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
FLYE_POL=${WORKDIR}/results/polishing/flye/*.fasta
CANU_POL=${WORKDIR}/results/polishing/canu/*.fasta

# Set working directory
cd ${OUTPUTDIR}

# Run Flye vs. refgen
nucmer -b 1000 -c 1000 -p flye ${REFGEN} ${FLYE_POL}
	#-b: extension before giving in poor regions
	#-c: minimum cluster length
	#-p: name for the output files

# Run Canu vs. refgen
nucmer -b 1000 -c 1000 -p canu ${REFGEN} ${CANU_POL}

# Run Flye vs. Canu
nucmer -b 1000 -c 1000 -p flye_canu ${FLYE_POL} ${CANU_POL}


