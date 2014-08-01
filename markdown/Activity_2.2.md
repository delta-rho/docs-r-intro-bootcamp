



### Activity 2.2: Using Tessera with Hadoop to Analyze Large Data ###




#### Session Initialization


```r
# load required packages and initialize Rhipe
library(datadr)
library(Rhipe)
library(cyberTools)
rhinit()

# set time zone to "UTC" for use with dates in the data
Sys.setenv(TZ = "UTC")

# set working directories on local machine 
setwd("~")

# set working directory in HDFS
hdfs.setwd(""Sys.getenv("HDFS_USER_VAST")"")
```



```r
# make sure raw text data has been copied to HDFS
rhls("raw/nf")
```

```
  permission  owner      group     size          modtime
1 drwxrwxrwx d3l348 supergroup        0 2014-07-01 21:07
2 -rw-r--r-- d3l348 supergroup 2.766 gb 2014-06-13 03:29
                                       file
1     /user/d3l348/bootcamp/raw/nf/_rh_meta
2 /user/d3l348/bootcamp/raw/nf/nf-week2.csv
```


#### Read NetFlow csv Data to R Objects ###

One of the more tedious parts of data analaysis can be getting the data 
into the proper format for analysis.  `datadr` stives to provide as much 
functionality to make this process as painless as possible, but there 
will always be special situations that require unique solutions.

For analysis in `datadr`, we want to take the raw data and store it as 
native R objects.  This provides a great degree of flexibility in what 
type of data structures we can use, such as non-tabular data or special 
classes of R objects like time series or spatial objects.

