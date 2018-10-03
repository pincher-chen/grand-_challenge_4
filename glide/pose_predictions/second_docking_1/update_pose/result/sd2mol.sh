#!/bin/sh
for i in `ls *.sd`;do
  name=`echo $i | cut -d '.' -f 1`
  babel $i -omol ${name}.mol
done
