#!/usr/bin/env bash

#SBATCH --ntasks-per-node=16
#SBATCH --mem-per-cpu=12G
#SBATCH --nodes=1
#SBATCH --time=20:00:00
#SBATCH --job-name=maker_anno
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/ldekker/assembly_annotation_course/output/output_maker_%j.o
#SBATCH --error=/data/users/ldekker/assembly_annotation_course/errors/error_maker_%j.e
#SBATCH --partition=pall

# Protein annotation pipeline


# Add modules
module add SequenceAnalysis/GenePrediction/maker/2.31.9

# Define directory and file shortcuts
COURSEDIR=/data/courses/assembly-annotation-course
SOFTWARE=/software
WORKDIR=/data/users/ldekker/assembly_annotation_course
OUTPUTDIR=${WORKDIR}/results/maker_prot_anno

# Enter output directory
cd ${OUTPUTDIR}

# Create control files
#singularity exec \
#--bind $SCRATCH \
#--bind ${COURSEDIR} \
#--bind ${WORKDIR} \
#--bind ${SOFTWARE} \
#${COURSEDIR}/containers2/MAKER_3.01.03.sif \
#maker -CTL #create empty control files

# Run maker with mpi singularity
mpiexec -n 16 singularity exec \
--bind $SCRATCH \
--bind ${COURSEDIR} \
--bind ${WORKDIR} \
--bind ${SOFTWARE} \
${COURSEDIR}/containers2/MAKER_3.01.03.sif \
maker -mpi maker_opts.ctl maker_bopts.ctl maker_exe.ctl





