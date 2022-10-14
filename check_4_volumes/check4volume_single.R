library(neurobase)
library(oro.nifti)

# read image
fmri_image = readnii("sub-29287/ses-1/func/sub-29287_ses-1_task-rest_acq-rc8chan_run-1_bold.nii.gz")

# dimension
dim(fmri_image)
# calculate the mean time seires across voxels
ts_mean = apply(fmri_image, MARGIN = 4, mean)

png(filename = "sub-29287/Mean_series_plot.png",width = 800, height = 350)
plot(1:156, ts_mean, type = "l",xlab = "Time",ylab = "Mean Signal",main = paste0("Time series for sub-29287"))
dev.off()
