rm(list = ls())

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEI-KKI/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/ABIDEI-KKI")

for (sub in subnames) {
  dir.create(sub)
  dir.create(paste0(sub,"/nuisance"))
  dir.create(paste0(sub,"/volume_based"))
  dir.create(paste0(sub,"/cifti_based"))
  cat("Floder built for ",sub,"!\n")
}

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-KKI/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/ABIDEII-KKI")

for (sub in subnames) {
  dir.create(sub)
  dir.create(paste0(sub,"/nuisance"))
  dir.create(paste0(sub,"/volume_based"))
  dir.create(paste0(sub,"/cifti_based"))
  cat("Floder built for ",sub,"!\n")
}
