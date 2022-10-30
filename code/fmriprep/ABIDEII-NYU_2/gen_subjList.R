# create subject list
path = "/home/jran2/risk_share/ImproveFConnASD/ABIDE/ABIDEII-NYU_2"
filenames = list.files(path, full.names = FALSE)

# exact sub-number
numbers = as.numeric(gsub("sub-", "", filenames))
# remove NAs
numbers = numbers[!is.na(numbers)]

# write the txt tile
setwd("/home/jran2/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-NYU_2/script")
write.table(numbers, file = "subjList.txt", sep = "\n", 
            row.names = FALSE, col.names = FALSE)