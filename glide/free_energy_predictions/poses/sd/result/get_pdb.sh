#!/bin/sh
for i in `ls *.mol`;do
  name=`echo $i | cut -d '.' -f 1`
  cp /HOME/nscc-gz_pinchen/WORKSPACE/project/grand_challenge/bace1a/5ygx-no-lig.pdb  $name.pdb
done
