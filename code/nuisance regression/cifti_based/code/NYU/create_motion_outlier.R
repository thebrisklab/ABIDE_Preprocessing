rm(list = ls())

# ABIDEI-NYU

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEI-NYU/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

cat("Create .1D files for ABIDEI-NYU ! \n")
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed")

for (sub in subnames) {
  path_to_tsv_filenames=list.files(paste0("ABIDEI-NYU/derivatives/",sub,"/func/"))
  tsv_index=grep(".tsv",path_to_tsv_filenames)
  tsv_name=path_to_tsv_filenames[tsv_index]
  cat(tsv_name,"\n")
  
  path_name=paste0("ABIDEI-NYU/derivatives/",sub,"/func/",tsv_name)
  nuisance_tsv=read.table(path_name,header = T)
  
  # extract motion outliers column
  index = which(grepl("motion_outlier",colnames(nuisance_tsv)))
  # save
  write.table(nuisance_tsv[,index], paste0("36p/ABIDEI-NYU/",sub,"/nuisance/motion_outlier.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  cat(".1D files built for ",sub,"!\n")
}

cat("#################### finish ABIDEI-NYU! ######################\n")


# ABIDEII-NYU_1

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-NYU_1/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed")
cat("Create .1D files for ABIDEII-NYU_1 ! \n")

for (sub in subnames) {
  path_to_tsv_filenames=list.files(paste0("ABIDEII-NYU_1/derivatives/",sub,"/ses-1/func/"))
  tsv_index=grep(".tsv",path_to_tsv_filenames)
  tsv_name=path_to_tsv_filenames[tsv_index]
  cat(tsv_name,"\n")
  
  path_name=paste0("ABIDEII-NYU_1/derivatives/",sub,"/ses-1/func/",tsv_name)
  nuisance_tsv=read.table(path_name,header = T)
  
  # extract motion outliers column
  index = which(grepl("motion_outlier",colnames(nuisance_tsv)))
  # save
  write.table(nuisance_tsv[,index],paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/motion_outlier.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  cat(".1D files built for ",sub,"!\n")
}
cat("#################### finish ABIDEII-NYU_1! ######################\n")



# ABIDEII-NYU_2

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-NYU_2/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed")
cat("Create .1D files for ABIDEII-NYU_2 ! \n")

for (sub in subnames) {
  path_to_tsv_filenames=list.files(paste0("ABIDEII-NYU_2/derivatives/",sub,"/ses-1/func/"))
  tsv_index=grep(".tsv",path_to_tsv_filenames)
  tsv_name=path_to_tsv_filenames[tsv_index]
  cat(tsv_name,"\n")
  
  path_name=paste0("ABIDEII-NYU_2/derivatives/",sub,"/ses-1/func/",tsv_name)
  nuisance_tsv=read.table(path_name,header = T)
  
  # extract motion outliers column
  index = which(grepl("motion_outlier",colnames(nuisance_tsv)))
  # save
  write.table(nuisance_tsv[,index],paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/motion_outlier.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  cat(".1D files built for ",sub,"!\n")
}
cat("#################### finish ABIDEII-NYU_2! ######################\n")



