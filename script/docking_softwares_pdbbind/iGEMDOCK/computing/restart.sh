#!/bin/sh

data_dir=/HOME/nscc-gz_pinchen/NSFCGZ/project/pdbbind/work/iGEMDOCK/refined-set

#cat /HOME/nscc-gz_pinchen/NSFCGZ/project/pdbbind/work/new-pro_lig.list > ${data_dir}/protein_ligand.list

##remove flag
list=`cat ${data_dir}/protein_ligand.list`
array=${list}

for i in ${array[@]}; do
  rm -v ${data_dir}/${i}/iGEMDOCK_flag 
#  rm ${data_dir}/${i}/${i}_protein_addH.pdb 
#  rm -rvf ${data_dir}/${i}/1_ligand_library ${data_dir}/${i}/2_predock ${data_dir}/${i}/3_GalaxyDock
done
