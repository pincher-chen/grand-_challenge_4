#!/bin/sh
#module load glibc/2.17
script_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/ucsf_dock/computing

for((index=0;index<8;index=index+1));do
  sleep 4s
  bash ${script_dir}/ucsf_docking6.sh &
done
wait
