library(tidyverse)

##### Read-in phenotype data.
# here, we use the phenotype info with a few additional preprocessing measures,
# including func_mean_fd, which we can use to audit our own calculations and merges with the fmriprep output. 
# this version of the phenotype data is available at https://s3.amazonaws.com/fcp-indi/data/Projects/ABIDE_Initiative/Phenotypic_V1_0b_preprocessed1.csv

phenotypic_ABIDEI <- read.csv("data/Phenotypic_V1_0b_preprocessed1.csv")

# read in ABIDE II phenotype:
# Download ABIDE II Composite Phenotypic File from https://fcon_1000.projects.nitrc.org/indi/abide/abide_II.html
phenotypic_ABIDEII <- read.csv("data/ABIDEII_Composite_Phenotypic.csv")


# phenotypic_ABIDEI <- phenotypic_ABIDEI[,c(-1,-2,-4,-5)]
phenotypic_ABIDEI <- phenotypic_ABIDEI %>%
  mutate(SITE_ID=paste0("ABIDEI-",SITE_ID),SOURCE="ABIDEI") %>%
  select(SOURCE,SITE_ID,everything())

names(phenotypic_ABIDEI) <- toupper(names(phenotypic_ABIDEI))

phenotypic_ABIDEII <- phenotypic_ABIDEII %>%
  mutate(SOURCE="ABIDEII") %>%
  select(SOURCE,SUB_ID,everything())

names(phenotypic_ABIDEII) <- toupper(names(phenotypic_ABIDEII))

pheno_all=merge(phenotypic_ABIDEI,phenotypic_ABIDEII,all=TRUE)

###### Delta read
load('data/Delta_Outcome.Rdata') # created in abide preprocessing scrubbing_ABIDE.R

# subset to school-age children
pheno_all = pheno_all%>%filter(AGE_AT_SCAN<=14&AGE_AT_SCAN>=8)
# table(pheno_all$DX_GROUP,pheno_all$SITE_ID)
# note: when we merge to the delta / motion variables
# calculate from imaging data, we will subset
# to kki and nyu



# change subject id's in phenotype data for merge:
SUB_ID2=NULL
SUB_ID2[which(pheno_all$SUB_ID<30000)]=paste0("sub-",pheno_all$SUB_ID[which(pheno_all$SUB_ID<30000)])
SUB_ID2[which(pheno_all$SUB_ID>30000)]=paste0("sub-00",pheno_all$SUB_ID[which(pheno_all$SUB_ID>30000)])

  # check that the SUB_ID ordering looks good:
  library(stringr)
  all(str_sub(SUB_ID2,-5)==pheno_all$SUB_ID)

pheno_all$SUB_ID = SUB_ID2

delta_all <- Delta_Outcome %>%
  left_join(pheno_all,by = c("SUB_ID"))

# %>%filter(AGE_AT_SCAN<=14&AGE_AT_SCAN>=8)
# NOTE: Delta_Outcome is restricted to 8-13 year olds

# check number of records for each site:
delta_all %>% count(SITE_ID,DX_GROUP)


# create additional phenotype variables:

# binary handedness:
delta_all <- delta_all %>% mutate(HANDEDNESS_LR="R")
delta_all$HANDEDNESS_LR[which(delta_all$HANDEDNESS_SCORE>=-100 & delta_all$HANDEDNESS_SCORE<0)]="L"

#################### MEDICATION NAME
#### change "" to NA and change none to NA
delta_all$MEDICATION_NAME[which(delta_all$MEDICATION_NAME=="")]=NA
delta_all$CURRENT_MEDICATION_NAME[which(delta_all$CURRENT_MEDICATION_NAME=="none")]=NA
delta_all$CURRENT_MEDICATION_NAME[which(delta_all$CURRENT_MEDICATION_NAME=="")]=NA

MEDICATION=delta_all$CURRENT_MEDICATION_NAME
MEDICATION[which(is.na(MEDICATION))]=delta_all$MEDICATION_NAME[which(is.na(MEDICATION))]

delta_all <- delta_all %>% mutate(MEDICATION_NAME=MEDICATION) %>% select(-CURRENT_MEDICATION_NAME)

#receiving coil channel
# this dataset can be downloaded at https://fcon_1000.projects.nitrc.org/indi/abide/scan_params/ABIDEII-KKI_1/ABIDE-II_KKI_1_AdditionalScanInfo.csv
ABIDEIIKKI=read.csv("data/ABIDE-II_KKI_1_AdditionalScanInfo.csv")[,1:2]
names(ABIDEIIKKI)[1]="SUB_ID"
ABIDEIIKKI$SUB_ID = paste0('sub-',ABIDEIIKKI$SUB_ID)

delta_all <- delta_all%>%left_join(ABIDEIIKKI)
delta_all$RECEIVING_COIL[which(is.na(delta_all$RECEIVING_COIL))]="8 channel"

# audit: check if our calculation of mean FD aligns
# with preprocessed data:
model0 = lm(FUNC_MEAN_FD~Mean_FD,data=delta_all)
summary(model0)
# populated in 142 observations (only available in abide 1)
# highly correlated, looks good
####################

# Categorize medications as stimulants and non-stimulants
delta_all <- delta_all%>%mutate(Stimulant=NA,NonStimulant=NA)
delta_all$Stimulant[grep(pattern = "phenidate",x = delta_all$MEDICATION_NAME)]=1
delta_all$Stimulant[grep(pattern = "amine",x = delta_all$MEDICATION_NAME)]=1

