# grand-_challenge_4

This project is about a molecule docking excise. The detailed decriptions about this excise can be see in: https://drugdesigndata.org/about/grand-challenge-4.

## For BACE
### Input file preparation
- 1.Get input file from official website
```
$ ls *csv *fasta
BACE_FEset_compounds_D3R_GC4.csv  #SMILES strings of the molecules in the free energy set (34 molecules) for the calculation of relative or absolute binding affinities.
BACE_score_compounds_D3R_GC4.csv  #SMILES strings of the 154 compounds for affinity prediction or ranking
BACE_pose_compounds_D3R_GC4.csv   #SMILES strings of the 20 ligands to be docked and the FASTA sequence of the target
BACE_target_D3R_GC4.fasta         #the FASTA sequence of the target, BACE
```
- 2.Get BACE structure from PDB website
```
wget https://files.rcsb.org/download/5YGX.pdb
```

- 3.Get ligand 3D structure based on SMILES strings
Here, ligprep tool in Schrodinger suites is used to obtain sd format file. It should be noted that the smi file format. 
```
$ ls *smi
BACE_102.smi  BACE_114.smi  BACE_129.smi  BACE_146.smi  BACE_53.smi  BACE_62.smi  BACE_78.smi
BACE_105.smi  BACE_117.smi  BACE_130.smi  BACE_14.smi   BACE_56.smi  BACE_63.smi  BACE_81.smi
BACE_109.smi  BACE_122.smi  BACE_131.smi  BACE_48.smi   BACE_57.smi  BACE_68.smi  BACE_83.smi
BACE_10.smi   BACE_125.smi  BACE_138.smi  BACE_49.smi   BACE_60.smi  BACE_73.smi  BACE_84.smi
BACE_110.smi  BACE_127.smi  BACE_145.smi  BACE_51.smi   BACE_61.smi  BACE_75.smi
$ cat BACE_10.smi 
COCc1cc2cc(c1)C(=O)N[C@@H](C[C@H](C)CCOCCCCN2)[C@H](O)CNCc3cc(ccc3)C(C)C
$ cat smi2sd.sh 
#!/bin/sh
list=`ls *smi`
for i in  `ls *.smi`;do
  echo $i
  j=`echo $i | cut -d '.' -f 1`
  ligprep -ismi $j.smi -osd $j.sd -epik
  #echo $j
done
```

### Start to dock
Here, we chose glide to run molecule docking.
- 1. Protein preparation. Check the format of 5YGX.pdb.
- 2. Create gride file. It should be noted the docking box size, for one cocrytal ligand exited in 5YGX, but the size of this ligand is smaller than the docking ligands. Besides, the docking ligands are more complecated with many branched chains and aromatic rings. It will be better to use Sitemap tool to check the docking sites in the protein of 5YGX. Finally, we chose the docking site with (18.94, 40.55, -6.39) extended by box with 30 A. This box size contain two top 2 docking site (Calculated by Sitmap and Fpocket tool).
- 3. Xp (extra precision) score function is used. 10 poses are considersied to save. Result files can be seen in glide folder.

## For CatS
