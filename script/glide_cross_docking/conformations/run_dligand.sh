#!/bin/sh
for i in `ls *.mol2`;do
 #score=`~/sf_box/xscore_tmp/xscore_v1.3/c++/xscore -score ../../10gs_protein.pdb $i | grep "Predicted binding energy" | awk '{print $5}'`
 score=`~/sf_box/dligand/src_opt2/score2.gnu -P ../../10gs_protein.pdb -L $i`
 echo $i $score
done
