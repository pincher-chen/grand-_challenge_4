#!/bin/sh
module load mgltools/1.5.6 AutoDock/4.2.6

root_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/autodock4
data_dir=${root_dir}/refined-set
vina_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/vina
i=$1
#list=`cat ${data_dir}/protein_ligand.list`
#array=${list}
#for i in ${array[@]}; do
  #echo "i am in $i"

#  mkdir -p ${data_dir}/${i}
#  if [ -e ${data_dir}/$i/autodock4_flag ]; then
#    continue
#  fi
  
  echo "i am in $i"
  
#  sed -i "/${i}/d" ${data_dir}/protein_ligand.list
#  touch ${data_dir}/$i/autodock4_flag
#  mkdir -p ${data_dir}/${i}

#step 1. copy pdbqt files from vina
#  mkdir -p ${data_dir}/${i}
#  cd ${data_dir}/${i}
#  cp ${vina_dir}/refined-set/${i}/${i}_protein.pdbqt ${vina_dir}/refined-set/${i}/${i}_ligand.pdbqt ${data_dir}/${i}/ 
MGL_ROOT=/WORK/app/mgltools/1.5.6
pdbqt_prepare=${MGL_ROOT}/MGLToolsPckgs/AutoDockTools/Utilities24

#cp ${data_dir}/${i}/${i}_protein.pdb ${data_dir}/${i}/${i}_protein_noCofactor.pdb
#sed -i '/HETATM/d' ${data_dir}/${i}/${i}_protein_noCofactor.pdb
#~/sf_box/MOLS2.0/reduce -NOFLIP -Quiet ${data_dir}/${i}/${i}_protein_noCofactor.pdb >${data_dir}/${i}/${i}_protein_addH.pdb

$MGL_ROOT/bin/pythonsh  $pdbqt_prepare/prepare_receptor4.py  -r ${data_dir}/${i}/${i}_protein.pdb -o ${data_dir}/${i}/${i}_protein.pdbqt
$MGL_ROOT/bin/pythonsh  $pdbqt_prepare/prepare_ligand4.py -l ${data_dir}/${i}/${i}_ligand.mol2 -o ${data_dir}/${i}/${i}_ligand.pdbqt

#step 2. prepare gpf file
  center_x=`grep "center_x" ${vina_dir}/refined-set/${i}/min.conf |awk '{print $3}'`
  center_y=`grep "center_y" ${vina_dir}/refined-set/${i}/min.conf |awk '{print $3}'`
  center_z=`grep "center_z" ${vina_dir}/refined-set/${i}/min.conf |awk '{print $3}'`

  pythonsh /WORK/app/mgltools/1.5.6/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_gpf4.py -p gridcenter="${center_x},${center_y},${center_z}"  -l ${data_dir}/${i}/${i}_ligand.pdbqt -r ${data_dir}/${i}/${i}_protein.pdbqt -o ${data_dir}/${i}/${i}_docking.gpf

#step 3. prepare dpf file
  #pythonsh /WORK/app/mgltools/1.5.6/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_dpf42.py -l ${data_dir}/${i}/${i}_ligand.pdbqt -r ${data_dir}/${i}/${i}_protein.pdbqt -o ${data_dir}/${i}/${i}_docking.dpf -p ga_num_evals=1750000 -p ga_pop_size=150 -p ga_run=10 -p rmstol=2.0
  pythonsh /WORK/app/mgltools/1.5.6/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_dpf42.py -l ${data_dir}/${i}/${i}_ligand.pdbqt -r ${data_dir}/${i}/${i}_protein.pdbqt -o ${data_dir}/${i}/${i}_docking.dpf ga_run=10
#step 4. run autogrid4
  autogrid4-2 -p ${data_dir}/${i}/${i}_docking.gpf -l ${data_dir}/${i}/${i}_docking.glg

#step 5. run autodock4
  autodock4-2 -p ${data_dir}/${i}/${i}_docking.dpf -l ${data_dir}/${i}/${i}_docking.dlg
  
 
#step 6. get score
  pythonsh /WORK/app/mgltools/1.5.6/MGLToolsPckgs/AutoDockTools/Utilities24/summarize_results4.py -d ${data_dir}/${i} -o ${data_dir}/${i}/summary_result.txt
#setp 7. get conformation
  pythonsh /WORK/app/mgltools/1.5.6/MGLToolsPckgs/AutoDockTools/Utilities24/write_conformations_from_dlg.py -d ${data_dir}/${i}/${i}_docking.dlg
  mkdir ${data_dir}/${i}/conformations/
  mv ${data_dir}/${i}/${i}_ligand_*.pdbqt ${data_dir}/${i}/conformations/
#done
