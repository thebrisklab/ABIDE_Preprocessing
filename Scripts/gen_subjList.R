# create subject list
path = "/data/home4/risk_share/ImproveFConnASD/ABIDE/ABIDEII-KKI"
filenames = list.files(path, full.names = FALSE)

# exact sub-number
numbers = as.numeric(gsub("sub-", "", filenames))
# remove NAs
numbers = numbers[!is.na(numbers)]
# add 00 to the front
#numbers = paste0("00", numbers)

# write the txt tile
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-KKI/script")
write.table(numbers, file = "subjList.txt", sep = "\n", 
            row.names = FALSE, col.names = FALSE)