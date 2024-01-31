#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=12:00:00
#SBATCH --job-name=quast
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_fastqc_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_fastqc_%j.e
#SBATCH --partition=pall

# Run quast evaluation

# Define directories
WORKDIR=/data/users/ldekker/assembly_annotation_course
OUTPUTDIR=${WORKDIR}/results/quast_evaluation
FLYE_UNP=${WORKDIR}/results/assembly/flye/*.fasta
FLYE_POL=${WORKDIR}/results/polishing/flye/*.fasta
CANU_UNP=${WORKDIR}/results/assembly/canu/*.contigs.fasta
CANU_POL=${WORKDIR}/results/polishing/canu/*.fasta
REFGEN=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa

# Set working directory
cd ${OUTPUTDIR}

# Load module quast
module add UHTS/Quality_control/quast/4.6.0

# Quast without reference
python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py \
--est-ref-size 130000000 -e -m 3000 -i 500 -x 7000 -t \
-l flye_unp,flye_pol,canu_unp,canu_pol ${FLYE_UNP} ${FLYE_POL} ${CANU_UNP} ${CANU_POL}
	#--est-ref-size: rough genome size
	#-e: eukaryote genome
	#-m: minimum contig length
	#-i: minimum alignment length
	#-x: misassembly lower threshold
	#-t: threads/cpus
	#-l: labels for output

# Quast with reference
python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py \
-R ${REFGEN} -e -m 3000 -i 500 -x 7000 -t 8 \
-l flye_unp,flye_pol,canu_unp,canu_pol ${FLYE_UNP} ${FLYE_POL} ${CANU_UNP} ${CANU_POL}
	#-R: reference genome

