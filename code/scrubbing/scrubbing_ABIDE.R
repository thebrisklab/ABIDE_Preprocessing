# This code is used on cluster


########### funciton



scrub <- function(control,tr=2.5,time=5,back=0,forward=0,volume=NULL){
  if(is.null(volume)){volume=time*60/tr}
  delta=1
  
  if(sum(control)!=length(control)){ #have some motion
    f=which(!control)
    
    if(back|forward) {
        if (!sum(c(1,length(control))%in%f)) {
          remain=length(control)-length(f)*(back+forward+1) # don't have bad point on start and end.
        }else{
          if(sum(c(1,length(control))%in%f)==2){ # have bad points on both start and end.
            remain=length(control)-length(f)*(back+forward+1)+back+forward
            }else if(length(control)%in%f){ # only bad point on end.
            remain=length(control)-length(f)*(back+forward+1)+forward
            }else if(1%in%f){ # only bad point on start
              remain=length(control)-length(f)*(back+forward+1)+back
              } 
        }
      }else{remain=length(control)-length(f)}
    
    
    if(remain<volume){delta=0}
  
  }
  return(delta)
}


#/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEI-KKI/derivatives/sub-0050775/func/sub-0050775_task-rest_run-1_desc-confounds_timeseries.tsv
#/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEI-NYU/derivatives/sub-0050959/func/sub-0050959_task-rest_run-1_desc-confounds_timeseries.tsv
#/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-KKI/derivatives/sub-29274/ses-1/func/sub-29274_ses-1_task-rest_acq-rc8chan_run-1_desc-confounds_timeseries.tsv
#/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-NYU_1/derivatives/sub-29179/ses-1/func/sub-29179_ses-1_task-rest_run-1_desc-confounds_timeseries.tsv
#/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-NYU_2/derivatives/sub-29151/ses-1/func/sub-29151_ses-1_task-rest_run-1_desc-confounds_timeseries.tsv


### for one subject
Get_Delta <- function(SITE_ID,SUB_ID,path,tr){  # we need to set the filename in this function
  require(rlang)

  if(SITE_ID %in% c("ABIDEI-KKI","ABIDEI-NYU")){
    scrub_address <- paste0(path,"fmriprep_preprocessed/",SITE_ID,"/derivatives/",SUB_ID,"/func/",SUB_ID,"_task-rest_run-1_desc-confounds_timeseries.tsv")
  }else if(SITE_ID== "ABIDEII-NYU_1"){
    scrub_address <- paste0(path,"fmriprep_preprocessed/",SITE_ID,"/derivatives/",SUB_ID,"/ses-1/func/",SUB_ID,"_ses-1_task-rest_run-1_desc-confounds_timeseries.tsv")
  }else if(SITE_ID=="ABIDEII-KKI"){
      chan=read.csv("/home/lwan456/scrubbing_outcome/ABIDE-II_KKI_1_AdditionalScanInfo.csv",header=TRUE)####### may be need change
      chan_s=chan$RECEIVING_COIL[which(chan$KKI_INDISUB_ID==as.numeric(strsplit(SUB_ID,split = "-")[[1]][[2]]))]
      channel=strsplit(as.character(chan_s)," ")[[1]][[1]] 
      scrub_address <- paste0(path,"fmriprep_preprocessed/",SITE_ID,"/derivatives/",SUB_ID,"/ses-1/func/",SUB_ID,"_ses-1_task-rest_acq-rc",channel,"chan_run-1_desc-confounds_timeseries.tsv")
  }
  
    filename=scrub_address
    
    SCRUB=read.table(file = filename,header = TRUE,stringsAsFactors = FALSE)[-1,]
    
    FD=as.numeric(SCRUB$framewise_displacement)
    RMSD=as.numeric(SCRUB$rmsd)
    #dvars=as.numeric(SCRUB$std_dvars)
    #####
    Mean_FD=mean(FD)
    Mean_RMSD=mean(RMSD)
    propfd02=mean(FD<0.2)
    propfd05=mean(FD<0.5)
    propRMSD025=mean(RMSD<0.25)
    #Mean_dvars=c(Mean_dvars,mean(dvars))
    
    ########################################################### Power 2014 FD scrub
    #FD<0.2 strict criteria without back and forward with at least 5 mins as default
    Delta_fd_strict=scrub(control=FD<0.2,tr=tr)
    
    
    ## Add forward=2 and backward=1 to FD<0.2 strict criteria
    Delta_fd_strict_bf=scrub(control=FD<0.2,tr=tr,back = 1,forward = 2)
    
    #FD<0.5 lenient criteria without back and forward
    Delta_fd_lenient=scrub(control=FD<0.5,tr=tr)
    
    ##  Add forward=2 and backward=1 to FD<0.5 lenient criteria
    
    Delta_fd_lenient_bf=scrub(control=FD<0.5,tr=tr,back = 1,forward = 2)
    
    ########################################################## Power 2014 FD scrub
    
    #### Ciric 2017
    #mean(RMSD)<0.2  && RMSD < 0.25 with at least 5 mins
    if(mean(RMSD)<0.2&scrub(control=RMSD<0.25,tr=tr)){Delta_rmsd=1}else{Delta_rmsd=0}
    
    ########## add back and forward
    if(mean(RMSD)<0.2&scrub(control=RMSD<0.25,tr=tr,back = 1,forward = 2)){Delta_rmsd_bf=1}else{Delta_rmsd_bf=0}

    
    ##### Power 2012
    #FD<0.5 && dvars < 0.5% \delta BOLD
    #Delta_dvars_2012=scrub(control = dvars<1.5&FD<0.5,back = 1,forward = 2)
    
  
  Delta_outcome=data.frame(SUB_ID=SUB_ID,Delta_fd_powerpt5=Delta_fd_lenient,Delta_fd_powerpt5_bf=Delta_fd_lenient_bf,
                           Delta_fd_powerpt2=Delta_fd_strict,Delta_fd_powerpt2_bf=Delta_fd_strict_bf,Delta_ciric=Delta_rmsd,
                           Delta_ciric_bf=Delta_rmsd_bf,Mean_FD=Mean_FD,Mean_RMSD=Mean_RMSD,Propfd02=propfd02,Propfd05=propfd05,PropRMSD025=propRMSD025)
  return(Delta_outcome)
}

