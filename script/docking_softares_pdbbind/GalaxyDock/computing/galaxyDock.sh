#!/bin/sh
vina_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/vina
data_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/GalaxyDock/refined-set

list=`cat ${data_dir}/protein_ligand.list`
array=${list}
for i in ${array[@]}; do
  
  if [ -e ${data_dir}/$i/galaxyDock_flag ]; then
    continue
  fi
  echo "i am in $i"

  sed -i "/${i}/d" ${data_dir}/protein_ligand.list
  touch ${data_dir}/${i}/galaxyDock_flag

#step 1. structure preparation
  cp ${data_dir}/${i}/${i}_protein.pdb ${data_dir}/${i}/${i}_protein_noCofacter.pdb
  sed -i '/HETATM/d' ${data_dir}/${i}/${i}_protein_noCofacter.pdb
  reduce -FLIP -Quiet ${data_dir}/${i}/${i}_protein_noCofacter.pdb >${data_dir}/${i}/${i}_protein_addH.pdb

  if [ ! -e ${data_dir}/$i/${i}_protein_addH.pdb ]; then
    echo "failed in reduce"
    continue
  fi
#step 2. docking by script
##2.1 get box info from vina
  center_x=`grep center_x ${vina_dir}/refined-set/${i}/min.conf | awk '{print $3}'`
  center_y=`grep center_y ${vina_dir}/refined-set/${i}/min.conf | awk '{print $3}'`
  center_z=`grep center_z ${vina_dir}/refined-set/${i}/min.conf | awk '{print $3}'`
  size_x=`grep size_x ${vina_dir}/refined-set/${i}/min.conf | awk '{print $3}'`
  size_y=`grep size_y ${vina_dir}/refined-set/${i}/min.conf | awk '{print $3}'`
  size_z=`grep size_z ${vina_dir}/refined-set/${i}/min.conf | awk '{print $3}'`

  cd ${data_dir}/${i}
#  sed -i '/HETATM/d' ${data_dir}/${i}/${i}_protein_addH.pdb

  python ~/sf_box/GalaxyDock_BP2/script/run_GalaxyDock_BP2.py -d /HOME/nscc-gz_pinchen/sf_box/GalaxyDock_BP2/  -p ${i}_protein_addH.pdb -l ${i}_ligand.mol2 -x ${center_x} -y ${center_y} -z ${center_z} -size_x ${size_x} -size_y ${size_y} -size_z ${size_z}

done

