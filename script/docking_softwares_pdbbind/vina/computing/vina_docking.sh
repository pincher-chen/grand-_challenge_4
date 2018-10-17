#!/bin/sh

module load Openbabel/2.3.2
module load mgltools/1.5.6
module load Python/2.7.9-fPIC

#export LD_LIBRARY_PATH=/WORK/app/Openbabel/2.3.2/lib:$LD_LIBRARY_PATH

MGL_ROOT=/WORK/app/mgltools/1.5.6
pdbqt_prepare=${MGL_ROOT}/MGLToolsPckgs/AutoDockTools/Utilities24
work_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/vina
center_script_root=/HOME/nscc-gz_pinchen/sf_box/misc

data_dir=${work_dir}/refined-set

list=`cat ${data_dir}/protein_ligand.list | sed -e '/^$/d'`
array=${list}
for i in ${array[@]}; do
  echo "i am in $i"
  
  if [ -e ${data_dir}/$i/vina_flag ]; then
    continue
  fi
  
  
  sed -i "/${i}/g" ${data_dir}/protein_ligand.list
  touch ${data_dir}/$i/vina_flag
  #pdbqt for protein and ligand
  $MGL_ROOT/bin/pythonsh  $pdbqt_prepare/prepare_receptor4.py -U nphs_lps_waters -r ${data_dir}/${i}/${i}_protein.pdb -o ${data_dir}/${i}/${i}_protein.pdbqt
  
  if [ ! -e ${data_dir}/${i}/${i}_protein.pdbqt ]; then
    echo "This protein can not convert pdbqt format"
    continue
  fi

  $MGL_ROOT/bin/pythonsh  $pdbqt_prepare/prepare_ligand4.py -l ${data_dir}/${i}/${i}_ligand.mol2 -o ${data_dir}/${i}/${i}_ligand.pdbqt

  #for docking site
  /HOME/nscc-gz_pinchen/sf_install/openbabel_static/bin/babel -isdf ${data_dir}/${i}/${i}_ligand.sdf -opdb -O ${data_dir}/${i}/${i}_ligand.pdb
  $center_script_root/calcenter.py ${data_dir}/${i}/${i}_ligand.pdb ${i}> ${data_dir}/${i}/min.conf

  #for docking
  vina --cpu 1 --config ${data_dir}/${i}/min.conf --ligand ${data_dir}/${i}/${i}_ligand.pdbqt --receptor ${data_dir}/${i}/${i}_protein.pdbqt  --out ${data_dir}/${i}/${i}_docking_min.pdbqt
  
done

