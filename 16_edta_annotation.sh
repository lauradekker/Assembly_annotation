#!/usr/bin/env bash

#SBATCH --cpus-per-task=50
#SBATCH --mem=10G
#SBATCH --time=05:00:00
#SBATCH --job-name=EDTA
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_edta%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_edta_%j.e
#SBATCH --partition=pall

#Define directories
COURSEDIR=/data/courses/assembly-annotation-course
WORKDIR=/data/users/ldekker/assembly_annotation_course
FLYE_POL=${WORKDIR}/results/polishing/flye/*.fasta
CDS_GENE=${COURSEDIR}/CDS_annotation/TAIR10_cds_20110103_representative_gene_model_updated
OUTPUTDIR=${WORKDIR}/results/edta_annotation

# Set working directory for output
cd ${OUTPUTDIR}

# Run singularity for the annotation
echo "singularity exec \
--bind $COURSEDIR \
--bind $WORKDIR \
$COURSEDIR/containers2/EDTA_v1.9.6.sif \
EDTA.pl \
--genome ${FLYE_POL} \
--species others \
--step filter \
--cds ${CDS_GENE} \
--anno 1 \
--threads 50"
#--force 1



