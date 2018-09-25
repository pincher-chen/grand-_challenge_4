#!/bin/sh
for i in `ls *sd`;do
  name=`echo $i| cut -d '.' -f 1`
#  ligprep -imae ${name}.maegz  -osd ${name}.sd -epik
  babel ${name}.sd -omol2 ${name}.mol2 -m 
done
  
