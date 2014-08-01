## Activity 2: Demonstration of Tessera Tools with Data ##

### Activity 2.1: DataDR and Trelliscope example with Census Data ###

#### Introduction to the Census Data and Distributed Data Frames

This example uses a dataset from the 1994 U.S. census, available at 
http://archive.ics.uci.edu/ml/datasets/Adult. This is a relatively small
dataset, which can be loaded into memory; we use it to demonstrate DataDR
and Trelliscope because its size makes it easy to see the relationship
between the analysis steps and the visualizations. This dataset (`adult`) is
distributed with the `datadr` library, once the library is loaded, the
data frame is available.

We start by loading the datadr and trelliscope libraries, and looking at
the `adult` data frame. The data has a mix of categorical and numeric variables, including
age, race, gender, education level, income bin (<=$50K, >$50K), 
hours per week worked, and job class (e.g. private, government, 
self-employed, etc) among others.





```r
library(datadr)
library(trelliscope)

# look at the dataset
str(adult)
```

```
'data.frame':	32561 obs. of  16 variables:
 $ age          : int  39 50 38 53 28 37 49 52 31 42 ...
 $ workclass    : Factor w/ 9 levels "?","Federal-gov",..: 8 7 5 5 5 5 5 7 5 5 ...
 $ fnlwgt       : int  77516 83311 215646 234721 338409 284582 160187 209642 45781 159449 ...
 $ education    : Factor w/ 16 levels "10th","11th",..: 10 10 12 2 10 13 7 12 13 10 ...
 $ educationnum : int  13 13 9 7 13 14 5 9 14 13 ...
 $ marital      : Factor w/ 7 levels "Divorced","Married-AF-spouse",..: 5 3 1 3 3 3 4 3 5 3 ...
 $ occupation   : Factor w/ 15 levels "?","Adm-clerical",..: 2 5 7 7 11 5 9 5 11 5 ...
 $ relationship : Factor w/ 6 levels "Husband","Not-in-family",..: 2 1 2 1 6 6 2 1 2 1 ...
 $ race         : Factor w/ 5 levels "Amer-Indian-Eskimo",..: 5 5 5 3 3 5 3 5 5 5 ...
 $ sex          : Factor w/ 2 levels "Female","Male": 2 2 2 2 1 1 1 2 1 2 ...
 $ capgain      : int  2174 0 0 0 0 0 0 0 14084 5178 ...
 $ caploss      : int  0 0 0 0 0 0 0 0 0 0 ...
 $ hoursperweek : int  40 13 40 40 40 40 16 45 50 40 ...
 $ nativecountry: Factor w/ 42 levels "?","Cambodia",..: 40 40 40 40 6 40 24 40 40 40 ...
 $ income       : Factor w/ 2 levels "<=50K",">50K": 1 1 1 1 1 1 1 2 2 2 ...
 $ incomebin    : num  0 0 0 0 0 0 0 1 1 1 ...
```


The first step is to transform `adult` into a distributed data frame (DDF).
A DDF is one of the main data containing classes in `datadr`. A DDF can 
represent data in memory, on local disk, or on a Hadoop Distributed File
System (HDFS), so it can be used for data from the very small to the very large.
One advantage of using `datadr` is that the same analysis algorithms can 
be used on all types of DDFs without rewriting code. 


```r
# express data as a local "distributed data frame"
adultDdf <- ddf(adult, update=TRUE)

adultDdf
```

```

Distributed data object of class 'kvMemory' with attributes: 

'ddo' attribute | value
----------------+-----------------------------------------------------------
 keys           | keys are available through getKeys(dat)
 totStorageSize | 2.12 MB
 totObjectSize  | 2.12 MB
 nDiv           | 1
 splitSizeDistn | use splitSizeDistn(dat) to get distribution
 example        | use kvExample(dat) to get an example subset
 bsvInfo        | [empty] no BSVs have been specified

'ddf' attribute | value
----------------+-----------------------------------------------------------
 vars           | age(int), workclass(fac), fnlwgt(int), and 13 more
 transFn        | identity (original data is a data frame)
 nRow           | 32561
 splitRowDistn  | use splitRowDistn(dat) to get distribution
 summary        | use summary(dat) to see summaries

In-memory data connection
```


