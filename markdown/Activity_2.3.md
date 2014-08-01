



### Activity 2.3: Using Trelliscope to Explore Large, Complex Data ###

#### Dividing NetFlow data based on inside host 




We have looked at many summaries and are now ready to look at some of the data 
in more detail.  

For many of our analyses, it makes sense to be investigating the behaviors of 
individual hosts inside the network.  The data we read in was arbitrarily 
split into 50K rows per subset, but for doing per-inside-host analyses, it 
makes sense to divide the data by inside host.  Another division that is worth 
looking into is looking at all hosts for small slices of time, which we will 
do later.

In the `preTransFn`, we filter out the DDoS attacks, we will get rid of the 4 
big HTTP hosts cooresponding to our previous analysis.  We want to filter out 
records with destination in `httpIPs` and source in `badIPs` during `bigTimes`:
  

```r
# variables to filter on
bigTimes <- sort(unique(bigTimeAgg$timeMinute[bigTimeAgg$Freq > 1000]))
badIPs <- c("10.138.214.18", "10.17.15.10", "10.12.15.152", "10.170.32.110", "10.170.32.181", "10.10.11.102", "10.247.106.27", "10.247.58.182", "10.78.100.150", "10.38.217.48", "10.6.6.7", "10.12.14.15", "10.15.7.85", "10.156.165.120", "10.0.0.42", "10.200.20.2", "10.70.68.127", "10.138.235.111", "10.13.77.49", "10.250.178.101")
```


To create the `nfByHost` division, we define a new variable `hostIP` and split 
on that, knowing that we have taken care of inside->inside connections. `getHost()` 
takes the chunk of data being processed and adds the `hostIP` column, which is
then used to define the division.


```r
# divide data by host IP
nfByHost <- divide(nfRaw, by = "hostIP",
                   preTransFn = function(x) {
                     suppressMessages(library(cyberTools))
                     x$timeMinute <- as.POSIXct(trunc(x$date, 0, units = "mins"))
                     x <- subset(x, !(timeMinute %in% bigTimes & 
                                        firstSeenSrcIp %in% c(httpIPs, badIPs) & 
                                        firstSeenDestIp %in% c(httpIPs, badIPs)))
                     if(nrow(x) > 0) {
                       return(getHost(x))
                     } else {
                       return(NULL)
                     }
                   },
                   output = hdfsConn("nfByHost", autoYes=TRUE) 
)
nfByHost <- updateAttributes(nfByHost)
```


Let's take a look at nfByHost:


```r
# print nfbyHost
nfByHost
```

```

Distributed data object of class 'kvHDFS' with attributes: 

'ddo' attribute | value
----------------+--------------------------------------------------------------------------
 keys           | keys are available through getKeys(dat)
 totStorageSize | 150.78 MB
 totObjectSize  | 197 MB
 nDiv           | 1223
 splitSizeDistn | use splitSizeDistn(dat) to get distribution
 example        | use kvExample(dat) to get an example subset
 bsvInfo        | [empty] no BSVs have been specified

'ddf' attribute | value
----------------+--------------------------------------------------------------------------
 vars           | dateTimeStr(num), ipLayerProtocol(int), and 18 more
 transFn        | identity (original data is a data frame)
 nRow           | 1913593
 splitRowDistn  | use splitRowDistn(dat) to get distribution
 summary        | use summary(dat) to see summaries

Division:
  Type: Conditioning variable division
    Conditioning variables: hostIP

hdfsConn connection
  loc=/user/d3l348/bootcamp/nfByHost; type=map
```


Much smaller - plenty small to handle in memory actually. We can also look at
the sizes of the data divisions. `splitRowDistn()` is a function in `datadr` which
returns the quantiles of the data subsets or divisions. The plot shows there
are a few outliers with much larger size than the others; that indicates a 
few hosts with quite a bit more traffic than the rest.


```r
# look at the distribution of number of rows in nfByHost
plot(log10(splitRowDistn(nfByHost)))
```

![plot of chunk Activity2.3.4](figures/knitr/Activity2_3_4.png) 


Let's tabulate number of connections by hour.  We can do this by calling 
`recombine()`, which will `apply` a function to each subset and `combine` 
the results using `combDdo()`, which outputs a distributed data object.


```r
# roll data up to counts by hour for each host
hostTimeAgg <- recombine(nfByHost, 
   apply = function(x) {
      timeHour <- as.POSIXct(trunc(x$date, 0, units = "hours"))
      res <- data.frame(xtabs(~ timeHour))
      res$timeHour <- as.POSIXct(res$timeHour)
      res
   }, 
   combine = combDdo()
)
```





#### Creating Trelliscope displays of host activity over time

For this activity, we will make a couple of simple Trelliscope displays. The
Trelliscope documentation at <http://tesseradata.org/trelliscope/> 
has many more details than what is discussed here.

We start by loading the trelliscope library, and defining a visualization
database (VDB) connection. All subsequent displays will be saved in the
directory specified here. 


