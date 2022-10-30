#Utils

### Get the timepoint to do correlation matrix with different scrubbing criteria.
timepoint <- function(site_id,sub_id){
  setwd(paste0("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/",site_id,"/derivatives/",sub_id))
  
  if(site_id%in%c("ABIDEI-NYU","ABIDEI-KKI")){
    SCRUB=read.table(file = paste0("func/",sub_id,"_task-rest_run-1_desc-confounds_timeseries.tsv"),header=TRUE,stringsAsFactors = FALSE)[-1,]
  }else if(site_id=="ABIDEII-KKI"){
    chan=read.csv("/data/home4/risk_share/ImproveFConnASD/ABIDE/Liangkang/data/ABIDE-II_KKI_1_AdditionalScanInfo.csv",header=TRUE)
    chan_s=chan$RECEIVING_COIL[which(chan$KKI_INDISUB_ID==as.numeric(strsplit(as.character(sub_id),"-")[[1]][2]))]
    channel=strsplit(as.character(chan_s)," ")[[1]][[1]] 
    SCRUB=read.table(file = paste0("ses-1/func/",sub_id,"_ses-1_task-rest_acq-rc",channel,"chan_run-1_desc-confounds_timeseries.tsv"),header=TRUE,stringsAsFactors = FALSE)[-1,]
  }else if(site_id%in%c("ABIDEII-NYU_1","ABIDEII-NYU_2")){
    SCRUB=read.table(file = paste0("ses-1/func/",sub_id,"_ses-1_task-rest_run-1_desc-confounds_timeseries.tsv"),header=TRUE,stringsAsFactors = FALSE)[-1,]
  }
  
  FD=as.numeric(SCRUB$framewise_displacement)
  
  tp_all=1:length(FD) #all time points
  
  FD05=FD<0.5
  a=which(!FD05)
  b=unique(c(a,a-1,a+1,a+2))
  b.retain=b[b>0&b<=length(FD05)]
  tp_fd05bf=setdiff(tp_all,b.retain) # FD<0.5 backward 1 forward 2
  
  FD02=FD<0.2
  tp_fd02=which(FD02)
  
  return(list(tp_all=tp_all,tp_fd05bf=tp_fd05bf,tp_fd02=tp_fd02))
  
}

### Calculate the parcel means of fMRI data.
pmean <- function(xii_mat,parc_vec){
  xii_pmean = matrix(nrow = 400, ncol = ncol(xii_mat))
  for(p in 1:400){
    data_p = xii_mat[parc_vec == p,]
    xii_pmean[p,] = colMeans(data_p, na.rm = T)
  }
  return(xii_pmean)
}


##### parcel means with subcortex and cortex
pmean_full <- function(xii_mat,parc_all,label){
  xii_pmean <- matrix(nrow = length(label),ncol = ncol(xii_mat))
  for (p in label) {
    data_p <- xii_mat[parc_all==p,]
    xii_pmean[which(label==p),] <- colMeans(data_p,na.rm = TRUE)
} #mean dtseries by parcellation 419 x 155
  return(xii_pmean)
}