delta_all$NonStimulant[which(is.na(delta_all$Stimulant)&(!is.na(delta_all$MEDICATION_NAME)))]=1
delta_all$MEDICATION_NAME[which((!is.na(delta_all$MEDICATION_NAME) & is.na(delta_all$NonStimulant)))]

delta_all$MEDICATION_NAME[which((!is.na(delta_all$MEDICATION_NAME) & is.na(delta_all$NonStimulant)))]

# additional non-stimulants:
delta_all$NonStimulant[delta_all$MEDICATION_NAME%in%c("Methylphenidate Extended Release; Sertraline","dexmethylphenidate; guanfacine","methylphenidate; guanfacine; fluoxetine","Fluoxetine; Methylphenidate","Dexmethylphenidate; Guanfacine; Clonidine; Melatonin","Escitalopram; Dexmethylphenidate","Methylphenidate Transdermal;Guanfacine Extended Release; Citalopram")]=1
delta_all$Stimulant[which(is.na(delta_all$Stimulant))]=0
delta_all$NonStimulant[which(is.na(delta_all$NonStimulant))]=0




### Obtain ADOS score for all asd participants:
### check compatability of different ADOS versions:
# ABIDE I: ADOS_TOTAL = classic ADOS score (communication + social interaction subscores)

# according to ABIDEII_Data_Legend, ADOS_G_TOTAL in ABIDE II corresponds to ADOS_TOTAL in ABIDE I.
# ADOS_2_TOTAL corresponds to ADOS_GOTHAM_TOTAL
# ADOS Gotham is an improved scale that addresses compatability between different 
# modules, https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3057666/

# relationship between ADOS_2_TOTAL & ADOS_G_TOTAL
a=which(c(!is.na(delta_all$ADOS_2_TOTAL))&(!is.na(delta_all$ADOS_G_TOTAL)))
model1 = lm(ADOS_2_TOTAL~ADOS_G_TOTAL,data=delta_all[a,])
summary(model1) # slope is pretty close to one
# intercept does not differ significantly from 0
# R-squared is 0.82
plot(model1) #looks good
# compare mean of ADOS_2_TOTAL to rest
mean(delta_all$ADOS_2_TOTAL,na.rm=TRUE)
mean(delta_all$ADOS_G_TOTAL,na.rm=TRUE)
mean(delta_all$ADOS_TOTAL,na.rm=TRUE)
# comparable

table(is.na(delta_all$ADOS_TOTAL),is.na(delta_all$ADOS_2_TOTAL))
# never have ADOS_TOTAL and ADOS_2_TOTAL

# rule: use ADOS_2_TOTAL when available, then ADOS_TOTAL, then ADOS_G_TOTAL.
delta_all$ADOS_combine = delta_all$ADOS_2_TOTAL
delta_all$ADOS_combine[is.na(delta_all$ADOS_combine)] = delta_all$ADOS_TOTAL[is.na(delta_all$ADOS_combine)]
delta_all$ADOS_combine[is.na(delta_all$ADOS_combine)] = delta_all$ADOS_G_TOTAL[is.na(delta_all$ADOS_combine)]
table(is.na(delta_all$ADOS_combine),delta_all$DX_GROUP) # all NAs correspond to TD
summary(delta_all$ADOS_combine)
# some children with ADOS=3 that are labeled as ASD. 
# There are kiddos that are quite low on the spectrum. 

# make the TD values equal to 0:
delta_all$ADOS_combine[delta_all$DX_GROUP==2]=0
summary(delta_all$ADOS_combine) # no missing data:)

# read in usable scans from the manual inspection of T1 segmentation:
usable_t1 = read.csv('data/check_ABIDE_T1_v2.csv')
# change subject id's in phenotype data for merge:
usable_t1$SUB_ID=""
usable_t1$SUB_ID[which(usable_t1$SubjectID<30000)]=paste0("sub-",usable_t1$SubjectID[which(usable_t1$SubjectID<30000)])
usable_t1$SUB_ID[which(usable_t1$SubjectID>30000)]=paste0("sub-00",usable_t1$SubjectID[which(usable_t1$SubjectID>30000)])

abide_pheno <- delta_all %>%
  left_join(usable_t1,by = c("SUB_ID"))

table(abide_pheno$Usable)
abide_pheno$Delta_ciric_fs = 1*(abide_pheno$Delta_ciric & abide_pheno$Usable)

# subset to variables used in subsequent analyses:
abide_pheno=abide_pheno[,c("SUB_ID","Delta_fd_powerpt5","Delta_fd_powerpt5_bf","Delta_fd_powerpt2",    "Delta_fd_powerpt2_bf", "Delta_ciric","Delta_ciric_bf","Delta_ciric_fs","Usable","Mean_FD","Mean_RMSD","Propfd02","Propfd05","PropRMSD025","SITE_ID","SEX","AGE_AT_SCAN","FIQ","VIQ","PIQ","FIQ_TEST_TYPE","CURRENT_MED_STATUS","MEDICATION_NAME","HANDEDNESS_LR","DX_GROUP","ADOS_TOTAL","ADOS_2_TOTAL","ADOS_G_TOTAL","SCQ_TOTAL","FUNC_MEAN_FD","SRS_EDITION","SRS_TOTAL_RAW","Stimulant","NonStimulant","ADOS_combine","RECEIVING_COIL")]

save(abide_pheno,file='abide_pheno.RData')
