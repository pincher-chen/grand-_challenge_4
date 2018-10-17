#!/bin/sh
module load Python/2.7.3

script_root=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/GalaxyDock/computing

for((index=0;index<24;index=index+1));do
  sleep 2s
  bash ${script_root}/galaxyDock.sh &
done
wait
