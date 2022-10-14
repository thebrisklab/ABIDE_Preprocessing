# This code is used on cluster

args <- commandArgs(TRUE)
source=args[1]

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




Get_Delta <- function(SUB_ID,source,path,tr){  # we need to set the filename in this function
  require(rlang)
  Delta_fd_lenient=c()
  Delta_fd_strict=c()
  Delta_rmsd=c()
  
  Delta_fd_lenient_bf=c()
  Delta_fd_strict_bf=c()
  Delta_rmsd_bf=c()
  
  Mean_FD=c()
  Mean_RMSD=c()
  if(!is_empty(grep(pattern = "ABIDEI-",x = source))){
      get_address <- function(path,source,i){paste0(path,source,"/derivatives/sub-00",i,"/func/sub-00",i,"_task-rest_run-1_desc-confounds_timeseries.tsv")}
   }else if(!is_empty(grep(pattern = "ABIDEII-NYU",x = source))){
      get_address <- function(path,source,i){paste0(path,source,"/derivatives/sub-",i,"/ses-1/func/sub-",i,"_ses-1_task-rest_run-1_desc-confounds_timeseries.tsv")}
   }else if(source=="ABIDEII-KKI"){
      get_address <- function(path,source,i){
        chan=read.csv("/home/lwan456/scrubbing_outcome/ABIDE-II_KKI_1_AdditionalScanInfo.csv",header=TRUE)####### may be need change
        chan_s=chan$RECEIVING_COIL[which(chan$KKI_INDISUB_ID==i)]
        channel=strsplit(as.character(chan_s)," ")[[1]][[1]] 
        paste0(path,source,"/derivatives/sub-",i,"/ses-1/func/sub-",i,"_ses-1_task-rest_acq-rc",channel,"chan_run-1_desc-confounds_timeseries.tsv")
        }
    }
  for (i in SUB_ID) {
    filename=get_address(path=path,source=source,i=i)
    
    SCRUB=read.table(file = filename,header = TRUE,stringsAsFactors = FALSE)[-1,]
    
    FD=as.numeric(SCRUB$framewise_displacement)
    RMSD=as.numeric(SCRUB$rmsd)
    #dvars=as.numeric(SCRUB$std_dvars)
    #####
    Mean_FD=c(Mean_FD,mean(FD))
    Mean_RMSD=c(Mean_RMSD,mean(RMSD))
    #Mean_dvars=c(Mean_dvars,mean(dvars))
    
    ########################################################### Power 2014 FD scrub
    #FD<0.2 strict criteria without back and forward with at least 5 mins as default
    delta_fd_strict=scrub(control=FD<0.2,tr=tr)
    Delta_fd_strict=c(Delta_fd_strict,delta_fd_strict)
    
    ## Add forward=2 and backward=1 to FD<0.2 strict criteria
    delta_fd_strict_bf=scrub(control=FD<0.2,tr=tr,back = 1,forward = 2)
    Delta_fd_strict_bf=c(Delta_fd_strict_bf,delta_fd_strict_bf)
    
    #FD<0.5 lenient criteria without back and forward
    delta_fd_lenient=scrub(control=FD<0.5,tr=tr)
    Delta_fd_lenient=c(Delta_fd_lenient,delta_fd_lenient)
    
    
    ##  Add forward=2 and backward=1 to FD<0.5 lenient criteria
    
    delta_fd_lenient_bf=scrub(control=FD<0.5,tr=tr,back = 1,forward = 2)
    Delta_fd_lenient_bf=c(Delta_fd_lenient_bf,delta_fd_lenient_bf)
    
    
    
    
    ########################################################## Power 2014 FD scrub
    
    
    
    
    #### Ciric 2017
    #mean(RMSD)<0.2  && RMSD < 0.25 with at least 5 mins
    if(mean(RMSD)<0.2&scrub(control=RMSD<0.25,tr=tr)){delta_rmsd=1}else{delta_rmsd=0}
    Delta_rmsd=c(Delta_rmsd,delta_rmsd)
    
    ########## add back and forward
    if(mean(RMSD)<0.2&scrub(control=RMSD<0.25,tr=tr,back = 1,forward = 2)){delta_rmsd_bf=1}else{delta_rmsd_bf=0}
    Delta_rmsd_bf=c(Delta_rmsd_bf,delta_rmsd_bf)
    
    
    
    
    
    
    ##### Power 2012
    #FD<0.5 && dvars < 0.5% \delta BOLD
    #delta_dvars_2012=scrub(control = dvars<1.5&FD<0.5,back = 1,forward = 2)
    #Delta_dvars_2012=c(Delta_dvars_2012,delta_dvars_2012)
 
  }
  Delta_outcome=data.frame(subject_ID=SUB_ID,Delta_fd_powerpt5=Delta_fd_lenient,Delta_fd_powerpt5_bf=Delta_fd_lenient_bf,Delta_fd_powerpt2=Delta_fd_strict,
                            Delta_fd_powerpt2_bf=Delta_fd_strict_bf,Delta_ciric=Delta_rmsd,Delta_ciric_bf=Delta_rmsd_bf,Mean_FD=Mean_FD,Mean_RMSD=Mean_RMSD)
  return(Delta_outcome)
}






#########################


ABIDEI_KKI=50772:50826
ABIDEI_NYU=c(50952:50962,50964:51003,51006:51021,51023:51030,51032:51036,51038:51042,51044:51091,51093:51131,51146:51156,51159)

ABIDEII_KKI=c(29273:29405,29407:29425,29427:29485)
ABIDEII_NYU_1=29177:29254
ABIDEII_NYU_2=29150:29176


#source.1=strsplit(source,split = "_")[[1]][2]



path="/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/"

#### get the SUB_ID

if(source=="ABIDEI-KKI"){
  SUB_ID=ABIDEI_KKI
  tr=2.5
  }else if(source=="ABIDEI-NYU"){
  SUB_ID=ABIDEI_NYU
  tr=2
  }else if(source=="ABIDEII-KKI"){
  SUB_ID=ABIDEII_KKI
  tr=2.5
  }else if(source=="ABIDEII-NYU_1"){
  SUB_ID=ABIDEII_NYU_1
  tr=2
  }else if(source=="ABIDEII-NYU_2"){
  SUB_ID=ABIDEII_NYU_2
  tr=2
  }

Delta_outcome=Get_Delta(SUB_ID = SUB_ID,source = source,path = path,tr=tr)


save(Delta_outcome,file =paste0("/data/home4/risk_share/ImproveFConnASD/ABIDE/Liangkang/outcome/sub_delta/",source,"_scrub_outcome.Rdata") )

