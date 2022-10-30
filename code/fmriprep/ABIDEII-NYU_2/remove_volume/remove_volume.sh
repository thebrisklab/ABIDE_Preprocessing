#!/bin/bash 

# which subject to analyze through input
subj=$1
niifile=$2
# root directory
root_dir=/home/jran2/risk_share/ImproveFConnASD/ABIDE/ABIDEII-NYU_2

# afnidir directory
afnidir=/usr/local/AFNI/linux_xorg7_64

# fsldir=/Users/brisk/Applications2/fsl/bin/
fsldir=/usr/local/fsl/bin

echo ---------------------------------
echo !!!! Remove first two TRs !!!!
echo ---------------------------------

echo $subj

# set working directory
cwd=${root_dir}/${subj}/ses-1/func
cd $cwd

if [ "$subj" == sub-29151 ]
then 
# remove first 2 TRs
$afnidir/3dcalc -a ${niifile}.nii.gz[2..160] -expr 'a' -prefix ${niifile}.nii.gz -overwrite
else
# remove first 2 TRs
$afnidir/3dcalc -a ${niifile}.nii.gz[2..179] -expr 'a' -prefix ${niifile}.nii.gz -overwrite
fi



	