As we see, this dataset has size 2.12 MB and has  observations.
A good place to start in an exploratory analysis is to look at summary statistics. The `summary()` method provides a nice overview of the variables in our distributed data frame.  For categorical variables, it provides a frequency table, and for numeric variables, it provides summary statistics such as moments (mean, standard deviation, etc.), range, etc.


```r
# look at data summary statistics
summary(adultDdf)
```

```
        age                workclass                fnlwgt       
 -----------------  ------------------------  ------------------ 
  missing :      0          levels : 9         missing :       0 
      min :     17         missing : 0             min :   12285 
      max :     90     > freqTable head <          max : 1484705 
     mean :  38.58           Private : 22696      mean :  189778 
  std dev :  13.64  Self-emp-not-inc :  2541   std dev :  105550 
 skewness : 0.5587         Local-gov :  2093  skewness :   1.447 
 kurtosis :  2.834                 ? :  1836  kurtosis :   9.218 
 -----------------  ------------------------  ------------------ 
      education           educationnum              marital           
 --------------------  ------------------  -------------------------- 
         levels : 16    missing :       0          levels : 7         
        missing : 0         min :       1         missing : 0         
  > freqTable head <        max :      16      > freqTable head <     
      HS-grad : 10501      mean :   10.08  Married-civ-spouse : 14976 
 Some-college :  7291   std dev :   2.573       Never-married : 10683 
    Bachelors :  5355  skewness : -0.3117            Divorced :  4443 
      Masters :  1723  kurtosis :   3.623           Separated :  1025 
 --------------------  ------------------  -------------------------- 
       occupation            relationship      
 ----------------------  --------------------- 
         levels : 15             levels : 6    
        missing : 0             missing : 0    
   > freqTable head <     > freqTable head <   
  Prof-specialty : 4140        Husband : 13193 
    Craft-repair : 4099  Not-in-family :  8305 
 Exec-managerial : 4066      Own-child :  5068 
    Adm-clerical : 3770      Unmarried :  3446 
 ----------------------  --------------------- 
            race                    sex              capgain      
 --------------------------  ------------------  ---------------- 
         levels : 5                  levels : 2   missing :     0 
        missing : 0                 missing : 0       min :     0 
     > freqTable head <      > freqTable head <       max : 99999 
              White : 27816    Male : 21790          mean :  1078 
              Black :  3124  Female : 10771       std dev :  7385 
 Asian-Pac-Islander :  1039                      skewness : 11.95 
 Amer-Indian-Eskimo :   311                      kurtosis : 157.8 
 --------------------------  ------------------  ---------------- 
     caploss         hoursperweek         nativecountry     
 ----------------  -----------------  --------------------- 
  missing :     0   missing :      0          levels : 42   
      min :     0       min :      1         missing : 0    
      max :  4356       max :     99   > freqTable head <   
     mean :  87.3      mean :  40.44  United-States : 29170 
  std dev :   403   std dev :  12.35         Mexico :   643 
 skewness : 4.594  skewness : 0.2276              ? :   583 
 kurtosis : 23.37  kurtosis :  5.916    Philippines :   198 
 ----------------  -----------------  --------------------- 
       income            incomebin     
 ------------------  ----------------- 
         levels : 2   missing :      0 
        missing : 0       min :      0 
 > freqTable head <       max :      1 
 <=50K : 24720           mean : 0.2408 
  >50K :  7841        std dev : 0.4276 
                     skewness :  1.212 
                     kurtosis :   2.47 
 ------------------  ----------------- 
```


#### Dividing and Recombining

