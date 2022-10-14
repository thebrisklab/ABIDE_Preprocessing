#!/bin/bash

# user inputs:
# dataset directory
bids_root_dir=/data/home4/risk_share/ImproveFConnASD/ABIDE/ABIDEII-KKI
# which subject to analyze through input
subj=29426
# number of processors to use
nthreads=4
# number of memory to use in GB
mem=20 

# reformat mem variable to remove GB at the end
# so that it can be read by fmri-prep without causing erros
mem=`echo "${mem//[!0-9]/}"` 
# convert virtual memory from gb to mb
# reduce some memory for buffer space during pre-processing
mem_mb=`echo $(((mem*1000)-5000))` 

# export TEMPLATEFLOW_HOME=$HOME/.cache/templateflow
export FS_LICENSE=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-KKI/derivatives/license.txt

# run fmriprep
# co-registration, normalization, physilogically component extration
source ~/.bash_profile
fmriprep-docker $bids_root_dir /data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-KKI/derivatives \
  participant \
  --no-tty \
  --participant-label $subj \
  --skip-bids-validation \
  --md-only-boilerplate \
  --fs-license-file /data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-KKI/derivatives/license.txt \
  --output-spaces MNI152NLin2009cAsym:res-2 \
  --nthreads $nthreads \
  --stop-on-first-crash \
  --mem_mb $mem_mb \
  --cifti-output
