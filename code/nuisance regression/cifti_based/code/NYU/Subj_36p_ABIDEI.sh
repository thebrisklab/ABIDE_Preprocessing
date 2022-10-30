#!/bin/bash 

# Nuisance regression

## Modify for each subject:
subj=$1
niifile=$2
FWHM=6
#hp=0.009
#lp=0.08

# afnidir=/Users/ben/abin
afnidir=/usr/local/AFNI/linux_xorg7_64

# fsldir=/Users/brisk/Applications2/fsl/bin/
fsldir=/usr/local/fsl/bin

##########################################################################################################################
##---NUISANCE SIGNAL REGRESSION ----------------------------------------------------------------------------------------------------##
##########################################################################################################################

## BRisk: The F1000 pipelines uses segmentation and then intersects with FSL templates.
## The fsl templates have narrowly defined wm and csf using the mask (_bin) >=0.51. The Segmentation in fast captures a 
## lot of csf between the gray matter and skull, and is a little tricky to use due to partial volume effects. 
## Since the templates are conservative, and since we are using FNIRT, I do the averaging in 
## MNI space aligned volumes using the FSL (harvard) tissue priors

echo --------------------------------------------
echo !!!! RUNNING NUISANCE SIGNAL REGRESSION !!!!
echo --------------------------------------------

func_dir=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/ABIDEI-NYU
nuisance_dir=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/ABIDEI-NYU/${subj}/nuisance
out_dir=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/ABIDEI-NYU/${subj}/cifti_based

# remove automask

echo "Performing nuisance regression: cifti 9p, remove the first time point"

$afnidir/3dTproject -input ${func_dir}/${subj}/cifti_based/${niifile} \
	-prefix ${out_dir}/${subj}_9p.nii.gz \
	-polort 2 \
	-ort ${nuisance_dir}/global.1D ${nuisance_dir}/csf.1D ${nuisance_dir}/wm.1D ${nuisance_dir}/trans_x.1D ${nuisance_dir}/trans_y.1D ${nuisance_dir}/trans_z.1D ${nuisance_dir}/rot_x.1D ${nuisance_dir}/rot_y.1D ${nuisance_dir}/rot_z.1D \
	-overwrite \
	-verb \
	-CENSORTR *:0 \
	-cenmode KILL

echo "Performing nuisance regression: cifti 36p, remove the first time point"

$afnidir/3dTproject -input ${func_dir}/${subj}/cifti_based/${niifile} \
	-prefix ${out_dir}/${subj}_36p.nii.gz \
	-polort 2 \
	-ort ${nuisance_dir}/global.1D ${nuisance_dir}/global_2.1D ${nuisance_dir}/global_der.1D ${nuisance_dir}/global_der_2.1D ${nuisance_dir}/csf.1D ${nuisance_dir}/csf_2.1D ${nuisance_dir}/csf_der.1D ${nuisance_dir}/csf_der_2.1D ${nuisance_dir}/wm.1D ${nuisance_dir}/wm_2.1D ${nuisance_dir}/wm_der.1D ${nuisance_dir}/wm_der_2.1D ${nuisance_dir}/trans_x.1D ${nuisance_dir}/trans_x_2.1D ${nuisance_dir}/trans_x_der.1D ${nuisance_dir}/trans_x_der_2.1D ${nuisance_dir}/trans_y.1D ${nuisance_dir}/trans_y_2.1D ${nuisance_dir}/trans_y_der.1D ${nuisance_dir}/trans_y_der_2.1D ${nuisance_dir}/trans_z.1D ${nuisance_dir}/trans_z_2.1D ${nuisance_dir}/trans_z_der.1D ${nuisance_dir}/trans_z_der_2.1D ${nuisance_dir}/rot_x.1D ${nuisance_dir}/rot_x_2.1D ${nuisance_dir}/rot_x_der.1D ${nuisance_dir}/rot_x_der_2.1D ${nuisance_dir}/rot_y.1D ${nuisance_dir}/rot_y_2.1D ${nuisance_dir}/rot_y_der.1D ${nuisance_dir}/rot_y_der_2.1D ${nuisance_dir}/rot_z.1D ${nuisance_dir}/rot_z_2.1D ${nuisance_dir}/rot_z_der.1D ${nuisance_dir}/rot_z_der_2.1D \
	-overwrite \
	-verb \
	-CENSORTR *:0 \
	-cenmode KILL

echo "Performing nuisance regression: cifti 36p + spike regression, remove the first time point"

