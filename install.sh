#!/bin/bash


#Loading necessary modules for installation
module load jags/4.3.0
module load R/4.1.0-intel

#Loading jags automatically load gcc/4.7.4 replace it with a later version
module unload gcc/4.7.4

#Create R library for all packages 
mkdir -p ../R/Library


#Get current path
start_path=$(pwd)
cd ..
home_path=$(pwd)
a="/lf_adap.c"

#To calculate adap file path
adap_path=${start_path}${a}


#Set LD_path so that libpng16.so can be loaded
export LD_LIBRARY_PATH=/share/apps/anaconda/3/5.1.0/lib:$LD_LIBRARY_PATH

#Specify the R library where all R packages will be installed otherwise it$
#See https://wiki.hpc.tulane.edu/trac/wiki/cypress/InstallingRPackages for$
b="/R/Library"
cd ${home_path}${b}
export R_LIBS=$(pwd)


#Changing directory to your personal directory on luster to begin installation of locfit one of the dependencies of infercnv
cd ${home_path}
wget http://cran.r-project.org/src/contrib/locfit_1.5-9.4.tar.gz
tar -xf locfit_1.5-9.4.tar.gz

#Logical operators in original lf_adap.c file are wrong
#I have fixed all occrence in the file and replace it with the correct one here
c="/locfit/src"
cd ${home_path}${c}
rm lf_adap.c
cp ${adap_path} .
cd ${home_path}

#Using command line to install R package locfit
R CMD INSTALL locfit

#Use a pre-written Rscript to continue
echo "Start of Rscript"
cd ${start_path}  #Changing directory to where Rscript is
Rscript install_infercnv.R
echo "End of Rscript"
