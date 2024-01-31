#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=01:00:00
#SBATCH --job-name=bed_fasta
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_bed_fasta_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_bed_fasta_%j.e
#SBATCH --partition=pall

# Load module
module add UHTS/Analysis/SeqKit/0.13.2

# Directory and file shortcuts
WORKDIR=/data/users/ldekker/assembly_annotation_course
OUTPUTDIR=${WORKDIR}/results/genespace
INPUT_NOSEQ=${WORKDIR}/results/maker_prot_anno/pilon_flye.maker.output.renamed/pilon_flye.all.maker.noseq.gff.renamed.gff
INPUT_PROT=${WORKDIR}/results/maker_prot_anno/pilon_flye.maker.output.renamed/pilon_flye.all.maker.proteins.fasta.renamed.fasta

# Sort contigs by size
awk '$3=="contig"' ${INPUT_NOSEQ} | sort -t $'\t' -k5 -n -r > ${OUTPUTDIR}/Cvi_0_size_sorted_contigs.txt

# 10 longest contigs
head -n10 ${OUTPUTDIR}/Cvi_0_size_sorted_contigs.txt | cut -f1 > ${OUTPUTDIR}/Cvi_0_contigs.txt

# Create bed file
awk '$3=="mRNA"' ${INPUT_NOSEQ} | cut -f 1,4,5,9 | sed 's/ID=//' | sed 's/;.\+//' | grep -w -f ${OUTPUTDIR}/Cvi_0_contigs.txt > ${OUTPUTDIR}/bed/Cvi_0.bed

# Gene IDs
cut -f4 ${OUTPUTDIR}/bed/Cvi_0.bed > ${OUTPUTDIR}/Cvi_0_gene_IDs.txt

# Fasta file
cat ${INPUT_PROT} | seqkit grep -r -f ${OUTPUTDIR}/Cvi_0_gene_IDs.txt | seqkit seq -i > ${OUTPUTDIR}/peptide/Cvi_0.fa


