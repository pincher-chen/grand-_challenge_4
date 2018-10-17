#!/bin/sh
module load AutoDock_Vina/1.1.2
module load Openbabel/2.3.2
module load mgltools/1.5.6
module load Python/2.7.9-fPIC

script_root=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/vina/computing

for((index=0;index<24;index=index+1));do
  sleep 1s
  bash ${script_root}/vina_docking.sh &
done
wait
