#!/bin/sh

for i in `ls *.mol`;do
   name=`echo $i | cut -d '.' -f 1`
   #echo $name
   cp  ../5ygx-pro.pdb ${name}.pdb
done 
