# library
library(RNifti)
# remotes::install_github("jonclayden/RNifti")

# create subject list
path = "/home/jran2/risk_share/ImproveFConnASD/ABIDE/ABIDEI-NYU"
filenames = list.files(path, full.names = FALSE)

# exact sub-number
numbers = as.numeric(gsub("sub-", "", filenames))
# remove NAs
numbers = numbers[!is.na(numbers)]

# set working directory
filenames = paste0("sub-00", numbers, "/func/sub-00", numbers, "_task-rest_run-1_bold.nii.gz")

# the number of volumes
mat = matrix(nrow = length(numbers), ncol = 4)
for(i in 1:length(numbers)){
  # read nii.gz file
  setwd("/home/jran2/risk_share/ImproveFConnASD/ABIDE/ABIDEI-NYU")
  image = readNifti(filenames[i])
  # record dimensions
  mat[i,] = dim(image)
}

# the number of volumes are all 180
# same as the json file

