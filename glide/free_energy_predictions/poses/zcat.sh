#!/bin/sh

for i in `ls *sdfgz`;do
   name=`echo $i | cut -d '.' -f 1`
   zcat $i > $name.sdf
done
