#!/bin/sh

for i in `ls *.sd`;do
  id=`head -n 1 $i | cut -d ':' -f 1| cut -d '.' -f 1`

 line_t=`sed -n "/r_i_docking_score/=" $i`
 line=`echo "$line_t + 1"|bc`
 score=`sed -n "${line}p" $i`

 echo $i $id $score

done 

  
