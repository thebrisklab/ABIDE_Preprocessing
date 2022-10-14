#!/bin/bash
cd /data/home4/risk_share/ImproveFConnASD/ABIDE/Liangkang/
scrub=("ABIDEI-KKI" "ABIDEII-KKI" "ABIDEI-NYU" "ABIDEII-NYU_1" "ABIDEII-NYU_2")
for i in ${scrub[@]}
do
	qsub ./bash/scrub.sh $i
done