A typical analysis path is to divide data based on some variable in the dataset 
and apply some analysis to each subset of the data. We will divide based on
the `education` field. Use the `getKeys` method to see the keys associated
with a data. Then use one key to see the data rows associated with that value
of `education`.


```r
# divide the ddf by the variable "education"
byEducation <- divide(adultDdf, by = "education", update=TRUE)

# look at division keys
getKeys(byEducation)
```

```
[[1]]
[1] "education=10th"

[[2]]
[1] "education=11th"

[[3]]
[1] "education=12th"

[[4]]
[1] "education=1st-4th"

[[5]]
[1] "education=5th-6th"

[[6]]
[1] "education=7th-8th"

[[7]]
[1] "education=9th"

[[8]]
[1] "education=Assoc-acdm"

[[9]]
[1] "education=Assoc-voc"

[[10]]
[1] "education=Bachelors"

[[11]]
[1] "education=Doctorate"

[[12]]
[1] "education=HS-grad"

[[13]]
[1] "education=Masters"

[[14]]
[1] "education=Preschool"

[[15]]
[1] "education=Prof-school"

[[16]]
[1] "education=Some-college"
```

```r

# look at subsets of the ddf
head(byEducation[["education=Bachelors"]][[2]])
```

```
  age        workclass fnlwgt educationnum            marital
1  39        State-gov  77516           13      Never-married
2  50 Self-emp-not-inc  83311           13 Married-civ-spouse
3  28          Private 338409           13 Married-civ-spouse
4  42          Private 159449           13 Married-civ-spouse
5  30        State-gov 141297           13 Married-civ-spouse
6  23          Private 122272           13      Never-married
       occupation  relationship               race    sex capgain caploss
1    Adm-clerical Not-in-family              White   Male    2174       0
2 Exec-managerial       Husband              White   Male       0       0
3  Prof-specialty          Wife              Black Female       0       0
4 Exec-managerial       Husband              White   Male    5178       0
5  Prof-specialty       Husband Asian-Pac-Islander   Male       0       0
6    Adm-clerical     Own-child              White Female       0       0
  hoursperweek nativecountry income incomebin
1           40 United-States  <=50K         0
2           13 United-States  <=50K         0
3           40          Cuba  <=50K         0
4           40 United-States   >50K         1
5           40         India   >50K         1
6           30 United-States  <=50K         0
```


What if we wanted to compute summary statistics on each division of the data? For 
example, we could calculate the mean and standard deviation of the number of 
hours per week worked for each education level. The `recombine` method will apply
a function to each data division, then combine the function outputs into a single
data frame.


```r
# compute mean and standard dev of hoursperweek for each subset and recombine into one table
edMeanAndVar <- recombine(byEducation,
   apply = function(x) {
      list(
         mean=mean(x$age, na.rm=TRUE), 
         stdev=sqrt(var(x$age, na.rm=TRUE))
      )
   },
   combine = combRbind()
)

# look at results 
edMeanAndVar
```

```
      education val.mean val.stdev
1          10th    37.43     16.72
2          11th    32.36     15.55
3          12th    32.00     14.33
4       1st-4th    46.14     15.62
5       5th-6th    42.89     15.56
6       7th-8th    48.45     16.09
7           9th    41.06     15.95
8    Assoc-acdm    37.38     11.10
9     Assoc-voc    38.55     11.63
10    Bachelors    38.90     11.91
11    Doctorate    47.70     11.78
12      HS-grad    38.97     13.54
13      Masters    44.05     11.07
14    Preschool    42.76     15.13
15  Prof-school    44.75     11.96
16 Some-college    35.76     13.47
```


#### Trelliscope Displays

For this activity, we will make a couple of simple Trelliscope displays. The
Trelliscope documentation at <http://tesseradata.org/trelliscope/> 
has many more details than what is discussed here.

