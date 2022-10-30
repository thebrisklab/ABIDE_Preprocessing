rm(list = ls())

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEI-NYU/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/ABIDEI-NYU")

for (sub in subnames) {
  dir.create(sub)
  dir.create(paste0(sub,"/nuisance"))
  dir.create(paste0(sub,"/volume_based"))
  dir.create(paste0(sub,"/cifti_based"))
  cat("Floder built for ",sub,"!\n")
}

cat("####################Finish ABIDEI-NYU!######################\n")

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-NYU_1/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/ABIDEII-NYU_1")

for (sub in subnames) {
  dir.create(sub)
  dir.create(paste0(sub,"/nuisance"))
  dir.create(paste0(sub,"/volume_based"))
  dir.create(paste0(sub,"/cifti_based"))
  cat("Floder built for ",sub,"!\n")
}
cat("####################Finish ABIDEII-NYU1!######################\n")

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-NYU_2/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/ABIDEII-NYU_2")

for (sub in subnames) {
  dir.create(sub)
  dir.create(paste0(sub,"/nuisance"))
  dir.create(paste0(sub,"/volume_based"))
  dir.create(paste0(sub,"/cifti_based"))
  cat("Floder built for ",sub,"!\n")
}
cat("####################Finish ABIDEII-NYU2!######################\n")