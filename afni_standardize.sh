#!/bin/tcsh

# Name: Anatomical_Standardize.sh
# Author: Essang Akpan
# Date: September 2nd, 2019
# Purpose: Convert anatomical images from native to MNI 152 standard space with SS_warper. 
#  Then convert functional images to MNI 152 standard space with 3dNwarpapply
# Requirements: MNI 152 template <MNI152_2009_template_SSW.nii.gz> 
# Last modified: 09/02/19

# Set path to SUbject Directory
set Use_Path = "/home/User/Documents/Subjects"

#Set list for every subject to be included in the loop
set only_valid_subject_list = (001) 

foreach subj_number ($only_valid_subject_list)


cd ${Use_Path}/${subj_number}

# Create directory for standardize output files
mkdir SSwarp

# copy/paste anatomical image to /SSwarp directory
cp anat+orig.BRIK SSwarp/anat+orig.BRIK
cp anat+orig.HEAD SSwarp/anat+orig.HEAD


# Stanardize native space anatomical to MNI space
@SSwarper          								\
        -input SSwarp/anat+orig 				\
        -base  MNI152_2009_template_SSW.nii.gz  \



# Convert standardized anatomical from .nii to afni .BRIK/.HEAD
# move to subject's main folder
3dcopy ${Use_Path}/${subj_number}/SSwarp/anatQQ.nii ${Use_Path}/${subj_number}/anatQQ


# Standardize functional run
# apply catenated xform then apply non-linear standard-space warp
3dNwarpApply -master anatQQ+tlrc -dxyz 3                       								  \
             -source run01+orig                     										  \
             -nwarp "SSwarp/anatQQ.SS_MPRAGE_ns_WARP.nii SSwarp/anatQQ.SS_MPRAGE_ns.aff12.1D" \
             -prefix run01


end

