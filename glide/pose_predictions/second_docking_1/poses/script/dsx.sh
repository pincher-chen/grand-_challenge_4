#!/bin/sh
data_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/schrodinger/second_docking_1/poses
for((i=1;i<11;i++));do
   #score=`~/sf_box/dligand/src_opt2/score2.intel -P ${data_dir}/5ygx-no-lig.pdb -L ${data_dir}/mol2/5YGX-BACE-01-${i}.mol2 `
#   score=`~/sf_box/dligand/src_opt2/score2.intel -P ${data_dir}/5ygx-pro.pdb -L ${data_dir}/mol2/5YGX-BACE-01-${i}.mol2 `
   sc=`~/sf_box/dsx090_and_hotspotsx061_linux/linux32/dsx -P ${data_dir}/5ygx-no-lig.pdb -L ${data_dir}/mol2/5YGX-BACE-01-${i}.mol2 `
  score=` tail -n 2 DSX_5ygx-no-lig_5YGX-BACE-01-${i}.txt | awk '{print $7}'`
  rm DSX_5ygx-no-lig_5YGX-BACE-01-${i}.txt
   echo $i $score
done
