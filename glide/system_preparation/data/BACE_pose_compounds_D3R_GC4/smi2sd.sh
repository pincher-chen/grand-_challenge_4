#!/bin/sh
list=`ls *smi`
for i in  `ls *.smi`;do
  echo $i
  j=`echo $i | cut -d '.' -f 1`
  ligprep -ismi $j.smi -osd $j.sd -epik
  #echo $j
done

