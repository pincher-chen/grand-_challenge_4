#!/bin/sh
name=$1
line_list=`sed -n "/r_i_docking_score/=" ../${name}`

count=1
for i in ${line_list[@]};do
   p=`echo "$i +1"| bc`
   #echo $p
   score=`sed -n "${p}p" ../${name}`
   echo $count $score
   #(($count++))
   count=`echo "$count +1"| bc`

done

#while read line;do
#  if [ "$line" == "> <r_i_docking_score>"  ];then
#  echo $line
#  fi
#done < second_docking_1-0001_raw.sdf
