#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=5:00:00
#SBATCH --job-name=genespace
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_genespace_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_genespace_%j.e
#SBATCH --partition=pall

# Add module
module add UHTS/Analysis/SeqKit/0.13.2

# Directory and file shortcuts
WORKDIR=/data/users/ldekker/assembly_annotation_course
OUTPUTDIR=${WORKDIR}/results/genespace
GENESPACE_IMAGE=${WORKDIR}/scripts/genespace_1.1.4.sif
GENESPACE_SCRIPT=${WORKDIR}/scripts/genespace.R

# Run container and genespace script
apptainer exec \
--bind ${WORKDIR} \
${GENESPACE_IMAGE} Rscript ${GENESPACE_SCRIPT}

