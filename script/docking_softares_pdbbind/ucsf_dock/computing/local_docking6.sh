#!/bin/sh

source /WORK/app/osenv/ln1/set3.sh

#step 1. Preparation
#convert protein to mol2 format, and add charge
name=$1
pro_name=${name}_protein
lig_name=${name}_ligand
dock6_home=~/sf_box/dock6

echo "import chimera
from DockPrep import prep
models = chimera.openModels.list(modelTypes=[chimera.Molecule])
prep(models)
from WriteMol2 import writeMol2
writeMol2(models, \"${pro_name}_charged.mol2\")
" >prep_protein.py

##~/.local/UCSF-Chimera64-1.12rc/bin/chimera  --nogui ${pro_name}.pdb prep_protein.py

#delete Hydrogen
###cp ${pro_name}.pdb ${pro_name}_noH.pdb
###sed -i '/ H/d' ${pro_name}_noH.pdb
##~/sf_install/openbabel_static/bin/babel ${pro_name}.pdb -O ${pro_name}_noH.pdb -d

#convert ligand to mol2 fromat,and add charge
##echo "import chimera
##from DockPrep import prep
##models = chimera.openModels.list(modelTypes=[chimera.Molecule])
##prep(models)
##from WriteMol2 import writeMol2
##writeMol2(models, \"${lig_name}_charged.mol2\")
##" > prep_ligand.py

##~/.local/UCSF-Chimera64-1.12rc/bin/chimera  --nogui ${lig_name}.mol2 prep_ligand.py 
cp ${lig_name}.mol2 ${lig_name}_charged.mol2

##step 2. Generating spheres
#generate the molecular surface of the receptor
dms ${pro_name}_noH.pdb -n -w 1.4 -v -o rec.ms

#generate the spheres surrounding the receptor,note "INSPH" file, this will create a rec.sph file
echo "rec.ms
R
X
0.0
4.0
1.4
rec.sph
" > INSPH

sphgen_cpp

#select spheres within 10 ang of ligand
sphere_selector rec.sph ${lig_name}_charged.mol2 60.0

##step 3. Generating the grid
#construct box to enclose spheres, need box.in file
echo "Y
10
./selected_spheres.sph
1
${pro_name}_box.pdb
" >box.in
showbox < box.in

#compute scoring grids, need grid.in file
echo "compute_grids                  yes
grid_spacing                   0.3
output_molecule                no
contact_score                  no
energy_score                   yes
energy_cutoff_distance         9999
atom_model                     a
attractive_exponent            6
repulsive_exponent             12
distance_dielectric            yes
dielectric_factor              4
bump_filter                    yes
bump_overlap                   0.75
receptor_file                  ./${pro_name}_charged.mol2
box_file                       ${pro_name}_box.pdb
vdw_definition_file            ${dock6_home}/parameters/vdw_AMBER_parm99.defn
score_grid_prefix              grid
" >grid.in
grid -i grid.in

##step 4. docking
#generating in file
echo "
conformer_search_type                                        flex
user_specified_anchor                                        no
limit_max_anchors                                            no
min_anchor_size                                              40
pruning_use_clustering                                       yes
pruning_max_orients                                          100
pruning_clustering_cutoff                                    100
pruning_conformer_score_cutoff                               25.0
pruning_conformer_score_scaling_factor                       1.0
use_clash_overlap                                            no
write_growth_tree                                            no
use_internal_energy                                          yes
internal_energy_rep_exp                                      12
internal_energy_cutoff                                       100.0
ligand_atom_file                                             ./${lig_name}_charged.mol2
limit_max_ligands                                            no
skip_molecule                                                no
read_mol_solvation                                           no
calculate_rmsd                                               no
use_database_filter                                          no
orient_ligand                                                yes
automated_matching                                           yes
receptor_site_file                                           ./selected_spheres.sph
max_orientations                                             1000
critical_points                                              no
chemical_matching                                            no
use_ligand_spheres                                           no
bump_filter                                                  no
score_molecules                                              yes
contact_score_primary                                        no
contact_score_secondary                                      no
grid_score_primary                                           yes
grid_score_secondary                                         no
grid_score_rep_rad_scale                                     1
grid_score_vdw_scale                                         1
grid_score_es_scale                                          1
grid_score_grid_prefix                                       ./grid
multigrid_score_secondary                                    no
dock3.5_score_secondary                                      no
continuous_score_secondary                                   no
footprint_similarity_score_secondary                         no
pharmacophore_score_secondary                                no
descriptor_score_secondary                                   no
gbsa_zou_score_secondary                                     no
gbsa_hawkins_score_secondary                                 no
SASA_score_secondary                                         no
amber_score_secondary                                        no
minimize_ligand                                              yes
minimize_anchor                                              yes
minimize_flexible_growth                                     yes
use_advanced_simplex_parameters                              no
simplex_max_cycles                                           1
simplex_score_converge                                       0.1
simplex_cycle_converge                                       1.0
simplex_trans_step                                           1.0
simplex_rot_step                                             0.1
simplex_tors_step                                            10.0
simplex_anchor_max_iterations                                500
simplex_grow_max_iterations                                  500
simplex_grow_tors_premin_iterations                          0
simplex_random_seed                                          0
simplex_restraint_min                                        no
atom_model                                                   all
vdw_defn_file                                                ${dock6_home}/parameters/vdw_AMBER_parm99.defn
flex_defn_file                                               ${dock6_home}/parameters/flex.defn
flex_drive_file                                              ${dock6_home}/parameters/flex_drive.tbl
ligand_outfile_prefix                                        ${name}_flex
write_orientations                                           no
num_scored_conformers                                        10
write_conformations                                          yes
cluster_conformations                                        yes
cluster_rmsd_threshold                                       2
rank_ligands                                                 yes
max_ranked_ligands                                           50
" >dock.in

#start docking
dock6 -i dock.in
