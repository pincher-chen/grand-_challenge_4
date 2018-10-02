#!/bin/sh
#mkdir result
for i in `ls *.sd`;do
  name=`head -n 1 $i| cut -d ':' -f 1| cut -d '.' -f 1`
  line_t=`sed -n "/r_i_docking_score/=" $i`
  line=`echo "${line_t}+1"|bc`
  score=`sed -n "${line}p" $i`
  echo ${i} $name $score
  
  #echo $name
  #if [ ! -f result/5YGX-$name.sd ];then
  # mv  $i result/5YGX-$name.sd
  #else 
  #  mv $i result/5YGX-$name-1.sd
  #elif [ ! -f result/5YGX-$name-1.sd] 
  # mv $i result/5YGX-$name-1.sd
  #elif [ ! -f result/5YGX-$name-2.sd ]
  # mv $i result/5YGX-$name-2.sd
  #fi
done
