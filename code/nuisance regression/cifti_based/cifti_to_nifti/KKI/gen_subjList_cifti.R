rm(list = ls())

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEI-KKI/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

my_list=data.frame(subnames)
my_list$nii=NA

for (sub in subnames) {
  file_list=list.files(paste0("fmriprep_preprocessed/ABIDEI-KKI/derivatives/",sub,"/func/"))
  nii_index=grep("dtseries.nii",file_list)
  nii_name=file_list[nii_index]
  cat(nii_name,"\n")

  my_list$nii[which(my_list$subnames==sub)]=nii_name

  cat("Capture ",sub,"!\n")
}

head(my_list)

# write the txt tile
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/script/cifti_based/cifti_to_nifti/KKI")
write.table(my_list, file = "subjList_ABIDEI_cifti.txt",
            row.names = FALSE, col.names = FALSE,quote = FALSE)


setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-KKI/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

my_list=data.frame(subnames)
my_list$nii=NA

for (sub in subnames) {
  file_list=list.files(paste0("fmriprep_preprocessed/ABIDEII-KKI/derivatives/",sub,"/ses-1/func/"))
  nii_index=grep("dtseries.nii",file_list)
  nii_name=file_list[nii_index]
  cat(nii_name,"\n")

  my_list$nii[which(my_list$subnames==sub)]=nii_name

  cat("Capture ",sub,"!\n")
}

# write the txt tile
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/script/cifti_based/cifti_to_nifti/KKI")
write.table(my_list, file = "subjList_ABIDEII_cifti.txt",
            row.names = FALSE, col.names = FALSE,quote = FALSE)



