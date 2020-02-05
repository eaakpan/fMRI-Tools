#!/bin/tcsh

# Name: FSL_Field_Map.sh
# Author: Essang Akpan
# Date: March 22nd, 2019
# Purpose: Create a Field Map with FSL for distortion correction. 
# Applicable for a Siemens phase difference with two echo planar images. 
# Last modified: 03/22/19


#Initialize Freesurfer
setenv FREESURFER_HOME /usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.csh



#Convert images from .dcm to .nii
mri_convert 04-0001-000001.dcm FMrun01.nii.gz
mri_convert 05-0002-000001.dcm FMrun02.nii.gz


#Align Phase and Magnitude images
3dWarp -oblique2card -prefix  FMrun01_shift.nii.gz FMrun01.nii.gz
3dWarp -oblique2card -prefix  FMrun02_shift.nii.gz FMrun02.nii.gz


# FSL feild map comman template
# fsl_prepare_fieldmap <scanner> <phase_image> <magnitude_image> <out_image> <deltaTE (in ms)>

#Generate Field Map
fsl_prepare_fieldmap SIEMENS FMrun01_shift.nii.gz FMrun02_shift.nii.gz FieldMap.nii.gz 2.46 --nocheck


#Or open GUI to perform the command
fsl_prepare_fieldmap_gui



#Apply distortion correction to a functional image
fugue -i run01.nii.gz --loadfmap=FieldMap.nii.gz --noextend  -s 2 --dwell=0.00056 --unwarpdir=y- -u run01.fmap.nii.gz 




