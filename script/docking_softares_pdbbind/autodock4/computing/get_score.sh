#!/bin/sh

data_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/autodock4/refined-set-bak

#cat /HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/new-pro_lig.list > ${data_dir}/protein_ligand.list

##remove flag
list=`cat /HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/new-pro_lig.list`
array=${list}

for i in ${array[@]}; do
  score=`sed -n '2,2p' ${data_dir}/${i}/summary_result.txt | cut -d , -f 3`
  test_num=`echo "$score <0" | bc`
  if [ $test_num -eq 1 ]; then
    echo "$i $score" >> refined-data-test.log 
  fi
done