Here, all of our input data is text.  Text files are used quite often 
for storing and sharing big data.  For example, often 
[Hive](https://hive.apache.org) tables are stored as text files. `datadr` 
provides some helpful functions that make it easy to deal 
with reading in text data and storing it as R objects..  

In this activity we will go through how to read the NetFlow data from 
text.  These examples read the data using a simple function 
`drRead.csv()` which has a similar interface to R's `read.csv()` function.

We saw from before that the NetFlow data is located on HDFS at 
`raw/nf/nf-week2.csv`.  If we were to look at a sample of the NetFlow 
data we would see that it has a few date/time related columns. R will 
read those in as character and/or numeric, and we will want to 
convert them to R date/time objects.
![NetFlow Data](figures/NetFlow_data.png)

We will make a date transformation function, which we will pass to the 
`drRead.csv()` function so that it will be applied to each row of data 
as it is read. 


```r
# make a date parsing function to use during data ingest
nfTransform <- function(x) {
   x$date <- as.POSIXct(as.numeric(as.character(x$TimeSeconds)), 
      origin = "1970-01-01", tz = "UTC")
   x[,setdiff(names(x), c("TimeSeconds", "parsedDate"))]
}
```


#### HDFS connections

We are reading text data from HDFS and will be storing the data we read 
to HDFS.  When working with HDFS in `datadr`, we create *HDFS connections*.  An 
HDFS connection is simply defined by the path where we would like the 
data to be stored on HDFS and the file type (such as "text").  

For the input connection, we want to point to `raw/nf`, and make sure it 
is known that it is "text" data:


```r
# initiate a connection to existing csv text file on HDFS
csvConn <- hdfsConn("raw/nf", type = "text")
```

```
* 'loc' is not an absolute path - prepending HDFS working directory
* Loading connection attributes
```


The output connection should be an empty directory, and can be a 
nonexistent directory.  Here, we would like to store our parsed NetFlow 
data in `nfRaw`.  We initialize this connection with a call to `hdfsConn()`:


```r
# initiate a new connection where parsed NetFlow data will be stored
nfConn <- hdfsConn("nfRaw", autoYes=TRUE) 
```


The `autoYes` parameter tells the function to respond 'Yes' to any question 
about creating the directory if it does not exist.  `nfConn` is now simply 
an R object that points to a directory on HDFS.

We can now use these objects in our csv reader.

#### Reading in the data

There is a handy function in `datadr` that is the analog to `read.csv`, 
called `drRead.csv`, which reads the data in in blocks.  It has the same 
calling interface as R's `read.csv` with additional arguments to specify 
where to store the output, how many rows to put in each block, and an 
optional transformation function to apply to each block prior to storing 
it.

We will read in the NetFlow csv file using the default number of rows per 
block (`50000`), apply our `nfTransform` function that adds the `time` 
variable, and save the output to our `nfConn` local disk connection:
  

```r
# read in NetFlow data
nfRaw <- drRead.csv(csvConn, output = nfConn, postTransFn = nfTransform)
```


At this point you will see a series of status updates from Hadoop, while
the `drRead.csv` command is running. In particular, pay attention to the 
numbers of map and reduce jobs moving from the 'pending' to the 'running' 
to the 'complete' columns. When this is complete, let's take a look at 
`nfRaw` to see what the object looks like:





```r
# look at the nfRaw object
nfRaw
```

```

Distributed data object of class 'kvHDFS' with attributes: 

'ddo' attribute | value
----------------+--------------------------------------------------------------------------
 keys           | [empty] call updateAttributes(dat) to get this value
 totStorageSize | 1.56 GB
 totObjectSize  | [empty] call updateAttributes(dat) to get this value
 nDiv           | 481
 splitSizeDistn | [empty] call updateAttributes(dat) to get this value
 example        | use kvExample(dat) to get an example subset
 bsvInfo        | [empty] no BSVs have been specified

'ddf' attribute | value
----------------+--------------------------------------------------------------------------
 vars           | dateTimeStr(num), ipLayerProtocol(int), and 16 more
 transFn        | identity (original data is a data frame)
 nRow           | [empty] call updateAttributes(dat) to get this value
 splitRowDistn  | [empty] call updateAttributes(dat) to get this value
 summary        | [empty] call updateAttributes(dat) to get this value

hdfsConn connection
  loc=/user/d3l348/bootcamp/nfRaw; type=sequence
```


`nfRaw` is a *distributed data frame* (ddf), and we see several aspects 
about the data printed.  For example, we see that there are 481 subsets 
and that the size of the data on HDFS is `totStorageSize` = 
1.56 Mb.  The 
other attributes will be updated in a moment.

The `nfRaw` object itself is simply a special R object that contains 
metadata and pointers to the actual data stored on disk.  For more 
background on ddf and related objects, see 
[here](http://hafen.github.io/datadr/index.html#distributed-data-objects) 
and [here](http://hafen.github.io/datadr/index.html#distributed-data-frames), 
and particularly for ddf objects on local disk, see 
[here](http://hafen.github.io/datadr/index.html#medium-disk--multicore).

Earlier we saw in the printout of `nfRaw` that it has many attibutes that 
have not yet been determined.  We can fix this by calling `updateAttributes()`:


```r
# get missing attributes
nfRaw <- updateAttributes(nfRaw)
```


In any subsequent R session, we can "reload" this data object, along with 
its metadata,
with the following command:


```r
# reload "nfRaw" by loading the connection as a ddf
nfRaw <- ddf(hdfsConn("nfRaw"))
```


Now we can see more meaningful information about our data:





```r
# look at the updated nfRaw object
nfRaw
```

```

Distributed data object of class 'kvHDFS' with attributes: 

'ddo' attribute | value
----------------+--------------------------------------------------------------------------
 keys           | keys are available through getKeys(dat)
 totStorageSize | 1.56 GB
 totObjectSize  | 2 GB
 nDiv           | 481
 splitSizeDistn | use splitSizeDistn(dat) to get distribution
 example        | use kvExample(dat) to get an example subset
 bsvInfo        | [empty] no BSVs have been specified

'ddf' attribute | value
----------------+--------------------------------------------------------------------------
 vars           | dateTimeStr(num), ipLayerProtocol(int), and 16 more
 transFn        | identity (original data is a data frame)
 nRow           | 23258685
 splitRowDistn  | use splitRowDistn(dat) to get distribution
 summary        | use summary(dat) to see summaries

hdfsConn connection
  loc=/user/d3l348/bootcamp/nfRaw; type=sequence
```


We now see that there are about 23 million rows of data, and we are supplied, 
among other things, with summary statistics for the variables in the ddf.

#### DDF attributes

Since `nfRaw` is a distributed data frame, we can look at various aspects of 
the data frame through familiar R methods.

We can get number of rows:


```r
# get total number of rows
nrow(nfRaw)
```

```
[1] 23258685
```

We can see variable names:


```r
# see what variables are available
names(nfRaw)
```

```
 [1] "dateTimeStr"               "ipLayerProtocol"           "ipLayerProtocolCode"      
 [4] "firstSeenSrcIp"            "firstSeenDestIp"           "firstSeenSrcPort"         
 [7] "firstSeenDestPort"         "moreFragments"             "contFragments"            
[10] "durationSeconds"           "firstSeenSrcPayloadBytes"  "firstSeenDestPayloadBytes"
[13] "firstSeenSrcTotalBytes"    "firstSeenDestTotalBytes"   "firstSeenSrcPacketCount"  
[16] "firstSeenDestPacketCount"  "recordForceOut"            "date"                     
```


We can grab the first subset and look at its structure:


```r
# look at the structure of the first key-value pair
str(nfRaw[[1]])
```

```
List of 2
 $ : chr "attempt_201402250850_1322_m_000020_0"
 $ :'data.frame':	50000 obs. of  18 variables:
  ..$ dateTimeStr              : num [1:50000] 2.01e+13 2.01e+13 2.01e+13 2.01e+13 2.01e+13 ...
  ..$ ipLayerProtocol          : int [1:50000] 6 6 6 6 6 6 6 6 6 6 ...
  ..$ ipLayerProtocolCode      : chr [1:50000] "TCP" "TCP" "TCP" "TCP" ...
  ..$ firstSeenSrcIp           : chr [1:50000] "172.10.0.4" "10.247.58.182" "10.247.58.182" "10.247.58.182" ...
  ..$ firstSeenDestIp          : chr [1:50000] "10.247.58.182" "172.10.0.4" "172.10.0.4" "172.10.0.4" ...
  ..$ firstSeenSrcPort         : int [1:50000] 80 29589 27922 28874 27921 29349 80 9763 23973 23972 ...
  ..$ firstSeenDestPort        : int [1:50000] 27919 80 80 80 80 80 27920 80 80 80 ...
  ..$ moreFragments            : int [1:50000] 0 0 0 0 0 0 0 0 0 0 ...
  ..$ contFragments            : int [1:50000] 0 0 0 0 0 0 0 0 0 0 ...
  ..$ durationSeconds          : int [1:50000] 11 2 11 7 11 3 11 0 0 0 ...
  ..$ firstSeenSrcPayloadBytes : int [1:50000] 503 19 19 19 19 19 503 19 19 19 ...
  ..$ firstSeenDestPayloadBytes: int [1:50000] 19 503 503 503 503 503 19 503 503 503 ...
  ..$ firstSeenSrcTotalBytes   : int [1:50000] 619 297 297 297 297 297 619 243 243 243 ...
  ..$ firstSeenDestTotalBytes  : int [1:50000] 235 619 619 619 619 619 235 619 619 619 ...
  ..$ firstSeenSrcPacketCount  : int [1:50000] 2 5 5 5 5 5 2 4 4 4 ...
  ..$ firstSeenDestPacketCount : int [1:50000] 4 2 2 2 2 2 4 2 2 2 ...
  ..$ recordForceOut           : int [1:50000] 0 0 0 0 0 0 0 0 0 0 ...
  ..$ date                     : POSIXct[1:50000], format: "2013-04-14 15:00:10" "2013-04-14 15:00:10" ...
```


We can view summaries of the variables in the distributed data frame:


```r
# look at summaries (computed from updateAttributes)
summary(nfRaw)
```

```
     dateTimeStr        ipLayerProtocol   ipLayerProtocolCode      firstSeenSrcIp      
 --------------------  -----------------  -------------------  ----------------------- 
  missing :         0   missing :      0          levels : 3           levels : 1390   
      min : 2.013e+13       min :      1         missing : 0          missing : 0      
      max : 2.013e+13       max :     17  > freqTable head <     > freqTable head <    
     mean : 2.013e+13      mean :   6.09    TCP : 23062987     10.138.214.18 : 1300759 
  std dev :    317466   std dev : 0.9961    UDP :   191395     10.170.32.181 : 1259035 
 skewness :     4.299  skewness :  10.79  OTHER :     4303     10.170.32.110 : 1257747 
 kurtosis :      35.2  kurtosis :  118.5                        10.10.11.102 : 1251990 
 --------------------  -----------------  -------------------  ----------------------- 
    firstSeenDestIp      firstSeenSrcPort   firstSeenDestPort     moreFragments    
 ---------------------  ------------------  -----------------  ------------------- 
         levels : 1277   missing :       0   missing :     0    missing :        0 
        missing : 0          min :       0       min :     0        min :        0 
  > freqTable head <         max :   65534       max : 65534        max :        1 
  172.30.0.4 : 8122427      mean :   30523      mean : 595.9       mean : 1.75e-05 
  172.10.0.4 : 4652570   std dev :   18235   std dev :  4261    std dev : 0.004183 
  172.20.0.4 : 4341038  skewness : 0.05421  skewness : 10.51   skewness :      239 
 172.20.0.15 : 4029911  kurtosis :   1.809  kurtosis : 121.3   kurtosis :    57145 
 ---------------------  ------------------  -----------------  ------------------- 
    contFragments      durationSeconds   firstSeenSrcPayloadBytes 
 --------------------  ----------------  ------------------------ 
  missing :         0   missing :     0      missing :       0    
      min :         0       min :     0          min :       0    
      max :         1       max :  1800          max : 3050256    
     mean : 1.741e-05      mean : 11.36         mean :   691.6    
  std dev :  0.004173   std dev : 37.15      std dev :   38955    
 skewness :     239.6  skewness : 10.48     skewness :   67.35    
 kurtosis :     57427  kurtosis :   221     kurtosis :    4739    
 --------------------  ----------------  ------------------------ 
 firstSeenDestPayloadBytes  firstSeenSrcTotalBytes  firstSeenDestTotalBytes 
 -------------------------  ----------------------  ----------------------- 
     missing :       0         missing :       0       missing :       0    
         min :       0             min :      43           min :       0    
         max : 3129878             max : 3326672           max : 3762470    
        mean :   22561            mean :    1497          mean :   23576    
     std dev :  245130         std dev :   41306       std dev :  254859    
    skewness :   11.84        skewness :    65.7      skewness :   11.84    
    kurtosis :     143        kurtosis :    4598      kurtosis :     143    
 -------------------------  ----------------------  ----------------------- 
 firstSeenSrcPacketCount  firstSeenDestPacketCount  recordForceOut 
 -----------------------  ------------------------  -------------- 
     missing :     0           missing :     0       missing :   0 
         min :     1               min :     0           min :   0 
         max : 13033               max : 13969           max :   0 
        mean : 14.51              mean : 18.64          mean :   0 
     std dev : 109.3           std dev : 182.4       std dev :   0 
    skewness : 14.66          skewness : 12.02      skewness : NaN 
    kurtosis : 334.4          kurtosis : 155.5      kurtosis : NaN 
 -----------------------  ------------------------  -------------- 
           date           
 ------------------------ 
 missing :              0 
     min : 13-04-10 06:50 
     max : 13-04-15 10:00 
                          
                          
                          
                          
 ------------------------ 
```


There are several insights we can get from the data by simply scanning 
the summary output printed above.  For example, the variable 
`ipLayerProtocolCode` tells us that the vast majority of the connections 
monitored are [TCP][TCP-wik] connections, while [UDP][UDP-wik] connections 
make up a little less than 1% of the traffic.  Also, all other protocols 
are rolled up into an "other" category.  There are 1390 `firstSeenSrcIp` 
values and 1277 `firstSeenDestIp` values. Also, the top destination IP 
had nearly twice as many sessions as the next most frequent. Recall that 
all variables are described [here](docs/data/NetFlow_NetworkHealth.pdf)).

#### Aggregate session counts per minute for each destination IP

The `drAggregate` function counts frequencies of any combination of variables 
specified. This function can be used to get an idea of meaningful or interesting 
data divisions for further analysis. `drAggregate` is similar to the familiar 
`xtabs` function available in base R.

We would like to look at the time series of session counts per minute for each 
destination IP. We can apply the `drAggregate` function to `nfRaw` to 
accomplish this. Such tabulation is an example of a "division-agnostic" method 
- a method we would like to run over the entire data set regardless of how 
it is divided.

As with `xtabs()`, at a minimum, we provide `drAggregate()` a formula 
specifying the tabulation and the input data (must be a ddf or coercible 
to one).  We also subset the data to the four big IP addresses prior to 
performing the tabulation and create a variable that will help us bin by 
minute through the use of the `preTransFn` argument.





```r
# count sessions per minute per destination IP
bigTimeAgg <- drAggregate(~ timeMinute + firstSeenDestIp, 
                 data = nfRaw, 
                 preTransFn = function(x) {
                     x$timeMinute <- as.POSIXct(trunc(x$date, 0, units = "mins"))
                     x
                 })
```


Now we sort the data in decreasing order of frequency and look at the first 
few rows:  
  

```r
# sort by number of sessions
bigTimeAgg <- bigTimeAgg[order(bigTimeAgg$Freq, decreasing=TRUE),]

# look at the first few rows
head(bigTimeAgg)       
```

```
               timeMinute firstSeenDestIp   Freq
19821 2013-04-11 12:55:00      172.30.0.4 200790
19820 2013-04-11 12:54:00      172.30.0.4 193490
19819 2013-04-11 12:53:00      172.30.0.4 191602
19823 2013-04-11 12:57:00      172.30.0.4 189878
23883 2013-04-14 15:06:00      172.30.0.4 174662
19818 2013-04-11 12:52:00      172.30.0.4 174432
```





One obvious thing to do would be to plot time series by host IP. First we have
to convert the timeMinute column from character to a date/time object. We will 
plot four IPs that we know from information distributed with the data are
HTTP servers.
  

```r
# convert timeMinute column to a time variable
bigTimeAgg$timeMinute <- as.POSIXct(bigTimeAgg$timeMinute, tz = "UTC")

# a few http servers
httpIPs <- c("172.20.0.15", "172.20.0.4", "172.10.0.4", "172.30.0.4")

# plot the time series of minute-counts by destination IP
xyplot(Freq ~ timeMinute | firstSeenDestIp, 
        data = bigTimeAgg[bigTimeAgg$firstSeenDestIp %in% httpIPs,], 
        layout = c(1, 4), as.table = TRUE, 
        strip = FALSE, strip.left = TRUE, 
        between = list(y = 0.25),
        type = c("p", "g"))
```

![plot of chunk Activity2.2.13](figures/knitr/Activity2_2_13.png) 


It is clear that the majority of this traffic for each host occurs in two 
bursts, which occur at the same time for each host.  This looks like a denial of 
service attack.  We will look at this more in more detail in the next section.


#### Calculate session duration quantiles  

Next we will explore the `drQuantile` function. `drQuantile` is another `datadr`
function that is division-agnostic, it is the analog of the `quantile` function
in R's base package. It is useful to look at data quantiles to identify 
outliers. 

Let's use `drQuantile` to calculate the quantiles of the session duration,
by source IP type (e.g. HTTP, Workstation, etc). (We will use the convenience 
function `mergeHostList` in the `cyberTools` package. This function maps the
internal IP assignments of this dataset to their assigned categories.)





```r
# compute the distribution of connection duration by source host type
dsqSrcType <- drQuantile(
   nfRaw, var = "durationSeconds", by = "type",
   preTransFn = function(x) {
      suppressMessages(library(cyberTools))
      mergeHostList(x[,c("firstSeenSrcIp", 
         "durationSeconds")], "firstSeenSrcIp")
   }
)
```





Look at the result:


```r
# look at the drQuantile output
head(dsqSrcType)
```

```
       fval q         group
1 0.0000000 0 Administrator
2 0.0004036 0 Administrator
3 0.0008071 0 Administrator
4 0.0012107 0 Administrator
5 0.0016142 0 Administrator
6 0.0020178 0 Administrator
```


Now we will plot the data. We log-transform the y axis so that differences 
in the smaller values are not completely obscured.


```r
# plot the distribution of connection duration by source host type
xyplot(log2(q + 1) ~ fval * 100 | group, 
   data = dsqSrcType, type = "p",
   xlab = "Percentile",
   ylab = "log2(duration + 1)",
   panel = function(x, y, ...) {
      panel.abline(v = seq(0, 100, by = 10), col = "#e6e6e6")
      panel.xyplot(x, y, ...)
      panel.abline(h = log2(1801), lty = 2)
   },
   layout = c(7, 1)
)
```

![plot of chunk Activity2.2.16](figures/knitr/Activity2_2_16.png) 


We can see from this plot that while the durations of the sessions initiated 
by external IPs have a lot of variability, the sessions initiated by other 
types, like Domain Controllers for example, tend to be consistently short with
a few notable outliers. Consultation with a network traffic expert would be 
necessary at this point to determine if this behavior is potentially 
concerning, and if it were, tools like Trelliscope could be used to dig into
the data and identify the source of the outliers. In the next session we will
use Trelliscope to investigate the NetFlow data, however not the duration
field.

