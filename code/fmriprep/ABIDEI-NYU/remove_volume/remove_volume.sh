#!/bin/bash 

# which subject to analyze through input
subj=$1
niifile=$2
# root directory
root_dir=/home/jran2/risk_share/ImproveFConnASD/ABIDE/ABIDEI-NYU

# afnidir directory
afnidir=/usr/local/AFNI/linux_xorg7_64

# fsldir=/Users/brisk/Applications2/fsl/bin/
fsldir=/usr/local/fsl/bin

echo ---------------------------------
echo !!!! Remove first two TRs !!!!
echo ---------------------------------

# set working directory
cwd=${root_dir}/${subj}/func
cd $cwd

# totoal number of volumes
n_vols=179

# remove first 2 TRs
$afnidir/3dcalc -a ${niifile}.nii.gz[2..${n_vols}] -expr 'a' -prefix ${niifile}.nii.gz -overwrite


	


