#!/bin/bash

# when you execute this script on the cluster run this command
# chmod u+x submit_ABIDEI_cifti.sh
# ./submit_ABIDEI_cifti.sh

# scratch file
myscratch=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/scratch/cifti_based/ABIDEI-NYU_cifti_to_nifti

# if scratch directory doesn't exist, make it
[ ! -d ${myscratch} ] && mkdir ${myscratch}
[ ! -d ${myscratch}/out ] && mkdir ${myscratch}/out
[ ! -d ${myscratch}/err ] && mkdir ${myscratch}/err

# submit first batch of jobs
while read p; do
	subj=$(echo ${p} | cut -d ' ' -f 1)
	niifile=$(echo ${p} | cut -d ' ' -f 2)
	#echo $subj
	#echo $niifile
	qsub -o $myscratch/out/$subj.out -e $myscratch/err/$subj.err trans_ABIDEI.sh $subj $niifile
done < subjList_ABIDEI_cifti.txt


