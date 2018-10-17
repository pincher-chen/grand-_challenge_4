#!/bin/sh
module load glibc/2.17

work_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/rDock
data_dir=${work_dir}/refined-set
script_dir=${work_dir}/computing

list=`cat ${data_dir}/protein_ligand.list | sed -e '/^$/d'`
array=${list}
for i in ${array[@]}; do
  echo "i am in $i"

  if [ -e ${data_dir}/$i/rDock_flag ]; then
    continue
  fi

  sed -i "/${i}/d" ${data_dir}/protein_ligand.list
  touch ${data_dir}/$i/rDock_flag

  #cd ${data_dir}/${i}
#step 1 babel protein.pdb to protein.mol2, ligand.mol2 to ligand.sd
#  ~/sf_install/openbabel_static/bin/babel -ipdb ${data_dir}/${i}/${i}_protein.pdb -omol2 -O ${data_dir}/${i}/${i}_protein.mol2
  ~/sf_install/openbabel_static/bin/babel -imol2 ${data_dir}/${i}/${i}_ligand.mol2 -osd -O ${data_dir}/${i}/${i}_ligand.sd
  cd ${data_dir}/${i}
  if [ ! -e ${i}_protein.mol2 ] || [ ! -e ${i}_ligand.sd ]; then
    echo "Failed to convert format"
    continue
  fi
#system definiton

echo "RBT_PARAMETER_FILE_V1.00
TITLE pdbbind_refined-set

RECEPTOR_FILE ${i}_protein.mol2
RECEPTOR_FLEX 3.0

##################################################################
### CAVITY DEFINITION: REFERENCE LIGAND METHOD
##################################################################
SECTION MAPPER
    SITE_MAPPER RbtLigandSiteMapper
    REF_MOL ${i}_ligand.sd
    RADIUS 10.0
    SMALL_SPHERE 1.0
    MIN_VOLUME 100
    MAX_CAVITIES 1
    VOL_INCR 0.0
   GRIDSTEP 0.5
END_SECTION

#################################
#CAVITY RESTRAINT PENALTY
#################################
SECTION CAVITY
    SCORING_FUNCTION RbtCavityGridSF
    WEIGHT 1.0
END_SECTION " > ./${i}_rdock.prm
  
  if [ ! -e ${i}_rdock.prm ]; then
    echo "Fail to create prm file"
    continue
  fi

#step 3. cavity generation
  rbcavity -was -d -r ${i}_rdock.prm

#step 4. docking

  rbdock -i ${i}_ligand.sd -o ${i}_rdock.out  -r ${i}_rdock.prm -p dock.prm -n 50
  sdsort -n -f'SCORE' ${i}_rdock.out.sd > ${i}_rdock_sorted.sd
done