$afnidir/3dTproject -input ${func_dir}/${subj}/cifti_based/${niifile} \
	-prefix ${out_dir}/${subj}_36p_spike.nii.gz \
	-polort 2 \
	-ort ${nuisance_dir}/global.1D ${nuisance_dir}/global_2.1D ${nuisance_dir}/global_der.1D ${nuisance_dir}/global_der_2.1D ${nuisance_dir}/csf.1D ${nuisance_dir}/csf_2.1D ${nuisance_dir}/csf_der.1D ${nuisance_dir}/csf_der_2.1D ${nuisance_dir}/wm.1D ${nuisance_dir}/wm_2.1D ${nuisance_dir}/wm_der.1D ${nuisance_dir}/wm_der_2.1D ${nuisance_dir}/trans_x.1D ${nuisance_dir}/trans_x_2.1D ${nuisance_dir}/trans_x_der.1D ${nuisance_dir}/trans_x_der_2.1D ${nuisance_dir}/trans_y.1D ${nuisance_dir}/trans_y_2.1D ${nuisance_dir}/trans_y_der.1D ${nuisance_dir}/trans_y_der_2.1D ${nuisance_dir}/trans_z.1D ${nuisance_dir}/trans_z_2.1D ${nuisance_dir}/trans_z_der.1D ${nuisance_dir}/trans_z_der_2.1D ${nuisance_dir}/rot_x.1D ${nuisance_dir}/rot_x_2.1D ${nuisance_dir}/rot_x_der.1D ${nuisance_dir}/rot_x_der_2.1D ${nuisance_dir}/rot_y.1D ${nuisance_dir}/rot_y_2.1D ${nuisance_dir}/rot_y_der.1D ${nuisance_dir}/rot_y_der_2.1D ${nuisance_dir}/rot_z.1D ${nuisance_dir}/rot_z_2.1D ${nuisance_dir}/rot_z_der.1D ${nuisance_dir}/rot_z_der_2.1D ${nuisance_dir}/motion_outlier.1D \
	-overwrite \
	-verb \
	-CENSORTR *:0 \
	-cenmode KILL

# echo "Performing nuisance regression: volume 36p + temporal filtering, remove the first time point"

# $afnidir/3dTproject -input ${func_dir}/${subj}/cifti_based/${niifile} \
# 	-prefix ${out_dir}/${subj}_36p_tf.nii.gz \
# 	-polort 2 \
# 	-ort ${nuisance_dir}/global.1D ${nuisance_dir}/global_der.1D ${nuisance_dir}/csf.1D ${nuisance_dir}/csf_der.1D ${nuisance_dir}/wm.1D ${nuisance_dir}/wm_der.1D ${nuisance_dir}/trans_x.1D ${nuisance_dir}/trans_x_der.1D ${nuisance_dir}/trans_y.1D ${nuisance_dir}/trans_y_der.1D ${nuisance_dir}/trans_z.1D ${nuisance_dir}/trans_z_der.1D ${nuisance_dir}/rot_x.1D ${nuisance_dir}/rot_x_der.1D ${nuisance_dir}/rot_y.1D ${nuisance_dir}/rot_y_der.1D ${nuisance_dir}/rot_z.1D ${nuisance_dir}/rot_z_der.1D \
# 	-passband $hp $lp \
# 	-overwrite \
# 	-verb \
# 	-CENSORTR *:0 \
# 	-cenmode KILL

# echo "Performing nuisance regression: volume 36p + temporal filtering + 6 mm fwhm spatial smoothing, remove the first time point"
# ## Spatial smoothing:
# $afnidir/3dTproject -input ${func_dir}/${subj}/cifti_based/${niifile} \
# 	-prefix ${out_dir}/${subj}_36p_tf_6sm.nii.gz \
# 	-polort 2 \
# 	-ort ${nuisance_dir}/global.1D ${nuisance_dir}/global_der.1D ${nuisance_dir}/csf.1D ${nuisance_dir}/csf_der.1D ${nuisance_dir}/wm.1D ${nuisance_dir}/wm_der.1D ${nuisance_dir}/trans_x.1D ${nuisance_dir}/trans_x_der.1D ${nuisance_dir}/trans_y.1D ${nuisance_dir}/trans_y_der.1D ${nuisance_dir}/trans_z.1D ${nuisance_dir}/trans_z_der.1D ${nuisance_dir}/rot_x.1D ${nuisance_dir}/rot_x_der.1D ${nuisance_dir}/rot_y.1D ${nuisance_dir}/rot_y_der.1D ${nuisance_dir}/rot_z.1D ${nuisance_dir}/rot_z_der.1D\
# 	-passband $hp $lp \
# 	-blur $FWHM \
# 	-overwrite \
# 	-verb \
# 	-CENSORTR *:0 \
# 	-cenmode KILL
	


