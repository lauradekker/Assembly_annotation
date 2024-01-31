#!/usr/bin/env bash

#SBATCH --cpus-per-task=30
#SBATCH --mem=10G
#SBATCH --time=20:00:00
#SBATCH --job-name=uniprot
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_uniprot_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_uniprot_%j.e
#SBATCH --partition=pall

# Load module
module add Blast/ncbi-blast/2.10.1+

# Directory and file shortcuts
WORKDIR=/data/users/ldekker/assembly_annotation_course
OUTPUTDIR=${WORKDIR}/results/uniprot_eval
BLASTDIR=${OUTPUTDIR}/blastdb
INPUT=${WORKDIR}/results/maker_prot_anno/pilon_flye.maker.output.renamed/pilon_flye.all.maker.proteins.fasta.renamed.fasta
UNIPROTDB=/data/courses/assembly-annotation-course/CDS_annotation/MAKER/uniprot_viridiplantae_reviewed.fa

# Set working directory
cd ${OUTPUTDIR}

# Proteins to Uniprot database
makeblastdb -in ${UNIPROTDB} -dbtype prot -out ${BLASTDIR}/uniprot.db
	# -in: uniprot reviewed data
	# -dbtype: type of database
	# -out: output directory and file name

blastp -query ${INPUT} -db ${BLASTDIR}/uniprot.db -num_threads 30 -outfmt 6 -evalue 1e-10 -out ${OUTPUTDIR}/blastp.out

