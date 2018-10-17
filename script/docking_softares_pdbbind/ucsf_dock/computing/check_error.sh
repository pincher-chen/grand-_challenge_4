#!/bin/sh

data_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/ucsf_dock/refined-set

#cat ~/protine_ligand.list.bak > ${data_dir}/protein_ligand.list

##remove flag
#list=`cat incomplete_side_list.log`
list=`cat ~/protine_ligand.list.bak`
array=${list}

for i in ${array[@]}; do
#  echo "I am in ${i}"

  if [ ! -s ${data_dir}/${i}/${i}_flex_ranked.mol2 ]; then
    echo "${i}" >>failed_job6.log
  fi
done
