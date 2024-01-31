#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=01:00:00
#SBATCH --job-name=mummerplot
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_mummer_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_mummer_%j.e
#SBATCH --partition=pall

# Define directories
WORKDIR=/data/users/ldekker/assembly_annotation_course
OUTPUTDIR=${WORKDIR}/results/mummer_compare/rerun
REFGEN=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
FLYE_POL=${WORKDIR}/results/polishing/flye/*.fasta
CANU_POL=${WORKDIR}/results/polishing/canu/*.fasta
REFFLYE_NUC=${WORKDIR}/results/mummer_compare/flye.delta
REFCANU_NUC=${WORKDIR}/results/mummer_compare/canu.delta
FLYE_CANU_NUC=${WORKDIR}/results/mummer_compare/flye_canu.delta

# Load module
module add UHTS/Analysis/mummer/4.0.0beta1
export PATH=/software/bin:$PATH

# Run mummer for Flye, Canu and the reference genome

cd ${OUTPUTDIR}

# Ref vs Flye
#cd ${OUTPUTDIR}/ref_flye
mummerplot -R ${REFGEN} -Q ${FLYE_POL} -f -t png -s large -l -p ref_flye ${REFFLYE_NUC}

# Ref vs Canu
#cd ${OUTPUTDIR}/ref_canu
mummerplot -R ${REFGEN} -Q ${CANU_POL} -f -t png -s large -l -p ref_canu ${REFCANU_NUC}

# Flye vs Canu
#cd ${OUTPUTDIR}/flye_canu
mummerplot -R ${FLYE_POL} -Q ${CANU_POL} -f -t png -s large -l -p flye_canu ${FLYE_CANU_NUC}


