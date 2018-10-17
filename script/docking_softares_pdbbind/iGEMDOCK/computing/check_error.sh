#!/bin/sh

data_dir=/HOME/nscc-gz_pinchen/NSFCGZ/project/pdbbind/work/iGEMDOCK/refined-set

#cat /HOME/nscc-gz_pinchen/NSFCGZ/project/pdbbind/work/new-pro_lig.list > ${data_dir}/protein_ligand.list

##remove flag
list=`cat /HOME/nscc-gz_pinchen/NSFCGZ/project/pdbbind/work/new-pro_lig.list`
array=${list}

for i in ${array[@]}; do
   #echo " I am in ${i}"
#  rm -v ${data_dir}/${i}/idock_flag ${data_dir}/${i}/min.conf
   if [ ! -f  ${data_dir}/${i}/output/gemdock_out/docking_dock_log ];then
   echo "job failed in ${i}"
#   echo "${i}" >>${data_dir}/protein_ligand.list
   fi
done
