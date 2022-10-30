# libraries
library(ciftiTools)
# set the wb_command path
ciftiTools.setOption("wb_path", "/usr/local/workbench")

## ABIDEI

# get subject list
setwd("/home/jran2/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEI-KKI/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]
# path header and out_header
path_header = "/home/jran2/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEI-KKI/derivatives"
out_header = "/home/jran2/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/ABIDEI-KKI"

# read and rewrite cifti file
for (sub in subnames) {
  # get cifti file name
  file_list=list.files(paste0("fmriprep_preprocessed/ABIDEI-KKI/derivatives/",sub,"/func/"))
  nii_index=grep("dtseries.nii",file_list)
  nii_name=file_list[nii_index]
  
  # path
  path = paste0(path_header, "/", sub, "/func/", nii_name)
  
  # read cifti file
  xii = read_xifti(path, brainstructures = "all")
  # select columns of a xifti
  xii_sub = select_xifti(xii, 2:dim(xii)[2])
  # write out
  write_xifti(xii_sub, paste0(out_header, "/", sub, "/cifti_based/", sub, "_cifti_fake_template"))
}

## ABIDEII

# get subject list
setwd("/home/jran2/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-KKI/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]
# path header and out_header
path_header = "/home/jran2/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-KKI/derivatives"
out_header = "/home/jran2/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/ABIDEII-KKI"

# read and rewrite cifti file
for (sub in subnames) {
  # get cifti file name
  file_list=list.files(paste0("fmriprep_preprocessed/ABIDEII-KKI/derivatives/",sub,"/ses-1/func/"))
  nii_index=grep("dtseries.nii",file_list)
  nii_name=file_list[nii_index]
  
  # path
  path = paste0(path_header, "/", sub, "/ses-1/func/", nii_name)
  
  # read cifti file
  xii = read_xifti(path, brainstructures = "all")
  # select columns of a xifti
  xii_sub = select_xifti(xii, 2:dim(xii)[2])
  # write out
  write_xifti(xii_sub, paste0(out_header, "/", sub, "/cifti_based/", sub, "_cifti_fake_template"))
}


