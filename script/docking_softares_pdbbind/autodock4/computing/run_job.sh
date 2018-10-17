#!/bin/sh
module load mgltools/1.5.6 AutoDock/4.2.6

script_root=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/autodock4/computing

for((index=0;index<24;index=index+1));do
  sleep 2s
  bash ${script_root}/autodock4.sh &
done
wait
