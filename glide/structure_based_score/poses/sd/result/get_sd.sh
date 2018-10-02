#!/bin/sh
#for i in `cat final.list`;do
 # echo $i
  #cp  ../$i . 
#done
count=1
while read line;do
  file_name=`echo $line| awk '{print $1}'`
  ligand_id=`echo $line| awk '{print $2}'`
  score=`echo $line| awk '{print $3}'`

  #babel ../${file_name} -omol 5YGX-${ligand_id}.mol
  echo "${ligand_id},${count},${score}" >>LigandScores.csv
  count=`echo "$count + 1"|bc`
done < final-rank-1.list
