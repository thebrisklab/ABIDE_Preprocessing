# Full cor matrix 400*419*419, containing the subcortex.
# Output the phenotypic merged with cor matrix (419*419)

source("/data/home4/risk_share/ImproveFConnASD/ABIDE/Liangkang/Rscript/Utils.R")
#####
setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")

subj_List <- read.table("Liangkang/data/subj_List.txt",stringsAsFactors = FALSE)


library(ciftiTools)
ciftiTools.setOption("wb_path", "/usr/local/workbench")


parc = load_parc("Schaefer_400")
parc_vec = c(as.matrix(parc)) # cortex
## load an xii as the subcortex levels.

site_id = subj_List[1, 1]
sub_id = subj_List[1, 2]

setwd(paste0("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/",site_id,"/",sub_id,"/cifti_based/"))

filename = paste0(sub_id, "_9p.dtseries.nii")
xii = read_xifti(filename,brainstructures = "all")
parc2 <- xii$meta$subcort$labels

parc_all=c(as.character(parc_vec),as.character(parc2)) #transfer all the labels to character.
label=c(as.character(1:400),levels(parc2)[3:21])

##3 load abide
abide <- read.csv(file = "/data/home4/risk_share/ImproveFConnASD/ABIDE/Liangkang/data/abide.select2.csv",header = TRUE,stringsAsFactors = FALSE)
abide$cor_mat=1 ### here it is weird, that it needs to generate at first when running on linux.
#abide <- read.csv(file = 'C:\\Liangkang Wang\\Emory\\Research\\Thesis\\LiangkangThesis\\data\\abide.select2.csv',header = TRUE) #the local file.
#Y.full=array(dim = c(419,419,400))


for(i in 1:nrow(subj_List)){
  print(i)
  # site_id 
  site_id = subj_List[i, 1]
  # sub_id
  sub_id = subj_List[i, 2]
  
  # get the timepoint to use
  #TP=timepoint(site_id = site_id,sub_id = sub_id) 
  
  setwd(paste0("/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/",site_id,"/",sub_id,"/cifti_based/"))
  
  filename = paste0(sub_id, "_9p.dtseries.nii")
  xii = read_xifti(filename,brainstructures = "all")
  
  xii = move_from_mwall(xii, NA)
  xii_mat = as.matrix(xii)
  
  
  xii_pmean_all=pmean_full(xii_mat=xii_mat,parc_all = parc_all,label=label) # for all the cortex and subcortex, 419 rows.

  
  
  # correlation and fisher Z transformation
  id=as.numeric(strsplit(as.character(sub_id),"-")[[1]][2])
  mat=as.matrix(atanh(cor(t(xii_pmean_all), method = "pearson")))
  
  abide$cor_mat[which(abide$SUB_ID==id)]=list(mat)
  
  
}


setwd("/data/home4/risk_share/ImproveFConnASD/ABIDE")

save(abide,file = "Liangkang/outcome/abide_Y_9p_all_419.Rda")
