#!/bin/sh
name=$1
score=`../script/glide.sh $name| sort -k 2 -n `
#a=`cat .tmp`
id_t=`echo $name | cut -d '_' -f 3 | cut -d '_' -f 2| cut -d '-' -f 2`
id=`echo ${id_t:2:4}`

#exit
echo $score
list=($score)
#echo ${list[2]}

count=1
for i in 0 2 4 6 8;do
  echo ${list[${i}]}
  j=`echo "$i+1"|bc`
  echo "REMARK energy ${list[${j}]}" > 5YGX-BACE_${id}-${count}.mol
  #if [ "${id}" == "10" ];then
  sed "/BACE/d" ../mol/5YGX-BACE-${id}-${list[${i}]}.mol >> 5YGX-BACE_${id}-${count}.mol
  #else 
  #  sed "/BACE/d" ../mol/5YGX-BACE-0${id}-${list[${i}]}.mol >>5YGX-BACE_${id}-${count}.mol
  #fi
  count=`echo "$count +1"|bc`
done
#echo ${score}| head -n 1
