# ABIDE Data Preprocessing

Here is a description of the preprocessing steps for ABIDEI data (http://fcon_1000.projects.nitrc.org/indi/abide/) on Emory CSIC cluster (csic.som.emory.edu).    

These scripts are used to preprocess ABIDEI-KKI, ABIDEI-NYU ABIDEII-KKI, ABIDEII-NYU_1, ABIDEII-NYU_2.

## Step 1: Prepare data
All the raw data to be preprocessed are stored under `/data/home4/risk_share/ImproveFConnASD/ABIDE`. They should be in BIDS data format. The BIDS format can be validated using https://bids-standard.github.io/bids-validator/. Seperate folders were created to store output preprocessed results under `/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed`. 

Create the following three folders inside each study folders, e.g. `/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-KKI`:     
- `derivatives`: store ouput preprocessed files.     
- `script`: store corresponding preprocessing scripts.     
- `scratch`: store error message and output information when submitting to the CSIC cluster.     

Get free surfer license and put the .txt file under `derivatives` folder.   

Download and install Docker.   
**Note**: csic cluster already have docker installed, but one needs to get permission to run docker on the cluster.

## Step 2: Run scripts     
Open the terminal and login to the CSIC server. Then login to a computing node by typing `qlogin`, or simply `ssh node3`. Navigate to the script folder.

### Note: Remove the first two volumes in NYU preprocessing
xxxxxxx

### Get a list of all subject numbers in each study    

Run the code `gen_subjList.R`. The goal is to get a `subjList.txt` file containing the subject numbers. Should change the path in the code accordingly. 

### The code for fmriprep    

`fmriprep_Subj.sh` is the scrpt to perform preprocessing using fmriprep software. For the full usage of fmriprep, please refer to https://fmriprep.org/en/stable/index.html. Should change the following codes accordingly:    

- Change `bids_root_dir` to the target dataser dictionary.
```
bids_root_dir=/data/home4/risk_share/ImproveFConnASD/ABIDE/ABIDEII-KKI
```
- Change `FS_LICENSE` to the path to the target license file.
```
export FS_LICENSE=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-KKI/derivatives/license.txt
```
- Change the path afer `$bids_root_dir` to the target output folder `derivatives`.
```
fmriprep-docker $bids_root_dir /data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-KKI/derivatives \
```
- Change `--fs-license-file` to the path to the target license file.
```
--fs-license-file /data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-KKI/derivatives/license.txt \
```