```r
# load trelliscope library
library(trelliscope)
# initiate a visualization database (VDB) connection
vdbConn("vdb_vast", autoYes=TRUE)
```


A simple visualization for our `hostTimeAgg` data is to look at the aggregated 
hourly counts vs. time for each inside host.  We can specify a panel function 
that, given one subset of our data, `x`, plots the square root of frequency vs 
timeHour. Then we test the panel on a single data division.


```r
# panel function for simple time series plot
timePanel <- function(x) {
   xyplot(sqrt(Freq) ~ timeHour, data = x, type = c("p", "g"))
}

# test on subset
timePanel(hostTimeAgg[[1]][[2]])
```

![plot of chunk Activity2.3.6b](figures/knitr/Activity2_3_6b.png) 


To help us interact with the panels in a more meaningful way, we can specify 
metrics to be computed for each subset, called "cognostics".  Using cognostics, 
in the viewer we can specify sorting and filters based on these metrics to 
help focus on panels of interest in the data.

Here is a simple cognostics function which computes for a given host metrics 
such as the number of total connections, median and standard deviation of 
number of hourly counts, etc.


```r
# cognostics function for simple time series plot
timeCog <- function(x) {
   IP <- attr(x, "split")$hostIP
   curHost <- hostList[hostList$IP == IP,]

   list(
      hostName = cog(curHost$hostName, desc = "host name"),
      type = cog(curHost$type, desc = "host type"),
      nobs = cog(sum(x$Freq), "log 10 total number of connections"),
      timeCover = cog(nrow(x), desc = "number of hours containing connections"),
      medHourCt = cog(median(sqrt(x$Freq)), 
      desc = "median square root number of connections"),
      madHourCt = cog(mad(sqrt(x$Freq)), 
      desc = "median absolute deviation square root number of connections"),
      max = cog(max(x$Freq), desc = "maximum number of connections in an hour")
   )
}
```


Once again, we test the function on a single data subset.


```r
# test on subset
timeCog(hostTimeAgg[[1]][[2]])
```

```
$hostName
[1] "wss2-259.bigmkt2.com"

$type
[1] "Workstation"

$nobs
[1] 795

$timeCover
[1] 16

$medHourCt
[1] 6.671

$madHourCt
[1] 3.057

$max
[1] 195
```


We can now make a display by providing our panel and cognostics functions, as 
well as additional information such as the name of the display and a 
description.


```r
# create the trelliscope display
makeDisplay(hostTimeAgg,
   name = "hourly_count",
   group = "inside_hosts",
   desc = "time series plot of hourly counts of connections for each inside host",
   panelFn = timePanel,
   cogFn = timeCog,
   width = 800, height = 400,
   lims = list(x = "same", y = "same")
)

# a unique port number
myport <- as.numeric(Sys.getenv("TR_PORT"))
view(port=myport)
```


When the Trelliscope viewer appears, you can choose from a list of displays 
available in the VDB specified above. (For this example, the only available
display is inside_hosts/hourly_count, but one could create and save many 
displays in the same directory at different times and they would still
be available until explicitly removed.)

![Trelliscope Fig 1](figures/trelliscope_2_1.png)

When a display is chosen, the first (randomly selected) panel is displayed. 

![Trelliscope Fig 2](figures/trelliscope_2_2.png)

First we will use the Visible Cognostics screen to augment the information shown 
with each plot. The dividing variable (`hostIP`) is selected by default, we 
will also choose `hostName` and `type`. Hit Apply to close the screen.

![Trelliscope Fig 3](figures/trelliscope_2_3.png)

Next we will filter the plots shown using the Table Sort/Filter screen. We select
only HTTP from the type column. Hit Apply to close the screen.

![Trelliscope Fig 4](figures/trelliscope_2_4.png)

Next we use the Univariate Filter screen, to choose only plots containing
outliers in the max cognostic. (The max value here is the max of frequency/hour,
so we are choosing the plots with only the largest number of connections per 
hour.) Hit Apply to close the screen.

![Trelliscope Fig 5](figures/trelliscope_2_5.png)

Finally, we will use the Panel Layout screen to allow us to view multiple plots
at a time. 

![Trelliscope Fig 6](figures/trelliscope_2_6.png)

Hit Apply to close the screen and we see 12 plots of HTTP host traffic 
displayed. The left and right arrows at the top may be used to view subsequent
plots.

![Trelliscope Fig 7](figures/trelliscope_2_7.png)

By viewing these plots together, we can easily see that there are a couple of 
different patterns of activity. A few have very low traffic, and a couple (the 
first and third) have rather cyclic patterns. Then there are four (2, 6, 7, 
and 9) that have sudden jumps between consistently low and consistently high 
traffic, and those jumps appear to happen at the same times across all four.

When finished looking at the Trelliscope view, close the browser tab or window,
and at the R prompt, type `Esc` or `Ctrl-C` to stop the server.

