#!/bin/sh

data_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/rDock/refined-set

#cat ~/protine_ligand.list.bak > ${data_dir}/protein_ligand.list

##remove flag
list=`cat ${data_dir}/protein_ligand.list`
array=${list}

for i in ${array[@]}; do
  #rm -v ${data_dir}/${i}/rDock_flag
  #rm -v -rf  ${data_dir}/${i}/conformations
  rm -v -rf  ${data_dir}/${i}/dligand
done
