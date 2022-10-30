#!/bin/bash 

# arguments
subj=$1
niifile=$2

# applications
afnidir=/usr/local/AFNI/linux_xorg7_64
fsldir=/usr/local/fsl/bin

# basic settings
func_dir=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-NYU_2/derivatives
out_dir=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/ABIDEII-NYU_2/${subj}/cifti_based

# transfer cifti file to fake nifti file
wb_command -cifti-convert -to-nifti ${func_dir}/${subj}/ses-1/func/${niifile} ${out_dir}/${subj}_cifti_to_nifti.nii.gz
