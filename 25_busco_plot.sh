#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=01:00:00
#SBATCH --job-name=busco_plot
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_XXXXX_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_XXXXX_%j.e
#SBATCH --partition=pall

# Add the modules
module add UHTS/Analysis/busco/4.1.4

# Generate plots
python3 10_b_generate_busco_plots.py -wd /data/users/ldekker/assembly_annotation_course/results/busco_quality/BUSCO_summaries


