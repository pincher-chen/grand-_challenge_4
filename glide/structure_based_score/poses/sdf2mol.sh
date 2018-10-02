#!/bin/sh

for i in `ls *sdf`;do
  name=`echo $i| cut -d '.' -f 1`
#  ligprep -imae ${name}.maegz  -osd ${name}.sd -epik
  id_t=`echo $i | cut -d '_' -f 4 | cut -d '-' -f 2`
  id=`echo ${id_t:2:3}`
  babel ${name}.sdf -osd ./sd/5YGX-BACE_${id}-.sd -m 
done
