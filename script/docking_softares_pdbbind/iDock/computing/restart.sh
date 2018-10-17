#!/bin/sh

data_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/iDock/refined-set

#cat /HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/new-pro_lig.list > ${data_dir}/protein_ligand.list

##remove flag
list=`cat ${data_dir}/protein_ligand.list`
array=${list}

for i in ${array[@]}; do
  rm -v ${data_dir}/${i}/idock_flag ${data_dir}/${i}/min.conf
done
