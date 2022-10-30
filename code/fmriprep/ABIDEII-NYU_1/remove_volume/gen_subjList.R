rm(list = ls())

# library
library(stringr)

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-NYU_1/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

my_list=data.frame(subnames)
my_list$nii=NA

for(sub in subnames){
  # filename
  nii_name = list.files(paste0("ABIDEII-NYU_1/",sub,"/ses-1/func/"))
  nii_name = str_remove(nii_name, ".nii.gz")
  
  cat(nii_name,"\n")
  my_list$nii[which(my_list$subnames==sub)]=nii_name

  cat("Capture ",sub,"!\n")
}

head(my_list)

# write the txt tile
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-NYU_1/script/remove_volume")
write.table(my_list, file = "subjList_ABIDEII-NYU_1.txt",
            row.names = FALSE, col.names = FALSE,quote = FALSE)
