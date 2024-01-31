#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=30G
#SBATCH --time=10:00:00
#SBATCH --job-name=te_sort
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_te_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_te_%j.e
#SBATCH --partition=pall

# Load modules
module load UHTS/Analysis/SeqKit/0.13.2

# Define directories
COURSEDIR=/data/courses/assembly-annotation-course
WORKDIR=/data/users/ldekker/assembly_annotation_course
OUTPUTDIR=${WORKDIR}/results/edta_annotation/te_sorter
ANNODIR=${COURSEDIR}/CDS_annotation/TAIR10_cds_20110103_representative_gene_model_update
GENOMEDIR=${WORKDIR}/results/edta_annotation

# Set working directory
cd ${OUTPUTDIR}

# Subset fasta into 2 for Copia and Gypsy
cat ${GENOMEDIR}/*.mod.EDTA.TElib.fa | seqkit grep -r -p ^*Copia* > polished_assembly_copia.fasta
cat ${GENOMEDIR}/*.mod.EDTA.TElib.fa | seqkit grep -r -p ^*Gypsy* > polished_assembly_gypsy.fasta

# Run for both .fasta
# Run singularity for TEsorter
singularity exec \
--bind $COURSEDIR \
--bind $WORKDIR \
${COURSEDIR}/containers2/TEsorter_1.3.0.sif \
TEsorter polished_assembly_copia.fasta -db rexdb-plant -p 20

singularity exec \
--bind $COURSEDIR \
--bind $WORKDIR \
${COURSEDIR}/containers2/TEsorter_1.3.0.sif \
TEsorter polished_assembly_gypsy.fasta -db rexdb-plant -p 20

# Set new working directory
cd brassica_data

cat $COURSEDIR/CDS_annotation/Brassicaceae_repbase_all_march2019.fasta | seqkit grep -r -p ^*Copia* > brassicaceae_copia.fasta
cat $COURSEDIR/CDS_annotation/Brassicaceae_repbase_all_march2019.fasta | seqkit grep -r -p ^*Gypsy* > brassicaceae_gypsy.fasta

singularity exec \
--bind $COURSEDIR \
--bind $WORKDIR \
${COURSEDIR}/containers2/TEsorter_1.3.0.sif \
TEsorter brassicaceae_copia.fasta -db rexdb-plant -p 20

singularity exec \
--bind $COURSEDIR \
--bind $WORKDIR \
${COURSEDIR}/containers2/TEsorter_1.3.0.sif \
TEsorter brassicaceae_gypsy.fasta -db rexdb-plant -p 20








