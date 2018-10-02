#!/bin/sh

for i in `cat name.list`;do
    #while read line;do
    #  line_t=`echo $line | awk '{print $2}'`
    #  score
    #  if [ "$line_t"=="$i" ];then
        
    score=`grep "$i " score_list.dat| sort -k 3 -n | head -n 1 `
    echo $score
done

