#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=4000M
#SBATCH --time=01:00:00
#SBATCH --job-name=te_phylogeny
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_te_phyl_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_te_phyl_%j.e
#SBATCH --partition=pall

# Transposable elements phylogeny


# Load modules
module add UHTS/Analysis/SeqKit/0.13.2
module add SequenceAnalysis/MultipleSequenceAlignment/clustal-omega/1.2.4
module add Phylogeny/FastTree/2.1.10

# Define for which family and protein tag we are running
#FAMILY=gypsy
#PROT_TAG=Ty3-RT

FAMILY=copia
PROT_TAG=Ty1-RT

# Define directory and file shortcuts
COURSEDIR=/data/courses/assembly-annotation-course
WORKDIR=/data/users/ldekker/assembly_annotation_course
OUTDIR=${WORKDIR}/results/te_phylogeny/${FAMILY}
INPUT=${WORKDIR}/results/edta_annotation/te_sorter/*${FAMILY}.fasta.rexdb-plant.dom.faa
echo ${INPUT}

# Set working directory
cd ${OUTDIR}

# Extract protein sequences from .dom.faa files
grep ${FAMILY} ${INPUT} > ${FAMILY}_list.txt
sed -i 's/>//' ${FAMILY}_list.txt #remove '>' headers
sed -i 's/ .\+//' ${FAMILY}_list.txt #remove characters following an empty space
seqkit grep -f ${FAMILY}_list.txt ${INPUT} -o ${FAMILY}_RT.fasta
	# grep: search sequence by pattern, allow mismatches
	# -f: pattern file
	# -o: outputfile

# Shorten identifiers
sed -i 's/|.\+//' ${FAMILY}_RT.fasta # remove all characters after |


# Align sequences
clustalo -i ${FAMILY}_RT.fasta -o ${FAMILY}_protein_alignment.fasta
	# -i: multiple sequence input file
	# -o: alignment output file

# Create phylogenetic tree
FastTree -out ${FAMILY}_protein_alignment.tree ${FAMILY}_protein_alignment.fasta

	# -out: where to write the output to


