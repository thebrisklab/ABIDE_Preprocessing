# create subject list
path = "/home/jran2/risk_share/ImproveFConnASD/ABIDE/ABIDEI-NYU"
filenames = list.files(path, full.names = FALSE)

# exact sub-number
numbers = as.numeric(gsub("sub-", "", filenames))
# remove NAs
numbers = numbers[!is.na(numbers)]

# write the txt tile
setwd("/home/jran2/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEI-NYU/script")
write.table(numbers, file = "subjList.txt", sep = "\n", 
            row.names = FALSE, col.names = FALSE)