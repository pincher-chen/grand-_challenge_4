#!/bin/sh
for i in `ls *.sd`;do
  name=`echo $i| cut -d '.' -f 1`
  
  line_t=`sed -n "/r_i_docking_score/=" $i`
  line=`echo "$line_t + 1"|bc`
  score=`sed -n "${line}p" $i`

  echo "REMARK energy ${score}" > result/${name}.mol
  sed "/BACE/d" ${name}.mol >>result/${name}.mol
done
  
