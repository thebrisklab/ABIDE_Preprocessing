rm(list = ls())

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEI-NYU/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

my_list=data.frame(subnames)
my_list$nii=NA

for (sub in subnames) {
  file_list=list.files(paste0("fmriprep_preprocessed/ABIDEI-NYU/derivatives/",sub,"/func/"))
  nii_index=grep("preproc_bold.nii.gz",file_list)
  nii_name=file_list[nii_index]
  cat(nii_name,"\n")

  my_list$nii[which(my_list$subnames==sub)]=nii_name

  cat("Capture ",sub,"!\n")
}

head(my_list)

# write the txt tile
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/script/volume_based/code/NYU")
write.table(my_list, file = "subjList_ABIDEI-NYU.txt",
            row.names = FALSE, col.names = FALSE,quote = FALSE)
cat("#################### finish ABIDEI-NYU! ######################\n")


setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-NYU_1/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

my_list=data.frame(subnames)
my_list$nii=NA

for (sub in subnames) {
  file_list=list.files(paste0("fmriprep_preprocessed/ABIDEII-NYU_1/derivatives/",sub,"/ses-1/func/"))
  nii_index=grep("preproc_bold.nii.gz",file_list)
  nii_name=file_list[nii_index]
  cat(nii_name,"\n")

  my_list$nii[which(my_list$subnames==sub)]=nii_name

  cat("Capture ",sub,"!\n")
}

# write the txt tile
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/script/volume_based/code/NYU")
write.table(my_list, file = "subjList_ABIDEII-NYU_1.txt",
            row.names = FALSE, col.names = FALSE,quote = FALSE)
cat("#################### finish ABIDEII-NYU_1! ######################\n")


setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-NYU_2/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

my_list=data.frame(subnames)
my_list$nii=NA

for (sub in subnames) {
  file_list=list.files(paste0("fmriprep_preprocessed/ABIDEII-NYU_2/derivatives/",sub,"/ses-1/func/"))
  nii_index=grep("preproc_bold.nii.gz",file_list)
  nii_name=file_list[nii_index]
  cat(nii_name,"\n")
  
  my_list$nii[which(my_list$subnames==sub)]=nii_name
  
  cat("Capture ",sub,"!\n")
}

# write the txt tile
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/script/volume_based/code/NYU")
write.table(my_list, file = "subjList_ABIDEII-NYU_2.txt",
            row.names = FALSE, col.names = FALSE,quote = FALSE)
cat("#################### finish ABIDEII-NYU_2! ######################\n")

