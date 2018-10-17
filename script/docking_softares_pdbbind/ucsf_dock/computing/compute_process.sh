#!/bin/sh
cat ../refined-set/protein_ligand.list| sed -e "/^$/d"| wc
