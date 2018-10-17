#!/bin/sh

work_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/vina

data_dir=${work_dir}/refined-set
result_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/iDock/refined-set

list=`cat ${result_dir}/protein_ligand.list`
array=${list}
for i in ${array[@]}; do
  echo "i am in $i"
  
  mkdir -p ${result_dir}/${i}
  if [ -e ${result_dir}/$i/idock_flag ]; then
    continue
  fi
  
  
  sed -i "/${i}/d" ${result_dir}/protein_ligand.list
  touch ${result_dir}/$i/idock_flag
  #pdbqt for protein and ligand
  #$MGL_ROOT/bin/pythonsh  $pdbqt_prepare/prepare_receptor4.py -U nphs_lps_waters -r ${data_dir}/${i}/${i}_protein.pdb -o ${data_dir}/${i}/${i}_protein.pdbqt
  
 # if [ ! -e ${data_dir}/${i}/${i}_protein.pdbqt ]; then
  #  echo "This protein can not convert pdbqt format"
  #  continue
  #fi

  #$MGL_ROOT/bin/pythonsh  $pdbqt_prepare/prepare_ligand4.py -l ${data_dir}/${i}/${i}_ligand.mol2 -o ${data_dir}/${i}/${i}_ligand.pdbqt

  #for docking site
  #/HOME/nscc-gz_pinchen/sf_install/openbabel_static/bin/babel -isdf ${data_dir}/${i}/${i}_ligand.sdf -opdb -O ${data_dir}/${i}/${i}_ligand.pdb
  #$center_script_root/calcenter.py ${data_dir}/${i}/${i}_ligand.pdb ${i}> ${data_dir}/${i}/min.conf

  #for docking
  cp ${data_dir}/${i}/min.conf ${result_dir}/${i}/idock.conf
  sed -i "s/num_modes/conformations/g" ${result_dir}/${i}/idock.conf 
  idock --config ${result_dir}/${i}/idock.conf --ligand ${data_dir}/${i}/${i}_ligand.pdbqt --receptor ${data_dir}/${i}/${i}_protein.pdbqt  --out ${result_dir}/${i}/
  
done

