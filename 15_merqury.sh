#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=10:00:00
#SBATCH --job-name=merqury
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_fastqc_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_fastqc_%j.e
#SBATCH --partition=pall

# Define directories
WORKDIR=/data/users/ldekker/assembly_annotation_course
INPUTDIR=${WORKDIR}/results/merqury_evaluation/meryl/genome.meryl
FLYE_UNP=${WORKDIR}/results/assembly/flye/*.fasta
FLYE_POL=${WORKDIR}/results/polishing/flye/*.fasta
CANU_UNP=${WORKDIR}/results/assembly/canu/*.contigs.fasta
CANU_POL=${WORKDIR}/results/polishing/canu/*.fasta
OUTPUTDIR=${WORKDIR}/results/merqury_evaluation

# Run merqury containers

# Flye unpolished
cd ${OUTPUTDIR}/flye_unpolished
apptainer exec \
--bind ${WORKDIR} \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh ${INPUTDIR} ${FLYE_UNP} flye_unpolished

# Flye polished
cd ${OUTPUTDIR}/flye_polished
apptainer exec \
--bind ${WORKDIR} \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh ${INPUTDIR} ${FLYE_POL} flye_polished

# Canu unpolished
cd ${OUTPUTDIR}/canu_unpolished
apptainer exec \
--bind ${WORKDIR} \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh ${INPUTDIR} ${CANU_UNP} canu_unpolished

# Canu polished
cd ${OUTPUTDIR}/canu_polished
apptainer exec \
--bind ${WORKDIR} \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh ${INPUTDIR} ${CANU_POL} canu_polished




