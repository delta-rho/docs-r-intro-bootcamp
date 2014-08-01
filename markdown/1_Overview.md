# Intro to R "Big Data" Bootcamp #
## Overview ##

### Description ###

This is an introduction to the R language and the Tessera (http://tesseradata.org) 
tools. This content was originally prepared as a day-long training course that took 
place in July 2014.  

Activity 1 (1.2-1.5) provides a tour of the language, syntax, and capabilities of the R
language. Activity 2 (2.1-2.3) highlights the Tessera tools for big data analytics.

Activities 1.2-2.1 may be run on your local machine with the following setup:
- Install R: http://www.r-project.org
- Install RStudio (desktop version): http://www.rstudio.com
- Install R libraries. Open RStudio (or R) and execute the following commands:


```r
install.packages(c("devtools", "stl"), repos="http://cran.rstudio.com/")
library(devtools)
install_github("datadr", "tesseradata")
install_github("trelliscope", "tesseradata")
```


Activities 2.2 and 2.3 are examples of how to use Tessera tools on big data, and 
require Hadoop to run. Details for how to set up a single node cluster 
using Vagrant are provided here: https://github.com/tesseradata/install-vagrant. Details for
using Amazon Web Services to create and configure a cluster with the necessary tools can be
found here: https://github.com/tesseradata/install-emr.

Note that [R code](#r-code) and [data](#data) for each of the activities and 
the [slides](#slides) used during the training are available in the Appendix.
