# ABIDE Data Preprocessing

Here is a description of the preprocessing steps for ABIDEI data (http://fcon_1000.projects.nitrc.org/indi/abide/) on Emory CSIC cluster (csic.som.emory.edu).    

These scripts are used to preprocess ABIDEI-KKI, ABIDEI-NYU ABIDEII-KKI, ABIDEII-NYU_1, ABIDEII-NYU_2.

## Step 1: Prepare data
All the raw data to be preprocessed are stored under `/data/home4/risk_share/ImproveFConnASD/ABIDE`. They should be in BIDS data format. The BIDS format can be validated using https://bids-standard.github.io/bids-validator/. Seperate folders were created to store output preprocessed results under `/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed`. 

Create the following three folders inside each study folders, e.g. `/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEI-KKI`:     
- `derivatives`: store ouput preprocessed files.     
- `script`: store corresponding preprocessing scripts.     
- `scratch`: store error message and output information when submitting to the CSIC cluster.     

Get free surfer license and put the .txt file under `derivatives` folder.   

Download and install Docker.   
**Note**: csic cluster already have docker installed, but one needs to get permission to run docker on the cluster.

## Step 2: Run scripts     
Open the terminal and login to the CSIC server. Then login to a computing node by typing `qlogin`, or simply `ssh node3`. Navigate to the script folder.

### Note: Remove the first two volumes in NYU preprocessing

Navigate to the subfolder `remove_volume` under the script folder inside ABIDEI-NYU, ABIDEII-NYU_1 and ABIDEII-NYU_2 folder. `remove_volume.sh` is the scrpt to remove first two volumes in each NYU dataset using afnidir/3dcalc software. To run the analysis, for instance for ABIDEI-NYU, open submit_ABIDEI-NYU.sh, change myscratch to the target scratch folder, type `chmod u+x submit.sh` in the command line to change the root permission of the submit script, then type `./submit.sh` to submit parallel jobs.

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

### Submit scripts to CSIC cluster

Open `submit.sh`, change `myscratch` to the target scratch folder:
```
myscratch=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEII-KKI/scratch
```

Then inside each study folder in the command line, type    
```
chmod u+x submit.sh
```
to change the root permission of the submit script.    

Then type
```
./submit.sh
```
to submit parallel jobs.

The errors and running information will be stored in `/scratch/err` and `/scratch/out` folder. You can use `qstat` to check running status, and `qdel` to delete running jobs.

## Step 3: Scrubing?



## Step 4: Nuissance regression

### 1. Volume-based

Run `create_folders.R` to create three new folders: 
- `nuisance`: Store nuisance regressors/
- `volume_based`: Store volume-based nuisance regression results.
- `cifti_based`: Store cifti-based nuisance regression results.
Should modify the input/output path code accordingly.  

Run `gen_subjList.R` to generate a list of subject numbers and corresponding preprocessed `.nii.gz` file.
Should get a `.txt` file, e.g. `subjList_ABIDEII.txt` with two columns. The first column contains the subject number, while the second column contains the name of preprocessed `.nii.gz` file. 
Should modify the input/output path code accordingly.  

Run `create_1D.R` to create several `.1D` files containing the nuisance regressors. Should get 36 `.1D` files under `nuisance` folder, which will be used for 36p/9p nuisance regression.
Should modify the input/output path code accordingly.  

Modify the script `Subj_36p_9p_ABIDEI.sh` as follows:
- `func_dir`: the path to the `derivatives` folder containing the preprocessed data from fmriprep.
- `nuisance_dir`: the path to the `nuisance` folder.
- `out_dir`: the path to the output folder.
Example:
```
func_dir=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEI-KKI/derivatives
nuisance_dir=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/ABIDEI-KKI/${subj}/nuisance
out_dir=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/ABIDEI-KKI/${subj}/volume_based
```

Open submitting scripts, e.g. `submit_ABIDEI.sh`, change `myscratch` to the target scratch folder:
```
myscratch=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p/scratch/volume/ABIDEI-KKI
```

Open the terminal and login to the CSIC server. Then login to a computing node by typing `qlogin`, or simply `ssh node3`. Navigate to the script folder.
Then inside each study folder in the command line, type    
```
chmod u+x submit_ABIDEI.sh
```
to change the root permission of the submit script.    

Then type
```
./submit_ABIDEI.sh
```
to submit parallel jobs.

The errors and running information will be stored in `/scratch/err` and `/scratch/out` folder. You can use `qstat` to check running status, and `qdel` to delete running jobs.


### 2. cifti-based











