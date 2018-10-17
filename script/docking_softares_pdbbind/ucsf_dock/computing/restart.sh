#!/bin/sh

data_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/ucsf_dock/refined-set

#cat ./incomplete_side_list.log > ${data_dir}/protein_ligand.list

##remove flag
list=`cat ${data_dir}/protein_ligand.list`
array=${list}

for i in ${array[@]}; do
  rm -v ${data_dir}/${i}/${i}_flex_ranked.mol2 ${data_dir}/${i}/dock6_flag ${data_dir}/${i}/OUTSPH ${data_dir}/${i}/*.sph ${data_dir}/${i}/temp* ${data_dir}/${i}/*.ms 
done