#########

path="/data/home4/risk_share/ImproveFConnASD/ABIDE/"

subj_List <- read.table(file = paste0(path,"Liangkang/data/subj_List_JL.txt"),header = FALSE,sep = "",stringsAsFactors = FALSE)

## i=1
i=1

SITE_ID=subj_List$V1[[i]]
SUB_ID=subj_List$V2[[i]]

if(SITE_ID=="ABIDEI-KKI"){
  tr=2.5
}else if(SITE_ID=="ABIDEI-NYU"){
  tr=2
}else if(SITE_ID=="ABIDEII-KKI"){
  tr=2.5
}else if(SITE_ID=="ABIDEII-NYU_1"){
  tr=2
}else if(SITE_ID=="ABIDEII-NYU_2"){
  tr=2}

Delta_Outcome=Get_Delta(SITE_ID = SITE_ID,SUB_ID = SUB_ID,path=path,tr=tr)


for (i in 2:nrow(subj_List)) {
  try({
    SITE_ID=subj_List$V1[[i]]
  SUB_ID=subj_List$V2[[i]]
  
  if(SITE_ID=="ABIDEI-KKI"){
    tr=2.5
  }else if(SITE_ID=="ABIDEI-NYU"){
    tr=2
  }else if(SITE_ID=="ABIDEII-KKI"){
    tr=2.5
  }else if(SITE_ID=="ABIDEII-NYU_1"){
    tr=2
  }else if(SITE_ID=="ABIDEII-NYU_2"){
    tr=2}
  
  Delta_outcome=Get_Delta(SITE_ID = SITE_ID,SUB_ID = SUB_ID,path=path,tr=tr)
  Delta_Outcome=rbind(Delta_Outcome,Delta_outcome)
  
  })
    
}


save(Delta_Outcome,file =paste0("/data/home4/risk_share/ImproveFConnASD/ABIDE/Liangkang/outcome/sub_delta/Delta_Outcome.Rdata") )

