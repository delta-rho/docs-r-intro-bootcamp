


###########################################################
### Activity 2.2
### Using DataDR and Trelliscope with Hadoop for 
### distributed computing.
###########################################################



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



# make sure raw text data has been copied to HDFS
rhls("raw/nf")



# make a date parsing function to use during data ingest
nfTransform <- function(x) {
   x$date <- as.POSIXct(as.numeric(as.character(x$TimeSeconds)), 
      origin = "1970-01-01", tz = "UTC")
   x[,setdiff(names(x), c("TimeSeconds", "parsedDate"))]
}



# initiate a connection to existing csv text file on HDFS
csvConn <- hdfsConn("raw/nf", type = "text")



# initiate a new connection where parsed NetFlow data will be stored
nfConn <- hdfsConn("nfRaw", autoYes=TRUE) 



# read in NetFlow data
nfRaw <- drRead.csv(csvConn, output = nfConn, postTransFn = nfTransform)





# look at the nfRaw object
nfRaw



# get missing attributes
nfRaw <- updateAttributes(nfRaw)



# reload "nfRaw" by loading the connection as a ddf
nfRaw <- ddf(hdfsConn("nfRaw"))





# look at the updated nfRaw object
nfRaw



# get total number of rows
nrow(nfRaw)



# see what variables are available
names(nfRaw)



# look at the structure of the first key-value pair
str(nfRaw[[1]])



# look at summaries (computed from updateAttributes)
summary(nfRaw)



# load cached version of bigTimeAgg
load("data/artifacts/bigTimeAgg.Rdata")



# count sessions per minute per destination IP
bigTimeAgg <- drAggregate(~ timeMinute + firstSeenDestIp, 
                 data = nfRaw, 
                 preTransFn = function(x) {
                     x$timeMinute <- as.POSIXct(trunc(x$date, 0, units = "mins"))
                     x
                 })



# sort by number of sessions
bigTimeAgg <- bigTimeAgg[order(bigTimeAgg$Freq, decreasing=TRUE),]

# look at the first few rows
head(bigTimeAgg)       



# create "data/artifacts" to store results
dir.create("data/artifacts", recursive = TRUE, showWarnings=FALSE)

# save aggregation to disk
save(bigTimeAgg, file = "data/artifacts/bigTimeAgg.Rdata")



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



# load cached version of dsqSrcType
load("data/artifacts/quantSrcType.Rdata")



# compute the distribution of connection duration by source host type
dsqSrcType <- drQuantile(
   nfRaw, var = "durationSeconds", by = "type",
   preTransFn = function(x) {
      suppressMessages(library(cyberTools))
      mergeHostList(x[,c("firstSeenSrcIp", 
         "durationSeconds")], "firstSeenSrcIp")
   }
)



# save quantiles to disk
save(dsqSrcType, file = "data/artifacts/quantSrcType.Rdata")



# look at the drQuantile output
head(dsqSrcType)



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


