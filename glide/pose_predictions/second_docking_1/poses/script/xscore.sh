#!/bin/sh
data_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/schrodinger/second_docking_1/poses
for((i=1;i<11;i++));do
   score=`~/sf_box/xscore_tmp/xscore_v1.3/c++/xscore -score ${data_dir}/5ygx-pro.pdb ${data_dir}/mol2/5YGX-BACE-01-${i}.mol2 | grep "Predicted binding energy" | awk '{print $5}'`
   echo $i $score
done
