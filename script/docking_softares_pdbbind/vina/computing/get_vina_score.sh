#!/bin/sh
simulation_data_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/vina/refined-set
simulation_vaule=`cat ~/protine_ligand.list.bak`
simulation_array=${simulation_vaule}

experiment_data_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/refined-set/index
experiment_vaule=`cat ${experiment_data_dir}/INDEX_refined_data.2016 | awk '{print $1}'`
experiment_array=${experiment_vaule}
echo "Protein experiment_data simulation_data">refined-data-vina.log

work_root=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/vina/computing

for i in ${simulation_array[@]}; do

  if [ ! -f ${simulation_data_dir}/${i}/${i}_docking_min.pdbqt ]; then
    echo "Docking failed in ${i}"
    continue
  fi

  echo "I am in $i"
  for j in ${experiment_array[@]};do 
    if [ "${i}" = "${j}" ]; then
      data1=`grep "$j " ${experiment_data_dir}/INDEX_refined_data.2016 |awk '{print $4}'`     
      data2_temp=`grep "REMARK VINA RESULT" ${simulation_data_dir}/${i}/${i}_docking_min.pdbqt | head -n1 | awk '{print $4}'`
      data2=$(echo "0 - $data2_temp" | bc)
      #echo "Protein experiment_data simulation_data">>refined-data-experiment.log
      echo "$i $data1 $data2" >> refined-data-vina.log
    fi
  done
done


