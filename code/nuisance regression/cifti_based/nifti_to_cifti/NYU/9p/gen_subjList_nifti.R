rm(list = ls())

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEI-NYU/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

my_list=data.frame(subnames)

for (sub in subnames) {
  # nifti file
  file_list=list.files(paste0("fmriprep_preprocessed/36p/ABIDEI-NYU/",sub,"/cifti_based/"))
  nii_index=grep("9p.nii.gz",file_list)
  nii_name=file_list[nii_index][1]
  cat(nii_name,"\n")
  
  my_list$nii_nifti[which(my_list$subnames==sub)]=nii_name
  
  # cifti file template
  file_list=list.files(paste0("fmriprep_preprocessed/36p/ABIDEI-NYU/",sub,"/cifti_based/"))
  nii_index=grep("cifti_fake_template",file_list)
  nii_name=file_list[nii_index]
  cat(nii_name,"\n")
  
  my_list$nii_cifti[which(my_list$subnames==sub)]=nii_name
  
  cat("Capture ",sub,"!\n")
}

head(my_list)

# write the txt tile
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/script/cifti_based/nifti_to_cifti/NYU/9p")
write.table(my_list, file = "subjList_ABIDEI_nifti.txt",
            row.names = FALSE, col.names = FALSE,quote = FALSE)


setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-NYU_1/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

my_list=data.frame(subnames)

for (sub in subnames) {
  # nifti file
  file_list=list.files(paste0("fmriprep_preprocessed/36p/ABIDEII-NYU_1/",sub,"/cifti_based/"))
  nii_index=grep("9p.nii.gz",file_list)
  nii_name=file_list[nii_index][1]
  cat(nii_name,"\n")
  
  my_list$nii_nifti[which(my_list$subnames==sub)]=nii_name
  
  # cifti file template
  file_list=list.files(paste0("fmriprep_preprocessed/36p/ABIDEII-NYU_1/",sub,"/cifti_based/"))
  nii_index=grep("cifti_fake_template",file_list)
  nii_name=file_list[nii_index]
  cat(nii_name,"\n")
  
  my_list$nii_cifti[which(my_list$subnames==sub)]=nii_name
  
  cat("Capture ",sub,"!\n")
}

# write the txt tile
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/script/cifti_based/nifti_to_cifti/NYU/9p")
write.table(my_list, file = "subjList_ABIDEII_1_nifti.txt",
            row.names = FALSE, col.names = FALSE,quote = FALSE)


setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-NYU_2/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

my_list=data.frame(subnames)

for (sub in subnames) {
  # nifti file
  file_list=list.files(paste0("fmriprep_preprocessed/36p/ABIDEII-NYU_2/",sub,"/cifti_based/"))
  nii_index=grep("9p.nii.gz",file_list)
  nii_name=file_list[nii_index][1]
  cat(nii_name,"\n")
  
  my_list$nii_nifti[which(my_list$subnames==sub)]=nii_name
  
  # cifti file template
  file_list=list.files(paste0("fmriprep_preprocessed/36p/ABIDEII-NYU_2/",sub,"/cifti_based/"))
  nii_index=grep("cifti_fake_template",file_list)
  nii_name=file_list[nii_index]
  cat(nii_name,"\n")
  
  my_list$nii_cifti[which(my_list$subnames==sub)]=nii_name
  
  cat("Capture ",sub,"!\n")
}

# write the txt tile
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/script/cifti_based/nifti_to_cifti/NYU/9p")
write.table(my_list, file = "subjList_ABIDEII_2_nifti.txt",
            row.names = FALSE, col.names = FALSE,quote = FALSE)



