#!/bin/bash
#Place this script as well as lf_adap.c file and install_infercnv.R in your home directory
idev
module load jags/4.3.0
module load R/4.1.0-intel
#Loading jags automatically load gcc/4.7.4 replace it with a later version
module unload gcc/4.7.4
export LD_LIBRARY_PATH=/share/apps/anaconda/3/5.1.0/lib:$LD_LIBRARY_PATH
cd ~
wget http://cran.r-project.org/src/contrib/locfit_1.5-9.4.tar.gz
tar -xf locfit_1.5-9.4.tar.gz
#Logical operators in original lf_adap.c file are wrong
#I have fixed all occrence in the file and replace it with the correct one
cd locfit/src
rm lf_adap.c
mv ~/lf_adap.c .
cd ~
R CMD INSTALL locfit
#Use a pre-written Rscript to continue
Rscript install_infercnv.R
