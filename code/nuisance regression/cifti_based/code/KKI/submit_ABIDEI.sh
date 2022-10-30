#!/bin/bash

# when you execute this script on the cluster run this command
# chmod u+x submit_ABIDEI.sh
# ./submit_ABIDEI.sh

# scratch file
myscratch=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/scratch/cifti_ABIDEI

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
	qsub -o $myscratch/out/$subj.out -e $myscratch/err/$subj.err Subj_36p_ABIDEI.sh $subj $niifile
done < subjList_ABIDEI.txt


