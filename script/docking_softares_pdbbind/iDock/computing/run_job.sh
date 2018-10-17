#!/bin/sh

script_root=/HOME/nscc-gz_pinchen/WORKSPACE/project/pdbbind/work/iDock/computing

for((index=0;index<24;index=index+1));do
  sleep 2s
  bash ${script_root}/idock.sh &
done
wait
