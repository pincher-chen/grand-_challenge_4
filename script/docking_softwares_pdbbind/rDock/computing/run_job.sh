#!/bin/sh
#module load glibc/2.17
script_dir=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/rDock/computing

for((index=0;index<8;index=index+1));do
  sleep 2s
  bash ${script_dir}/rDock_docking.sh &
done
wait
