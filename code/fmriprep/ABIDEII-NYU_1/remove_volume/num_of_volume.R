# library
library(RNifti)
# remotes::install_github("jonclayden/RNifti")

# create subject list
path = "/home/jran2/risk_share/ImproveFConnASD/ABIDE/ABIDEII-NYU_1"
filenames = list.files(path, full.names = FALSE)

# exact sub-number
numbers = as.numeric(gsub("sub-", "", filenames))
# remove NAs
numbers = numbers[!is.na(numbers)]

# set working directory
filenames = paste0("sub-", numbers, "/ses-1/func/sub-", numbers, "_ses-1_task-rest_run-1_bold.nii.gz")

# the number of volumes
mat = matrix(nrow = length(numbers), ncol = 4)
for(i in 1:length(numbers)){
  # read nii.gz file
  setwd("/home/jran2/risk_share/ImproveFConnASD/ABIDE/ABIDEII-NYU_1")
  image = readNifti(filenames[i])
  # record dimensions
  mat[i,] = dim(image)
}

# the number of volumes are 180 for all but one subject
# for subj 29217, the number of volumes is 172

