#!/bin/sh

data_dir=/HOME/nscc-gz_pinchen/NSFCGZ/project/pdbbind/work/iGEMDOCK/refined-set

#cat /HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/new-pro_lig.list > ${data_dir}/protein_ligand.list

##remove flag
list=`cat /HOME/nscc-gz_pinchen/NSFCGZ/project/pdbbind/work/new-pro_lig.list`
array=${list}

for i in ${array[@]}; do
  if [ ! -s ${data_dir}/${i}/output/gemdock_out/docking_dock_log ];then
    echo "job failed in ${i}"
    score=0
  else
    score=`sed -n '5,5p' ${data_dir}/${i}/output/gemdock_out/docking_dock_log | awk '{print $2}'`
  fi

  echo "$i $score" >> refined-data-iGEMDOCK.log 
done
