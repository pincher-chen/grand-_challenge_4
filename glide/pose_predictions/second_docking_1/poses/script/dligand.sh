#!/bin/sh
data_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/schrodinger/second_docking_1/poses
for((i=1;i<11;i++));do
   #score=`~/sf_box/dligand/src_opt2/score2.intel -P ${data_dir}/5ygx-no-lig.pdb -L ${data_dir}/mol2/5YGX-BACE-01-${i}.mol2 `
   score=`~/sf_box/dligand/src_opt2/score2.intel -etype 2 -P ${data_dir}/5ygx-no-lig.pdb -L ${data_dir}/mol2/5YGX-BACE-01-${i}.mol2 `
   echo $i $score
done
