#!/bin/bash 

# arguments
subj=$1
niifile_nifti=$2
niifile_cifti_temp=$3

# applications
afnidir=/usr/local/AFNI/linux_xorg7_64
fsldir=/usr/local/fsl/bin

# basic settings
dir=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/ABIDEII-KKI/${subj}/cifti_based

# transfer cifti file to fake nifti file
wb_command -cifti-convert -from-nifti ${dir}/${niifile_nifti} ${dir}/${niifile_cifti_temp} ${dir}/${subj}_36p_spike.dtseries.nii
