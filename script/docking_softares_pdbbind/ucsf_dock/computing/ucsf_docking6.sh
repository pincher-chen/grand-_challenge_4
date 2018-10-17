#!/bin/sh
#module load glibc/2.17
#module load Python/2.7.9-fPIC
source /WORK/app/osenv/ln1/set3.sh

work_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/ucsf_dock
data_dir=${work_dir}/refined-set
script_dir=${work_dir}/computing

list=`cat ${data_dir}/protein_ligand.list | sed -e '/^$/d'`
array=${list}
for i in ${array[@]}; do
  echo "i am in $i"

  if [ -e ${data_dir}/$i/dock6_flag ]; then
    continue
  fi

  if [ -e ${data_dir}/$i/${i}_flex_ranked.mol2 ]; then
    continue
  fi

  sed -i "/${i}/d" ${data_dir}/protein_ligand.list
  touch ${data_dir}/$i/dock6_flag

  #cd ${data_dir}/${i}

#start docking.
  cd ${data_dir}/${i}
  ${script_dir}/local_docking6.sh ${i}
  
done
