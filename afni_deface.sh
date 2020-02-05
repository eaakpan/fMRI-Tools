#!/bin/tcsh

# Name: deface_script.sh
# Author: Essang Akpan
# Date: April 5th, 2019
# Purpose: Defacing anaimoical images with Freesurfer <mri_deface> function
# Requirements: <talairach_mixed_with_skull.gca>  <face.gca> 
# Last modified: 04/05/19


#Initialize Freesurfer
setenv FREESURFER_HOME /usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.csh


# Convert T1.mgz from  subject's freesurfer /mri folder 
mri_deface T1.mgz talairach_mixed_with_skull.gca face.gca anat_df_t1.mgz


# Convert .mgz to .nii
mri_convert anat_df_t1.mgz anat_df_t1.nii.gz




