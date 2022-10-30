#!/bin/bash

# when you execute this script on the cluster run this command
# chmod u+x submit.sh
# ./submit.sh

# scratch file
myscratch=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-NYU_2/scratch

# if scratch directory doesn't exist, make it
[ ! -d ${myscratch} ] && mkdir ${myscratch}
[ ! -d ${myscratch}/out ] && mkdir ${myscratch}/out
[ ! -d ${myscratch}/err ] && mkdir ${myscratch}/err

# submit first batch of jobs
for subj in `cat subjList.txt`; do
 	qsub -o $myscratch/out/$subj.out -e $myscratch/err/$subj.err fmriprep_Subj.sh $subj
done