Trelliscope provides a visual recombination approach to D&R.  In Trelliscope, 
we specify a function to be applied to each subset that produces a plot. Each 
plot is called a "panel".  The collection of panels for given dataset is 
called a "display".  A collection of displays is called a "visualization 
database" (VDB).

Trelliscope provides an interactive viewer that allows the user to specify how 
to sort, filter, and arrange the panels in a display to view them in a 
meaningful way.

We start by creating a different division on the data, using the `workclass` variable.


```r
# divide by work class
byWorkClass <- divide(adultDdf, by="workclass")

getKeys(byWorkClass)
```

```
[[1]]
[1] "workclass=?"

[[2]]
[1] "workclass=Federal-gov"

[[3]]
[1] "workclass=Local-gov"

[[4]]
[1] "workclass=Never-worked"

[[5]]
[1] "workclass=Private"

[[6]]
[1] "workclass=Self-emp-inc"

[[7]]
[1] "workclass=Self-emp-not-inc"

[[8]]
[1] "workclass=State-gov"

[[9]]
[1] "workclass=Without-pay"
```


We will create Trelliscope display to explore the data divided by `workclass`. 
First, we create a function that makes a plot out of one data division. It's good
to test this function on one division. 


```r
# panel function: education vs hours per week, conditioned on income category
pf1 <- function(x)
   xyplot(hoursperweek ~ educationnum | income, 
      data = x,
      xlab="Years of Education",
      ylab="Hours per Week"
   )
# test it on one data division
pf1(byWorkClass[["workclass=Federal-gov"]][[2]])
```

![plot of chunk Activity2.1.8](figures/knitr/Activity2_1_8.png) 


We will have a set of these plots, one corresponding to each value of `workclass`.
To help interact with all the possible panels we can specify metrics to computed 
for each subset, which are called ‘cognostics’. Cognostics specify sorting and 
filtering of the plots based on the metrics chosen. For this data, our 
cognostics include summary statistics of the education level and hours per week
(mean, max, min).



```r
# cognostics function
cf <- function(x) {
   list(
      fracAbove50K = cog(mean(x$incomebin), desc = "fraction above $50K income"),
      minEducation = cog(min(x$educationnum), desc = "min number of education years"),
      meanEducation = cog(mean(x$educationnum), desc = "mean number of education years"),
      maxEducation = cog(max(x$educationnum), desc = "max number of education years"),
      minnHoursPerWeek = cog(min(x$hoursperweek), desc="min hours per week worked"),
      meanHoursPerWeek = cog(mean(x$hoursperweek), desc="mean hours per week worked"),
      maxHoursPerWeek = cog(max(x$hoursperweek), desc="max hours per week worked")
   )
}
```


As with the panel function, it's a good idea to test the cognostics function
on one data division.


```r
cf(byWorkClass[[1]][[2]])
```

```
$fracAbove50K
[1] 0.104

$minEducation
[1] 1

$meanEducation
[1] 9.26

$maxEducation
[1] 16

$minnHoursPerWeek
[1] 1

$meanHoursPerWeek
[1] 31.92

$maxHoursPerWeek
[1] 99
```


Now that we're satisfied with our panel and cognostics functions, we put 
them together to create a Trelliscope display. The `vdbConn` command creates 
a visualization database (VDB) directory where plots and metadata will be 
stored when they are created by the `makeDisplay` function.


```r
# create visualization database
vdbConn("vdb_census", autoYes = TRUE)
```

```
vdb connection object: name=.; path=/people/d3l348/bootcamp/docs/analysis/vdb_census
```

```r
   
# create display with this panel and cognostics functions
makeDisplay(byWorkClass,
   name = "hours_and_education_by_workclass",
   desc = "hours and education by workclass",
   panelFn = pf1, cogFn = cf,
   width = 400, height = 400
)
```


The `view` command launches the Trelliscope viewer in a browser. 


```r
# view the display
view()
```


