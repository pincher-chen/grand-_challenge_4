#!/bin/sh

data_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/rDock/refined-set
data_1_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/ucsf_dock/refined-set
#cat ~/protine_ligand.list.bak > ${data_dir}/protein_ligand.list

##remove flag
list=`cat ${data_dir}/protein_ligand.list`
array=${list}

for i in ${array[@]}; do
 # rm -v ${data_dir}/${i}/rDock_flag
  cp $data_1_dir/${i}/${i}_protein_charged.mol2 ${data_dir}/${i}/
done
