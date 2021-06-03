#!/usr/bin/env Rscript

#Install BiocManager first then we can install infercnv
#I need to specify repos otherwise I got an error message of 'didn't specify mirror'
install.packages('BiocManager',repos="http://cran.us.r-project.org")



#The most important part of all installation
#The processs will take about 30 minutes to run
BiocManager::install('infercnv')


#Don't know what I need to do about this though
install.packages("Matrix", "mgcv")
