#!/bin/sh

data_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/autodock4/refined-set

cat /HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/new-pro_lig.list > ${data_dir}/protein_ligand.list

##remove flag
list=`cat ${data_dir}/protein_ligand.list`
array=${list}

for i in ${array[@]}; do
  rm -v ${data_dir}/${i}/autodock4_flag 
done
