#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=pilon
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_fastqc_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_fastqc_%j.e
#SBATCH --partition=pall

# Assembly improvement with Pilon

# Define directory paths
WORKDIR=/data/users/ldekker/assembly_annotation_course
INPUTDIR=${WORKDIR}/results/assembly
OUTPUTDIR=${WORKDIR}/results/polishing

# Flye
#java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar \
#--genome ${INPUTDIR}/flye/assembly.fasta --frags ${OUTPUTDIR}/flye/flye.bam \
#--output pilon_flye --outdir ${OUTPUTDIR}/flye --threads 16
	#--genome = assembly input
	#--frags = BAM files of assembled illumina
	#--output = name for outputfile
	#--outdir = directory to put output

# Canu
java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar \
--genome ${INPUTDIR}/canu/*.contigs.fasta --frags ${OUTPUTDIR}/canu/canu.bam \
--output pilon_canu --outdir ${OUTPUTDIR}/canu --threads 16


