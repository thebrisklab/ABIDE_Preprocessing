#!/bin/bash

# when you execute this script on the cluster run this command
# chmod u+x submit_ABIDEII_nifti.sh
# ./submit_ABIDEII_nifti.sh

# scratch file
myscratch=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/scratch/ABIDEII_nifti_to_cifti

# if scratch directory doesn't exist, make it
[ ! -d ${myscratch} ] && mkdir ${myscratch}
[ ! -d ${myscratch}/out ] && mkdir ${myscratch}/out
[ ! -d ${myscratch}/err ] && mkdir ${myscratch}/err

# submit first batch of jobs
while read p; do
	subj=$(echo ${p} | cut -d ' ' -f 1)
	niifile_nifti=$(echo ${p} | cut -d ' ' -f 2)
	niifile_cifti_temp=$(echo ${p} | cut -d ' ' -f 3)
	#echo $subj
	#echo $niifile_nifti
	#echo $niifile_cifti_temp
	qsub -o $myscratch/out/$subj.out -e $myscratch/err/$subj.err trans_ABIDEII.sh $subj $niifile_nifti $niifile_cifti_temp
done < subjList_ABIDEII_nifti.txt