#### Creating Trelliscope displays that distinguish between incoming and outgoing connections

Now let's distinguish between incoming and outgoing connections. If the host 
is the first seen source, classify the connection as "outgoing" 
(this will not be 100% correct), otherwise the session will be "incoming". 
Once again, aggregate by hour.


```r
# aggregate hourly counts by "incoming", "outgoing"
hostTimeDirAgg <- recombine(nfByHost, 
   apply = function(x) {
      x$timeHour <- as.POSIXct(trunc(x$date, 0, units = "hours"))
      res <- data.frame(xtabs(~ timeHour + srcIsHost, data = x))
      res$timeHour <- as.POSIXct(res$timeHour)
      res$direction <- "incoming"
      res$direction[as.logical(as.character(res$srcIsHost))] <- "outgoing"
      subset(res, Freq > 0)
   }, 
   combine = combDdo()
)
```




  
Now we will make a similar display, showing incoming and outgoing connections.


```r
# new slightly different time panel
timePanelDir <- function(x) {
   xyplot(
      sqrt(Freq) ~ timeHour, groups = direction, 
      data = x, type = c("p", "g"), auto.key = TRUE
   )
}
```


We will also create a new cognostics function, which calculates the same
metrics as the previous one, but for incoming and outgoing connections 
separately.


```r
# new cognostics function that calculates metrics for incoming and outgoing separately
timeCog2 <- function(x) {
  IP <- attr(x, "split")$hostIP
  curHost <- hostList[hostList$IP == IP,]
  ind.incoming <- x$direction == "incoming"
    
  cog.values <- list(
      hostName = cog(curHost$hostName, desc = "host name"),
      type = cog(curHost$type, desc = "host type"),
      incomingNobs = cog(sum(x$Freq[ind.incoming]), 
         desc="log 10 total number of incoming connections"),
      outgoingNobs = cog(sum(x$Freq[!ind.incoming]), 
         desc="log 10 total number of outgoing connections"),
      incomingTimeCover = cog(sum(ind.incoming), 
         desc = "number of hours containing incoming connections"),
      outgoingTimeCover = cog(sum(!ind.incoming), 
         desc = "number of hours containing outgoing connections"),
      incomingMedHourCt = cog(median(sqrt(x$Freq[ind.incoming]), na.rm=TRUE), 
         desc = "median square root number of incoming connections"),
      outgoingMedHourCt = cog(median(sqrt(x$Freq[!ind.incoming]), na.rm=TRUE), 
         desc = "median square root number of outgoing connections"),
      incomingMadHourCt = cog(mad(sqrt(x$Freq[ind.incoming])), 
         desc = "median absolute deviation square root number of incoming connections"),
      outgoingMadHourCt = cog(mad(sqrt(x$Freq[!ind.incoming])), 
         desc = "median absolute deviation square root number of outgoing connections"),
      incomingMax = cog(max(c(0, x$Freq[ind.incoming])), 
         desc = "maximum number of incoming connections in an hour"),
      outgoingMax = cog(max(c(0, x$Freq[!ind.incoming])), 
         desc = "maximum number of outgoing connections in an hour")
  )
  cog.values[unlist(lapply(cog.values, is.na))] <- -1
  cog.values
}
```


Now, we create the display and launch the Trelliscope viewer.


```r
# create the display
makeDisplay(hostTimeDirAgg,
          name = "hourly_count_src_dest",
          group = "inside_hosts",
          desc = "time series plot of hourly counts of connections for each inside host by source / destination",
          panelFn = timePanelDir,
          width = 800, height = 400,
          cogFn = timeCog2,
          lims = list(x = "same", y = "same"))

# view display
view(port=myport)
```


When Trelliscope appears, you will see that the previous display 
(inside_hosts/hourly_count) has been joined by a new display: 
inside_hosts/hourly_count_src_dest. Choose the new one.

![Trelliscope Fig 7](figures/trelliscope_3_1.png)

There is a set of workstations that were infected with malware and now 
form a [botnet](http://en.wikipedia.org/wiki/Botnet). This botnet has 
started a recurring Denial of Service attack against an external IP. 
Can you find the machines in question?

We will start by using the Table Sort/Filter screen to filter down
to only Workstations.

![Trelliscope Fig 8](figures/trelliscope_3_2.png)

Next we will use the Univariate Filter to select the largest values
for outgoingMax.

![Trelliscope Fig 9](figures/trelliscope_3_3.png)

After using Panel Layout to adjust the number of panels visible at once,
we can see 8 plots of workstations with a distinct pattern of outgoing
traffic that is suspiciously similar. Of course this visual analysis
is not conclusive, further statistical analysis would be needed to prove 
that these workstations have a distinct pattern from the others and are 
also substatially similar. But the visual exploration facilitated by
Trelliscope was a quick and intuitive way to find relevant machines.

![Trelliscope Fig 10](figures/trelliscope_3_4.png)


