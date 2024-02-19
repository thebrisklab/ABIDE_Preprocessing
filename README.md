# ABIDE Data Preprocessing

Here is a description of the preprocessing steps for ABIDE data (http://fcon_1000.projects.nitrc.org/indi/abide/) on Emory CSIC cluster (csic.som.emory.edu).    

These scripts are used to preprocess ABIDEI-KKI, ABIDEI-NYU ABIDEII-KKI, ABIDEII-NYU_1, ABIDEII-NYU_2.

## Step 1: Prepare data
All the raw data to be preprocessed are stored under `/data/home4/risk_share/ImproveFConnASD/ABIDE`. They should be in BIDS data format. The BIDS format can be validated using https://bids-standard.github.io/bids-validator/. Separate folders were created to store output preprocessed results under `/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed`. 

Create the following three folders inside each study folders, e.g. `/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEI-KKI`:     
- `derivatives`: store ouput preprocessed files.     
- `script`: store corresponding preprocessing scripts.     
- `scratch`: store error message and output information when submitting to the CSIC cluster.     

Get free surfer license and put the .txt file under `derivatives` folder.   

Download and install Docker.   
**Note**: csic cluster already have docker installed, but one needs to get permission to run docker on the cluster.

### Note: Remove the first two volumes in NYU Studies

The`remove_volume` subfolder under the script folder inside ABIDEI-NYU, ABIDEII-NYU_1 and ABIDEII-NYU_2 folder contains code to remove the first two volumes in NYU studies. `remove_volume.sh` is the script to remove first two volumes in each NYU dataset using afnidir/3dcalc software. To run the analysis, for instance for ABIDEI-NYU, open submit_ABIDEI-NYU.sh, change myscratch to the target scratch folder, type `chmod u+x submit.sh` in the command line to change the root permission of the submit script, then type `./submit.sh` to submit parallel jobs.

## Step 2: Run fmriprep scripts     
Open the terminal and login to the CSIC server. Then login to a computing node by typing `qlogin`, or simply `ssh node3`. Navigate to the script folder. Here we use ABIDEI-KKI as an example. 

### Get a list of all subject numbers in each study    

Navigate to the script folder. Run the code `gen_subjList.R`. The goal is to get a `subjList.txt` file containing the subject numbers. Should change the path in the code accordingly. 

### The code for fmriprep    

`fmriprep_Subj.sh` is the script to perform preprocessing using fmriprep software. For the full usage of fmriprep, please refer to https://fmriprep.org/en/stable/index.html. Should change the following codes accordingly:    

- Change `bids_root_dir` to the target dataset dictionary.
```
bids_root_dir=/data/home4/risk_share/ImproveFConnASD/ABIDE/ABIDEI-KKI
```
- Change `FS_LICENSE` to the path to the target license file.
```
export FS_LICENSE=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEI-KKI/derivatives/license.txt
```
- Change the path afer `$bids_root_dir` to the target output folder `derivatives`.
```
fmriprep-docker $bids_root_dir /data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEI-KKI/derivatives \
```
- Change `--fs-license-file` to the path to the target license file.
```
--fs-license-file /data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEI-KKI/derivatives/license.txt \
```

### Submit scripts to CSIC cluster

Open `submit.sh`, change `myscratch` to the target scratch folder:
```
myscratch=/data/home4/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/ABIDEI-KKI/scratch
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


## Step 3: Nuisance regression

The nuisance regression code and results can be found at `/home/jran2/risk_share/ImproveFConnASD/ABIDE/fmriprep_preprocessed/36p`. The folder is named `36p` to indicate that it involves regression on 36 parameters. It's worth noting that in addition to regression on 36 parameters, other regressions are also performed and can be found in the accompanying description. Inside the folder, a script folder is created to store the scripts, and separate folders are created for each site to store the output preprocessed results with the site's name.

To set up the necessary folders, go to the `script` folder and run `create_folders.R`. This will create three new folders under each site folder:

- `nuisance`: This folder will store the nuisance regressors.
- `volume_based`: This folder will store the results of volume-based nuisance regression.
- `cifti_based`: This folder will store the results of cifti-based nuisance regression.

Make sure to update the input/output path code accordingly to reflect these folder names and locations.

### 1. volume-based

Run `gen_subjList.R` to generate a list of subject numbers and corresponding preprocessed `.nii.gz` files. This will create a `.txt` file, such as `subjList_ABIDEI.txt`, with two columns. The first column will contain the subject numbers, while the second column will contain the names of the preprocessed `.nii.gz` files. 

Run `create_1D.R` to create several `.1D` files containing the nuisance regressors. This will generate 36 `.1D` files under the nuisance folder, which will be used for 36p/9p nuisance regression. 

Then, to perform volume-based regression. First modify the script `Subj_36p_9p_ABIDEI.sh` as follows:
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

Inside the `cifti_based` folder under the `script` folder, there are three subfolders:

- `cifti_to_nifti`: convert cifti file generated from fmriprep to fake nifti file
- `code`: run nuisance regression on nifti files using afni 3dTproject
- `nifti_to_cifti`: convert nifti file generated from nuisance regression back to cifti file

In the `cifti_to_nifti` folder, taking ABIDEI-KKI as an example, navigate to the `KKI` subfolder and run `gen_subjList_cifti.R` to generate a list of subject IDs and corresponding preprocessed cifti files obtained from fmriprep. The `trans_ABIDEI.sh` script performs the transformation for each subject, and the `submit_ABIDEI_cifti.sh` script submits the job in parallel.

After converting cifti files to fake nifti files, we run nuisance regression using the script from the code file. To do this, first run `gen_subjList.R` to generate a list of subject IDs and corresponding preprocessed cifti to nifti files. Then, the `Subj_36p_ABIDEI.sh` script performs the nuisance regression based on 9 parameters, 36 parameters, and 36 parameters with spike regression for each subject. Finally, the `submit_ABIDEI.sh` script submits the job in parallel.

After performing nuisance regression, the results will be generated in a nifti file format. To convert them back to cifti format, we can use scripts from the `nifti_to_cifti` folder. First, `gen_fake_template.R` generates a fake cifti template based on the original cifti file. Then, the `trans_ABIDEI.sh` script performs the transformation for each subject, and finally, the `submit_ABIDEI_nifti.sh` script submits the job in parallel.


## Step 4: Behavioral and demographic variable preprocessing

The project aggregates the phenotype information from ABIDEI and ABIDEII.

The code requires csv files with phenotype information downloaded from ABIDE
(see code for detailed urls): 
- `ABIDEII_Composite_Phenotypic.csv` Download ABIDE II Composite Phenotypic File from https://fcon_1000.projects.nitrc.org/indi/abide/abide_II.html
- `Phenotypic_V1_0b_preprocessed1.csv` This is ABIDE I phentype info. The preprocessed version contains a couple motion summaries we can use to audit our pipeline. (https://s3.amazonaws.com/fcp-indi/data/Projects/ABIDE_Initiative/Phenotypic_V1_0b_preprocessed1.csv)
- `ABIDE-II_KKI_1_AdditionalScanInfo.csv`: Contains receiving coil information used in data harmonization. This dataset can be downloaded at (https://fcon_1000.projects.nitrc.org/indi/abide/scan_params/ABIDEII-KKI_1/ABIDE-II_KKI_1_AdditionalScanInfo.csv).

Download these files from the above urls, then place them in the folder `data/`.

The code also requires a few files that we created

- `data/Delta_Outcome.Rdata`: Contains the motion quality information (mean_FD, mean_RMSD, etc) created by fmriprep and the inclusion indicator variables for Power and Ciric criteria. This was run on our cluster. Output of `code/scrubbing_ABIDE.R`. 
- `data/check_ABIDE_T1_v2.csv` This is a file the we created by visually inspecting the output of fmriprep using the fmriprep html files. This file flags images in which the cortical segmentation was unsatisfactory, or in which some other aspect of the image quality was deemed unacceptable. 

