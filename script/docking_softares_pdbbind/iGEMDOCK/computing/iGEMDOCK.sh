#!/bin/sh
#vina_dir=/HOME/nscc-gz_pinchen/NSFCGZ/project/pdbbind/work/vina
data_dir=/HOME/nscc-gz_pinchen/NSFCGZ/project/pdbbind/work/iGEMDOCK/refined-set
sf_dir=/HOME/nscc-gz_pinchen/sf_box/iGEMDOCKv2.1-centos

list=`cat ${data_dir}/protein_ligand.list`
array=${list}
for i in ${array[@]}; do
  
  if [ -e ${data_dir}/$i/iGEMDOCK_flag ]; then
    continue
  fi
  echo "i am in $i"

  sed -i "/${i}/d" ${data_dir}/protein_ligand.list
  touch ${data_dir}/${i}/iGEMDOCK_flag

#step 1. docking
  mkdir -p ${data_dir}/${i}/output/gemdock_out
  echo "${data_dir}/${i}/${i}_ligand.mol2" >${data_dir}/${i}/output/gemdock_out/docking.lst
  
  ${sf_dir}/bin/mod_ga -d ${data_dir}/${i}/output 300 ${data_dir}/${i}/${i}_protein.pdb ${data_dir}/${i}/output/gemdock_out/docking.lst 6 1 1 1 2 0 70 10 1 1 0 

done

