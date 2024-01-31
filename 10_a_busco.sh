#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=busco_pol
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_fastqc_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_fastqc_%j.e
#SBATCH --partition=pall

# Run Busco on polished & unpolished assemblies

# Load module
module add UHTS/Analysis/busco/4.1.4

# Define directories
WORKDIR=/data/users/ldekker/assembly_annotation_course
OUTPUTDIR=${WORKDIR}/results/busco_quality
FLYE_UNP=${WORKDIR}/results/assembly/flye
FLYE_POL=${WORKDIR}/results/polishing/flye
CANU_UNP=${WORKDIR}/results/assembly/canu
CANU_POL=${WORKDIR}/results/polishing/canu
TRINITY=${WORKDIR}/results/assembly/trinity

# Copy augustus config directory
cd ${OUTPUTDIR}
cp -r /software/SequenceAnalysis/GenePrediction/augustus/3.3.3.1/config augustus_config
export AUGUSTUS_CONFIG_PATH=./augustus_config


# Run busco for unpolished assemblies

# Flye
#busco -i ${FLYE_UNP}/*.fasta -o flye_unpolished --lineage brassicales_odb10 -m genome --cpu 16

# Canu
#busco -i ${CANU_UNP}/*.contigs.fasta -o canu_unpolished --lineage brassicales_odb10 -m genome --cpu 16

# Trinity
#busco -i ${TRINITY}/*.fasta -o trinity_rnaseq --lineage brassicales_odb10 -m transcriptome --cpu 16


# Run busco for polished assemblies

# Flye
busco -i ${FLYE_POL}/*.fasta -o flye_polished --lineage brassicales_odb10 -m genome --cpu 16

# Canu
busco -i ${CANU_POL}/*.fasta -o canu_polished --lineage brassicales_odb10 -m genome --cpu 16


# Remove augustus
rm -r ./augustus_config
