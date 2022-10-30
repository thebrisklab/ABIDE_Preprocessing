rm(list = ls())

# ABIDEI-NYU

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEI-NYU/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]
 
cat("Create .1D files for ABIDEI-NYU ! \n")
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed")

for (sub in subnames) {
  path_to_tsv_filenames=list.files(paste0("ABIDEI-NYU/derivatives/",sub,"/func/"))
  tsv_index=grep(".tsv",path_to_tsv_filenames)
  tsv_name=path_to_tsv_filenames[tsv_index]
  cat(tsv_name,"\n")

  path_name=paste0("ABIDEI-NYU/derivatives/",sub,"/func/",tsv_name)
  nuisance_tsv=read.table(path_name,header = T)

  nuisance_tsv$global_signal_derivative1 = as.numeric(nuisance_tsv$global_signal_derivative1)
  nuisance_tsv$global_signal_derivative1[1]=0
  nuisance_tsv$csf_derivative1 = as.numeric(nuisance_tsv$csf_derivative1)
  nuisance_tsv$csf_derivative1[1]=0
  nuisance_tsv$white_matter_derivative1 = as.numeric(nuisance_tsv$white_matter_derivative1)
  nuisance_tsv$white_matter_derivative1[1]=0
  nuisance_tsv$trans_x_derivative1 = as.numeric(nuisance_tsv$trans_x_derivative1)
  nuisance_tsv$trans_x_derivative1[1]=0
  nuisance_tsv$trans_y_derivative1 = as.numeric(nuisance_tsv$trans_y_derivative1)
  nuisance_tsv$trans_y_derivative1[1]=0
  nuisance_tsv$trans_z_derivative1 = as.numeric(nuisance_tsv$trans_z_derivative1)
  nuisance_tsv$trans_z_derivative1[1]=0
  nuisance_tsv$rot_x_derivative1 = as.numeric(nuisance_tsv$rot_x_derivative1)
  nuisance_tsv$rot_x_derivative1[1]=0
  nuisance_tsv$rot_y_derivative1 = as.numeric(nuisance_tsv$rot_y_derivative1)
  nuisance_tsv$rot_y_derivative1[1]=0
  nuisance_tsv$rot_z_derivative1 = as.numeric(nuisance_tsv$rot_z_derivative1)
  nuisance_tsv$rot_z_derivative1[1]=0

  write.table(nuisance_tsv$global_signal,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/global.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$global_signal_power2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/global_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$global_signal_derivative1,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/global_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$global_signal_derivative1^2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/global_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$csf,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/csf.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$csf_power2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/csf_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$csf_derivative1,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/csf_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$csf_derivative1^2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/csf_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$white_matter,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/wm.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$white_matter_power2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/wm_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$white_matter_derivative1,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/wm_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$white_matter_derivative1^2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/wm_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$trans_x,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/trans_x.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_x_power2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/trans_x_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_x_derivative1,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/trans_x_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_x_derivative1^2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/trans_x_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$trans_y,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/trans_y.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_y_power2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/trans_y_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_y_derivative1,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/trans_y_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_y_derivative1^2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/trans_y_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$trans_z,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/trans_z.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_z_power2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/trans_z_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_z_derivative1,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/trans_z_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_z_derivative1^2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/trans_z_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$rot_x,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/rot_x.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_x_power2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/rot_x_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_x_derivative1,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/rot_x_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_x_derivative1^2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/rot_x_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$rot_y,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/rot_y.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_y_power2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/rot_y_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_y_derivative1,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/rot_y_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_y_derivative1^2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/rot_y_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$rot_z,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/rot_z.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_z_power2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/rot_z_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_z_derivative1,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/rot_z_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_z_derivative1^2,paste0("36p/ABIDEI-NYU/",sub,"/nuisance/rot_z_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  cat(".1D files built for ",sub,"!\n")
}

cat("#################### finish ABIDEI-NYU! ######################\n")


# ABIDEII-NYU_1

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-NYU_1/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed")
cat("Create .1D files for ABIDEII-NYU_1 ! \n")

for (sub in subnames) {
  path_to_tsv_filenames=list.files(paste0("ABIDEII-NYU_1/derivatives/",sub,"/ses-1/func/"))
  tsv_index=grep(".tsv",path_to_tsv_filenames)
  tsv_name=path_to_tsv_filenames[tsv_index]
  cat(tsv_name,"\n")

  path_name=paste0("ABIDEII-NYU_1/derivatives/",sub,"/ses-1/func/",tsv_name)
  nuisance_tsv=read.table(path_name,header = T)

  nuisance_tsv$global_signal_derivative1 = as.numeric(nuisance_tsv$global_signal_derivative1)
  nuisance_tsv$global_signal_derivative1[1]=0
  nuisance_tsv$csf_derivative1 = as.numeric(nuisance_tsv$csf_derivative1)
  nuisance_tsv$csf_derivative1[1]=0
  nuisance_tsv$white_matter_derivative1 = as.numeric(nuisance_tsv$white_matter_derivative1)
  nuisance_tsv$white_matter_derivative1[1]=0
  nuisance_tsv$trans_x_derivative1 = as.numeric(nuisance_tsv$trans_x_derivative1)
  nuisance_tsv$trans_x_derivative1[1]=0
  nuisance_tsv$trans_y_derivative1 = as.numeric(nuisance_tsv$trans_y_derivative1)
  nuisance_tsv$trans_y_derivative1[1]=0
  nuisance_tsv$trans_z_derivative1 = as.numeric(nuisance_tsv$trans_z_derivative1)
  nuisance_tsv$trans_z_derivative1[1]=0
  nuisance_tsv$rot_x_derivative1 = as.numeric(nuisance_tsv$rot_x_derivative1)
  nuisance_tsv$rot_x_derivative1[1]=0
  nuisance_tsv$rot_y_derivative1 = as.numeric(nuisance_tsv$rot_y_derivative1)
  nuisance_tsv$rot_y_derivative1[1]=0
  nuisance_tsv$rot_z_derivative1 = as.numeric(nuisance_tsv$rot_z_derivative1)
  nuisance_tsv$rot_z_derivative1[1]=0
  
  write.table(nuisance_tsv$global_signal,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/global.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$global_signal_power2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/global_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$global_signal_derivative1,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/global_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$global_signal_derivative1^2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/global_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$csf,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/csf.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$csf_power2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/csf_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$csf_derivative1,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/csf_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$csf_derivative1^2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/csf_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$white_matter,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/wm.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$white_matter_power2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/wm_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$white_matter_derivative1,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/wm_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$white_matter_derivative1^2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/wm_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$trans_x,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/trans_x.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_x_power2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/trans_x_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_x_derivative1,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/trans_x_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_x_derivative1^2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/trans_x_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$trans_y,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/trans_y.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_y_power2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/trans_y_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_y_derivative1,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/trans_y_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_y_derivative1^2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/trans_y_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$trans_z,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/trans_z.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_z_power2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/trans_z_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_z_derivative1,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/trans_z_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_z_derivative1^2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/trans_z_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$rot_x,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/rot_x.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_x_power2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/rot_x_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_x_derivative1,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/rot_x_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_x_derivative1^2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/rot_x_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$rot_y,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/rot_y.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_y_power2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/rot_y_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_y_derivative1,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/rot_y_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_y_derivative1^2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/rot_y_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$rot_z,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/rot_z.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_z_power2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/rot_z_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_z_derivative1,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/rot_z_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_z_derivative1^2,paste0("36p/ABIDEII-NYU_1/",sub,"/nuisance/rot_z_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  cat(".1D files built for ",sub,"!\n")
}
cat("#################### finish ABIDEII-NYU_1! ######################\n")



# ABIDEII-NYU_2

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")
filenames=list.files("ABIDEII-NYU_2/")
sub_index=grep("sub-",filenames)
subnames=filenames[sub_index]

setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed")
cat("Create .1D files for ABIDEII-NYU_2 ! \n")

for (sub in subnames) {
  path_to_tsv_filenames=list.files(paste0("ABIDEII-NYU_2/derivatives/",sub,"/ses-1/func/"))
  tsv_index=grep(".tsv",path_to_tsv_filenames)
  tsv_name=path_to_tsv_filenames[tsv_index]
  cat(tsv_name,"\n")
  
  path_name=paste0("ABIDEII-NYU_2/derivatives/",sub,"/ses-1/func/",tsv_name)
  nuisance_tsv=read.table(path_name,header = T)
  
  nuisance_tsv$global_signal_derivative1 = as.numeric(nuisance_tsv$global_signal_derivative1)
  nuisance_tsv$global_signal_derivative1[1]=0
  nuisance_tsv$csf_derivative1 = as.numeric(nuisance_tsv$csf_derivative1)
  nuisance_tsv$csf_derivative1[1]=0
  nuisance_tsv$white_matter_derivative1 = as.numeric(nuisance_tsv$white_matter_derivative1)
  nuisance_tsv$white_matter_derivative1[1]=0
  nuisance_tsv$trans_x_derivative1 = as.numeric(nuisance_tsv$trans_x_derivative1)
  nuisance_tsv$trans_x_derivative1[1]=0
  nuisance_tsv$trans_y_derivative1 = as.numeric(nuisance_tsv$trans_y_derivative1)
  nuisance_tsv$trans_y_derivative1[1]=0
  nuisance_tsv$trans_z_derivative1 = as.numeric(nuisance_tsv$trans_z_derivative1)
  nuisance_tsv$trans_z_derivative1[1]=0
  nuisance_tsv$rot_x_derivative1 = as.numeric(nuisance_tsv$rot_x_derivative1)
  nuisance_tsv$rot_x_derivative1[1]=0
  nuisance_tsv$rot_y_derivative1 = as.numeric(nuisance_tsv$rot_y_derivative1)
  nuisance_tsv$rot_y_derivative1[1]=0
  nuisance_tsv$rot_z_derivative1 = as.numeric(nuisance_tsv$rot_z_derivative1)
  nuisance_tsv$rot_z_derivative1[1]=0
  
  write.table(nuisance_tsv$global_signal,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/global.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$global_signal_power2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/global_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$global_signal_derivative1,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/global_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$global_signal_derivative1^2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/global_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$csf,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/csf.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$csf_power2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/csf_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$csf_derivative1,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/csf_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$csf_derivative1^2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/csf_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$white_matter,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/wm.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$white_matter_power2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/wm_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$white_matter_derivative1,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/wm_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$white_matter_derivative1^2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/wm_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$trans_x,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/trans_x.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_x_power2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/trans_x_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_x_derivative1,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/trans_x_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_x_derivative1^2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/trans_x_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$trans_y,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/trans_y.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_y_power2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/trans_y_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_y_derivative1,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/trans_y_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_y_derivative1^2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/trans_y_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$trans_z,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/trans_z.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_z_power2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/trans_z_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_z_derivative1,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/trans_z_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$trans_z_derivative1^2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/trans_z_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$rot_x,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/rot_x.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_x_power2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/rot_x_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_x_derivative1,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/rot_x_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_x_derivative1^2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/rot_x_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$rot_y,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/rot_y.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_y_power2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/rot_y_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_y_derivative1,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/rot_y_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_y_derivative1^2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/rot_y_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  write.table(nuisance_tsv$rot_z,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/rot_z.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_z_power2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/rot_z_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_z_derivative1,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/rot_z_der.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  write.table(nuisance_tsv$rot_z_derivative1^2,paste0("36p/ABIDEII-NYU_2/",sub,"/nuisance/rot_z_der_2.1D"),sep ="\t",quote = F,row.names = F,col.names = F)
  
  cat(".1D files built for ",sub,"!\n")
}
cat("#################### finish ABIDEII-NYU_2! ######################\n")



