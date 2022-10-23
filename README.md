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
*Note*: csic cluster already have docker installed, but one needs to get permission to run docker on the cluster.