When the Trelliscope viewer appears, it displays a list of displays to 
choose from--at the moment it shows only one option which is the display 
we just created. 

![Trelliscope Fig 1](figures/trelliscope_1_1.png)

When you select the display, the first, randomly selected plot is shown. Notice
the left and right arrows at the top that allow you to page through the
plots. There is one plot panel for each data division--in this case,
for each work class.

![Trelliscope Fig 2](figures/trelliscope_1_2.png)

We will use the Visible Cognostics screen to choose what information is displayed
below each plot. The variable used to define the division is chosen by
default (`workclass`); let's also select `fracAbove50K`.

![Trelliscope Fig 3](figures/trelliscope_1_3.png)

Next use the Panel Layout screen to display multiple panels at a time.

![Trelliscope Fig 4](figures/trelliscope_1_4.png)

Now all 9 panels (for the 9 work classes) are displayed at once.

![Trelliscope Fig 5](figures/trelliscope_1_5.png)

In the Table Sort/Filter Screen, we can sort and filter the plots based
on the cognostics defined above. Click the small up arrow next to the
`fracAbove50K` column header; this sorts the rows into decreasing
order according to that statistic. 

![Trelliscope Fig 6](figures/trelliscope_1_6.png)

Hit Apply to return to the plots
and you will see that they have been re-ordered.

![Trelliscope Fig 7](figures/trelliscope_1_7.png)

We will look at additional capabilities of the Trelliscope viewer in 
the next example. Close the Trelliscope viewer and return to the R 
command line. Type `Esc` or `Ctrl-C` to stop the Trelliscope viewer. 

Next we will create a second type of panel function for a different 
type of plot. 


```r
pf2 <- function(x)
   boxplot(educationnum ~ income, data = x,
      xlab="Income", ylab="Education")
pf2(byWorkClass[[1]][[2]])
```

![plot of chunk Activity2.1.12a](figures/knitr/Activity2_1_12a.png) 


We pass this new panel function to the `makeDisplay` function
as before, and use the same cognostics function as previously.


```r
# a second type of plot on the same data
makeDisplay(byWorkClass,
   name = "education_boxplot_by_workclass",
   desc = "education boxplot by workclass",
   panelFn = pf2, cogFn = cf,
   width = 400, height = 400
)
```


When the Trelliscope viewer is launched you will see that both the first set
of plots and the most recent set are available to view. This is because
the Trelliscope displays are persistent: they are stored in the vdbConn
specified above.  You can keep adding more types of plots and as long as they
are given unique names in the `makeDisplay` command they will all be
available to view.

You could also come back in future sessions of R and specify the same directory
in a `vdbConn` command and see the Trelliscope displays created today, as long
as you do not delete that directory.


```r
# launch viewer
view(port=myport)
```

![Trelliscope Fig 8](figures/trelliscope_1_8.png)

Select the new display (labeled education_boxplot_by_workclass) and you will
see a single boxplot panel.

![Trelliscope Fig 9](figures/trelliscope_1_9.png)

In the visible cognostics screen, we will select `fracAbove50K` and 
`meanHoursPerWeek`. Click the Apply button.

![Trelliscope Fig 10](figures/trelliscope_1_10.png)

In the Univariate Filter screen, we can view quantile plots of the
cognostic statistics, and select outliers to filter. If we select
`fracAbove50K` on the left, and draw a box to select the two points 
on the upper right of the plot, this will filter the panels so that
only the panels corresponding to those two values of `fracAbove50K` 
are displayed. Click the Apply button.

![Trelliscope Fig 11](figures/trelliscope_1_11.png)

After using the Panel Layout screen to display two panels at a
time, we can see the two sets of boxplots corresponding to the two
work classes with the highest fraction of incomes above $50,000.

![Trelliscope Fig 12](figures/trelliscope_1_12.png)

As previously noted, after finishing looking at the Trelliscope viewer,
type `Esc` or `Ctrl-C` at the R command line.
