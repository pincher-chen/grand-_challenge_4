#!/bin/sh

while read line;do
  if [ "$line" == "IDs,smiles"  ];then
      continue
  fi
  name=`echo $line | cut -d ',' -f 1`
  smi=`echo $line | cut -d ',' -f 2`
  #  $name
  dir=`echo $1| cut -d '.' -f 1`
  mkdir -p $dir
  echo $smi > $dir/$name.smi
done < $1
