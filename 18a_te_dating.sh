#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=4000M
#SBATCH --time=01:00:00
#SBATCH --job-name=te_dating
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_te_dating_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_te_dating_%j.e
#SBATCH --partition=pall

#Create conda environment before running this script
#Copy parseRM.pl into te_dating

# Execute script in 2 parts
# 1: perl
# 1.5: move landscape files to te_dating
# 2: sed

# Define directory and file shortcuts
COURSEDIR=/data/courses/assembly-annotation-course
WORKDIR=/data/users/ldekker/assembly_annotation_course
OUTPUTDIR=${WORKDIR}/results/te_dating
INPUT=${WORKDIR}/results/edta_annotation/pilon_flye.fasta.mod.EDTA.anno/pilon_flye.fasta.mod.out

# Set working directory
cd ${OUTPUTDIR}

# Split DNA by bins of divergence using the parseRM.pl script
#perl parseRM.pl -i ${INPUT} -l 50,1 -v
	# -i: define input file
	# -l: what amount of divergence or My to split the DNA amount on
	# -v: verbose mode

# Define output file to modify
OUTFILE=${OUTPUTDIR}/*.Rname.tab 

# Remove 1st and 3rd line from OUTFILE
sed '1d;3d' ${OUTFILE} > polished.fasta.Rname.tab




