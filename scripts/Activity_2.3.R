############################################################
### Activity 2.3
### Trelliscope displays for NetFlow dataset
############################################################

## Activity 2.3.1
# variables to filter on
bigTimes <- sort(unique(bigTimeAgg$timeMinute[bigTimeAgg$Freq > 1000]))
badIPs <- c("10.138.214.18", "10.17.15.10", "10.12.15.152", "10.170.32.110", "10.170.32.181", "10.10.11.102", "10.247.106.27", "10.247.58.182", "10.78.100.150", "10.38.217.48", "10.6.6.7", "10.12.14.15", "10.15.7.85", "10.156.165.120", "10.0.0.42", "10.200.20.2", "10.70.68.127", "10.138.235.111", "10.13.77.49", "10.250.178.101")


## Activity 2.3.2
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


## Activity 2.3.3
# print nfByHost
nfByHost


## Activity 2.3.4
# look at the distribution of number of rows in nfByHost
plot(log10(splitRowDistn(nfByHost)))


## Activity 2.3.5
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


## Activity 2.3.6
# load trelliscope library
library(trelliscope)
# initiate a visualization database (VDB) connection
vdbConn("vdb_vast", autoYes=TRUE)

# panel function for simple time series plot
timePanel <- function(x) {
   xyplot(sqrt(Freq) ~ timeHour, data = x, type = c("p", "g"))
}

# test on subset
timePanel(hostTimeAgg[[1]][[2]])


## Activity 2.3.7
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


## Activity 2.3.8
# test on subset
timeCog(hostTimeAgg[[1]][[2]])


## Activity 2.3.9
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

myport <- as.numeric(Sys.getenv("TR_PORT"))
view(port=myport)


## Activity 2.3.10
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


## Activity 2.3.11
# new slightly different time panel
timePanelDir <- function(x) {
   xyplot(
      sqrt(Freq) ~ timeHour, groups = direction, 
      data = x, type = c("p", "g"), auto.key = TRUE
   )
}

## Activity 2.3.12
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


## Activity 2.3.13
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
