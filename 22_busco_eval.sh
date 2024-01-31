#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=06:00:00
#SBATCH --job-name=busco_eval
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_busco_eval_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_busco_eval_%j.e
#SBATCH --partition=pall

# Load module
module add UHTS/Analysis/busco/4.1.4

# Define directory and file shortcuts
WORKDIR=/data/users/ldekker/assembly_annotation_course
OUTPUTDIR=${WORKDIR}/results/busco_eval
INPUT=/data/users/ldekker/assembly_annotation_course/results/maker_prot_anno/pilon_flye.maker.output.renamed/pilon_flye.all.maker.proteins.fasta.renamed.fasta

# Set working directory
cd ${OUTPUTDIR}

# Copy augustuc config
cp -r /software/SequenceAnalysis/GenePrediction/augustus/3.3.3.1/config augustus_config
export AUGUSTUS_CONFIG_PATH=./augustus_config

# Busco for quality assessment of assemblies
busco -i ${INPUT} -l brassicales_odb10 -o BUSCO -m proteins -c 8
	# -i: input file
	# -l: lineage specification
	# -o: name for output folder
	# -m: analysis mode
	# -c: number of threads (cpus)
