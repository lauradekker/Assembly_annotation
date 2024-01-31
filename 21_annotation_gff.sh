#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=20:00:00
#SBATCH --job-name=anno_gff
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_anno_gff_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_anno_gff_%j.e
#SBATCH --partition=pall

# Load module
module add SequenceAnalysis/GenePrediction/maker/2.31.9

# Define directory and file shortcuts
COURSEDIR=/data/courses/assembly-annotation-course
WORKDIR=/data/users/ldekker/assembly_annotation_course
OUTPUTDIR=${WORKDIR}/results/maker_prot_anno/pilon_flye.maker.output.renamed
INPUT=${WORKDIR}/results/maker_prot_anno/pilon_flye.maker.output/pilon_flye_master_datastore_index.log

# Set working directory 
cd ${OUTPUTDIR}

# Make .gff and .fasta 
gff3_merge -d ${INPUT} -o pilon_flye.all.maker.gff
	# -d: path to input file
	# -o: name of output file

gff3_merge -d ${INPUT} -o pilon_flye.all.maker.noseq.gff
	# -n: dont print fasta seq in footer

fasta_merge -d ${INPUT} -o 'pilon_flye'

# Finish annotation
PROTEIN=pilon_flye.all.maker.proteins.fasta
TRANSCRIPT=pilon_flye.all.maker.transcripts.fasta
GFF=pilon_flye.all.maker.noseq.gff

cp ${PROTEIN} ${PROTEIN}.renamed.fasta
cp ${TRANSCRIPT} ${TRANSCRIPT}.renamed.fasta
cp ${GFF} ${GFF}.renamed.gff

maker_map_ids --prefix pilon_flye --justify 7 ${GFF}.renamed.gff > pilon_flye.id.map
	# --prefix: tag used for all ids
	# --justify: The unique integer portion of the ID will be right justified with '0's to this length (default = 8)

map_gff_ids pilon_flye.id.map ${GFF}.renamed.gff
map_fasta_ids pilon_flye.id.map ${PROTEIN}.renamed.fasta
map_fasta_ids pilon_flye.id.map ${TRANSCRIPT}.renamed.fasta





