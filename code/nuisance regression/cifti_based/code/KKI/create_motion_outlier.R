# ABIDEI-KKI

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEI-KKI/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

cat("Create .spike regressors files for ABIDEI-KKI ! \n")
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed")

for (sub in subnames) {
  path_to_tsv_filenames=list.files(paste0("ABIDEI-KKI/derivatives/",sub,"/func/"))
  tsv_index=grep(".tsv",path_to_tsv_filenames)
  tsv_name=path_to_tsv_filenames[tsv_index]
  cat(tsv_name,"\n")
  
  path_name=paste0("ABIDEI-KKI/derivatives/",sub,"/func/",tsv_name)
  nuisance_tsv=read.table(path_name,header = T)
  
  # extract motion outliers column
  index = which(grepl("motion_outlier",colnames(nuisance_tsv)))
  
  # save
  write.table(nuisance_tsv[,index], paste0("36p/ABIDEI-KKI/",sub,"/nuisance/motion_outlier.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  cat(".1D files built for ",sub,"!\n")
}

# ABIDEII

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-KKI/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed")
cat("Create .1D files for ABIDEII-KKI ! \n")

for (sub in subnames) {
  path_to_tsv_filenames=list.files(paste0("ABIDEII-KKI/derivatives/",sub,"/ses-1/func/"))
  tsv_index=grep(".tsv",path_to_tsv_filenames)
  tsv_name=path_to_tsv_filenames[tsv_index]
  cat(tsv_name,"\n")
  
  path_name=paste0("ABIDEII-KKI/derivatives/",sub,"/ses-1/func/",tsv_name)
  nuisance_tsv=read.table(path_name,header = T)
  
  # extract motion outliers column
  index = which(grepl("motion_outlier",colnames(nuisance_tsv)))
  
  # save
  write.table(nuisance_tsv[,index], paste0("36p/ABIDEII-KKI/",sub,"/nuisance/motion_outlier.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  cat(".1D files built for ",sub,"!\n")
}

