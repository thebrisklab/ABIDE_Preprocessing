rm(list = ls())
library(neurobase)
library(oro.nifti)

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-NYU_2/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

for (sub in subnames) {
  funcname=list.files(paste0("ABIDEII-NYU_2/",sub,"/ses-1/func/"))
  path_name=paste0("ABIDEII-NYU_2/",sub,"/ses-1/func/",funcname)
  fmri_image = readnii(path_name)
  
  # dimension
  dim_fmri=dim(fmri_image)
  # calculate the mean time seires across voxels
  ts_mean = apply(fmri_image, MARGIN = 4, mean)
  
  png(filename = paste0("check_4_volumes/ABIDEII-NYU_2/",sub,"_Mean_series_plot.png"),width = 800, height = 350)
  plot(1:(dim(fmri_image)[4]), ts_mean, type = "l",xlab = "Time",ylab = "Mean Signal",main = paste0("Time series for ",sub))
  dev.off()
  
  cat("Plot is finished for ",sub,"!\n")
}
