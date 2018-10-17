#!/bin/sh
#module load glibc/2.17
module load Python/2.7.9-fPIC

work_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/ledock
data_dir=${work_dir}/refined-set
script_dir=${work_dir}/computing

list=`cat ${data_dir}/protein_ligand.list | sed -e '/^$/d'`
array=${list}
for i in ${array[@]}; do
  echo "i am in $i"

  if [ -e ${data_dir}/$i/ledock_flag ]; then
    continue
  fi

  sed -i "/${i}/g" ${data_dir}/protein_ligand.list
  touch ${data_dir}/$i/ledock_flag

  #cd ${data_dir}/${i}

#step 1. cleate ligand pdb, and convert protein pdb
  ~/sf_install/openbabel_static/bin/babel  ${data_dir}/${i}/${i}_ligand.mol2 -O ${data_dir}/${i}/${i}_ligand.pdb
  cd ${data_dir}/${i}
  if [ ! -e ${i}_ligand.pdb ]; then
    echo "Failed to convert format"
    continue
  fi

  ~/bin/lepro_linux_x86 ${i}_protein.pdb
#step 2. create conf file
  /WORK/app/Python/2.7.9-fPIC/bin/python  ~/sf_box/misc/calcenter_le.py ${i}_ligand.pdb ${i} >./dock.in

#step 3. create ligand list
  echo "${i}_ligand.mol2" >ligands.list

#step 4. docking
  ledock dock.in
done
