#!/bin/sh

for((i=1;i<21;i++));do
   list=`grep "BACE_${i} " list.dat | sort -k3 -n|awk '{print $1}'`
   list_a=($list)
   for((j=0;j<5;j++));do
       lig_id=`grep ${list_a[${j}]} list.dat| awk '{print $2}'`
       m=`echo "${j}+1"|bc`
       mv -v  ${list_a[${j}]} result/5YGX-${lig_id}-${m}.sd
   done
done
