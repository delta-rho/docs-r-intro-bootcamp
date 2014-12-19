## Appendix ##

### R Code ###

If you would like to run through all of the code examples in this documentation without having to pick out each line of code from the text, below are files with the R code for each section.

- [Activity 1.2](scripts/Activity_1.2.R)
- [Activity 1.3](scripts/Activity_1.3.R)
- [Activity 1.3 Solutions](scripts/Activity_1.3_solutions.R)
- [Activity 1.4](scripts/Activity_1.4.R)
- [Activity 1.4 Solutions](scripts/Activity_1.4_solutions.R)
- [Activity 1.5](scripts/Activity_1.5.R)
- [Activity 1.5 Solutions](scripts/Activity_1.5_solutions.R)
- [Activity 2.1](scripts/Activity_2.1.R)
- [Activity 2.2](scripts/Activity_2.2.R)
- [Activity 2.3](scripts/Activity_2.3.R)

### Data ###

The following data files are used in Activity 1.  

- [dailycount.Rdata](analysis/dailycount.Rdata)
- [some_fake_data.csv](analysis/some_fake_data.csv)
- [nf-week2-sample.csv](analysis/nf-week2-sample.csv)

If you want to run the code for Activity 1, please download and save these files in a
directory on your machine. Then before executing the code in Activity 1, 
execute the following command in R, substituting the correct directory on your machine.
(Remember that R uses forward slashes '/' for all paths even on Windows.)

```r
setwd("c:/put/your/data/directory/here")
```


Activity 2 (2.2 and 2.3) uses data from the VAST Challenge 2013, which may be found here:
(http://hcil2.cs.umd.edu/newvarepository/VAST%20Challenge%202013/challenges/MC3%20-%20Big%20Marketing/). 

Download the data, which is in a zipped file. Unzip the data archive, and find the
file `Dataset/Week 2/Week2Data/nf-week2.csv`. You will need to copy this file into
HDFS using the following commands (where you should substitute your username for [user]).
```
hadoop fs -mkdir /user/[user]/bootcamp/raw/nf
hadoop fs -put [unzipped_path]/Dataset/Week\ 2/Week2Data/nf-week2.csv /user/[user]/bootcamp/raw/nf/nf-week2.csv
```
### Slides and Handouts ###

Download the slides and handouts presented at the bootcamp.

- [Morning Session](slides/Tessera_Bootcamp_Morning_Session_Web.pdf)
- [Afternoon Session](slides/Tessera_Bootcamp_Afternoon_Session_Web.pdf)
- [R Quick Start Guide](slides/Quick_Start_Guide_R.pdf)
- [RStudio Quick Start Guide](slides/Quick_Start_Guide_RStudio.pdf)
- [Trelliscope Quick Start Guide](slides/Quick_Start_Guide_Trelliscope.pdf)
