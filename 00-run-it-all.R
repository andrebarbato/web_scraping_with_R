# clean up workspace
rm(list=ls())

# close all figure windows created with x11()
graphics.off()

# load packages
library(pkg1)
library(pkg2)
library(pkg3)

# change directory
my_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(my.d)

# list  functions in 'R-Fcts'
my_R_files <- list.files(path='R-Fcts',
                         pattern = '*.R',
                         full.names=TRUE)

# Load all functions in R
sapply(my_R_files,source)

# Import data script
source('01-import-and-clean-data.R')

# run models and report results
source('02-run-research.R')