###########################################################
### Activity 2.2
### Using DataDR and Trelliscope with Hadoop for 
### distributed computing.
###########################################################

## Activity 2.2.1
library(datadr)
library(Rhipe)
library(cyberTools)
rhinit()

# set time zone to "UTC" for use with dates in the data
Sys.setenv(TZ = "UTC")

# set working directories on local machine and HDFS
setwd("~")

# set working directory in HDFS
hdfs.setwd(Sys.getenv("HDFS_USER_VAST"))


## Activity 2.2.2
# make sure raw text data has been copied to HDFS
rhls("raw/nf") 


## Activity 2.2.3
# make a date parsing function to use during data ingest
nfTransform <- function(x) {
   x$date <- as.POSIXct(as.numeric(as.character(x$TimeSeconds)), origin = "1970-01-01", tz = "UTC")
   x[,setdiff(names(x), c("TimeSeconds", "parsedDate", "dateTimeStr"))]  
}

# initiate a connection to existing csv text file on HDFS
csvConn <- hdfsConn("raw/nf", type = "text")

# initiate a new connection where parsed NetFlow data will be stored
nfConn <- hdfsConn("nfRaw", autoYes=TRUE) 


## Activity 2.2.4
# read in NetFlow data
nfRaw <- drRead.csv(csvConn, output = nfConn, postTransFn = nfTransform)


## Activity 2.2.5
# look at the nfRaw object 
nfRaw 


## Activity 2.2.6
# update attributes to calculate summary statistics
nfRaw <- updateAttributes(nfRaw)

# nfRaw can be reloaded in any subsequent R session using the following command
nfRaw <- ddf(hdfsConn("nfRaw"))


## Activity 2.2.7
# look at the updated nfRaw object
nfRaw


## Activity 2.2.8
# get total number of rows
nrow(nfRaw)

# see what variables are available
names(nfRaw)


## Activity 2.2.9
# look at the structure of the first key-value pair
str(nfRaw[[1]])


## Activity 2.2.10
# look at summaries (computed from updateAttributes)
summary(nfRaw)


## Activity 2.2.11
## count sessions per minute per destination IP
bigTimeAgg <- drAggregate(~ timeMinute + firstSeenDestIp, 
                 data = nfRaw, 
                 preTransFn = function(x) {
                     x$timeMinute <- as.POSIXct(trunc(x$date, 0, units="mins"))
                     x
                 })

# sort by number of sessions
bigTimeAgg <- bigTimeAgg[order(bigTimeAgg$Freq, decreasing=TRUE),]


## Activity 2.2.12
# look at the first few rows
head(bigTimeAgg)


## Activity 2.2.13
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


## Activity 2.2.14
# compute the distribution of connection duration by source host type
dsqSrcType <- drQuantile(
   nfRaw, var = "durationSeconds", by = "type",
   preTransFn = function(x) {
      suppressMessages(library(cyberTools))
      mergeHostList(x[,c("firstSeenSrcIp", 
         "durationSeconds")], "firstSeenSrcIp")
   }
)


## Activity 2.2.15
# look at the drQuantile output
head(dsqSrcType)


## Activity 2.2.16
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
