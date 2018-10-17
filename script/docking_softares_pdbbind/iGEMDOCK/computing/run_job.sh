#!/bin/sh
#module load Python/2.7.3

script_root=/HOME/nscc-gz_pinchen/NSFCGZ/project/pdbbind/work/iGEMDOCK/computing

for((index=0;index<24;index=index+1));do
  sleep 4s
  bash ${script_root}/iGEMDOCK.sh &
done
wait
