#!/bin/sh
data_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/ledock/refined-set
array=`cat /HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/new-pro_lig.list`

echo "Protein experiment_data simulation_data" >dligand_ledock.log
for i in ${array[@]}; do

  #if [ ! -s ${data_dir}/${i}/dligand/dligand_sorted.log ]; then
  #  echo "Docking failed in ${i}"
  #  continue
  #fi
#  echo "Protein experiment_data simulation_data" >dligand_vina.log
  score_tmp=`head -n 1 ${data_dir}/${i}/dligand/dligand_sorted.log | awk '{print $2}'`
  ex_data=`grep ${i} /HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/refined-data-xscore.log | awk '{print $2}'`
  score=`echo "0 - $score_tmp"| bc`
  echo "$i $ex_data ${score}" >>dligand_ledock.log

done


