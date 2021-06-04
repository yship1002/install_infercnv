#!/bin/bash
#Place this script as well as lf_adap.c file and install_infercnv.R in your luster directory


#Loading necessary modules for installation
module load jags/4.3.0
module load R/4.1.0-intel

#Loading jags automatically load gcc/4.7.4 replace it with a later version
module unload gcc/4.7.4

#Set LD_path so that libpng16.so can be loaded
export LD_LIBRARY_PATH=/share/apps/anaconda/3/5.1.0/lib:$LD_LIBRARY_PATH

#Specify the R library where all R packages will be installed otherwise it$
#See https://wiki.hpc.tulane.edu/trac/wiki/cypress/InstallingRPackages for$
export R_LIBS=/lustre/project/wdeng7/R/Library

#Get current path
cur_path=$(pwd)
a="/lf_adap.c"

#To calculate adap file path
adap_path=${cur_path}${a}

#Changing directory to home to begin installation of locfit one of the dependencies of infercnv
cd ~
wget http://cran.r-project.org/src/contrib/locfit_1.5-9.4.tar.gz
tar -xf locfit_1.5-9.4.tar.gz

#Logical operators in original lf_adap.c file are wrong
#I have fixed all occrence in the file and replace it with the correct one here
cd locfit/src
rm lf_adap.c
cp ${adap_path} .
cd ~

#Using command line to install R package locfit
R CMD INSTALL locfit

#Use a pre-written Rscript to continue
echo "Start of Rscript"
cd ${cur_path}  #Changing directory to where Rscript is
Rscript install_infercnv.R
echo "End of Rscript"
