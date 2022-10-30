rm(list = ls())

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEI-KKI/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

my_list=data.frame(subnames)
my_list$nii=NA

for (sub in subnames) {
  file_list=list.files(paste0("fmriprep_preprocessed/36p/ABIDEI-KKI/",sub,"/cifti_based/"))
  nii_index=grep("cifti_to_nifti.nii.gz",file_list)
  nii_name=file_list[nii_index]
  cat(nii_name,"\n")

  my_list$nii[which(my_list$subnames==sub)]=nii_name

  cat("Capture ",sub,"!\n")
}

head(my_list)

# write the txt tile
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/script/cifti_based/code/KKI")
write.table(my_list, file = "subjList_ABIDEI.txt",
            row.names = FALSE, col.names = FALSE,quote = FALSE)


setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-KKI/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

my_list=data.frame(subnames)
my_list$nii=NA

for (sub in subnames) {
  file_list=list.files(paste0("fmriprep_preprocessed/36p/ABIDEII-KKI/",sub,"/cifti_based/"))
  nii_index=grep("cifti_to_nifti.nii.gz",file_list)
  nii_name=file_list[nii_index]
  cat(nii_name,"\n")

  my_list$nii[which(my_list$subnames==sub)]=nii_name

  cat("Capture ",sub,"!\n")
}

# write the txt tile
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/script/cifti_based/code/KKI")
write.table(my_list, file = "subjList_ABIDEII.txt",
            row.names = FALSE, col.names = FALSE,quote = FALSE)



