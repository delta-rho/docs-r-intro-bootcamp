################################################################
## Activity 1.5.1,  A simple linear regression model
################################################################

# Let's now consider fitting a simple linear regression model
# to some car data that compares stopping distance to speed
# for 50 vehicles

# Because these data are available in base R, we don't have to
# load the data or read it from a file.  We can simply access
# it by typing 'cars'

# Look at the structure of the cars data
str(cars)

# Now that we know what the column names are, let's plot the
# data
plot(cars[,"speed"], cars[,"dist"],
     xlab = "Speed", ylab = "Distance")

# Now let's fit a simple linear regression model, to use
# speed to predict the stopping distance.  We use the linear
# model function, lm()
slrModel <- lm(dist ~ speed, data = cars)

# If we call str() on 'slrModel', we see that it is a
# complicated R object called a list.
str(slrModel)

# Fortunately, there are a variety of method functions we
# can use to extract information from the 'slrModel' object.
# gives the slope, intercept, R-squared, and other statistics
summary(slrModel)

# We can also extract the coefficients of the model
coef(slrModel)

# And we can superimpose the regression line on the plot
# (Remake the plot of these data first before executing this
# command if you closed the plot)
abline(slrModel, col = "Blue")

# We can also add a smoothed line that follow the data
# using lowess()
lines(lowess(cars$speed, cars$dist), col = "Red")

# You can close the current plot using
dev.off()

# Alternatively, you can close all open plots using
graphics.off()

################################################################
## Exercise 1.5.1,  A simple linear regression model
################################################################
#
# 1) Look at the Old Faithful geyser data in Yellowstone
#    National Park.  It's the 'faithful' dataset available in
#    the base R distribution.  Use help(faithful) or ?faithful
#    to see its documentation
#
# 2) Plot the waiting time to the next eruptions vs. the
#    duration of the eruption
#
# 3) Fit a simple linear regression model to predict waiting
#    time from the eruption duration
#
# 4) Overlay the fitted model on the plot with a red line


################################################################
## Activity 1.5.2,  Trellis plots
################################################################

# This example introduces making trellis (or lattice) plots
# using the 'lattice' package and the 'mtcars' dataset

# Load the lattice package (for making trellis plots)
library(lattice)

# For convenience, attaching the data frame places it in the
# search path so that we don't always have to reference 'mtcars'
# each time we want to extract a column from the data
attach(mtcars)

# Now that we've attached it, notice how it appears in the
# 2nd position of R's search path?
search()

# Since search() returns a character vector, we could use the
# following to verify 'mtcars' is in the search path
"mtcars" %in% search()

# And thus, instead of using either of these:
head(mtcars$mpg)
head(mtcars[,"mpg"])

# We can simply use 'mpg'
head(mpg)

# In preparation for the lattice plots, we create factors with
# value labels that will aid in annotation and in dividing the
# data into groups based on the number of gears and the
# number of cylinders
gear.f <- factor(gear, levels = c(3, 4, 5),
                 labels = c("3gears", "4gears", "5gears"))

cyl.f <- factor(cyl, levels = c(4, 6, 8),
                labels = c("4cyl", "6cyl", "8cyl"))

# Let's make a kernel density plot of mpg for all the vehicles.
# A kernel density is a smoothed plot of the raw
# data. Notice that densityplot() comes from the 'lattice'
# package
densityplot(~mpg, main = "Density Plot",
            xlab = "Miles per Gallon")

# Kernel density plots for each cylinder type.  Notice
# this is where we use the factor variable for cylinder
densityplot(~mpg | cyl.f,
            main = "Density Plot by Number of Cylinders",
            xlab = "Miles per Gallon")

# Scatterplots of mpg vs. weight for each combination of
# cylinder type and gear type.  xyplot() is another function
# from the 'lattice' package
xyplot(mpg ~ wt | cyl.f * gear.f,
       main = "Scatterplots by Cylinders and Gears",
       ylab = "Miles per Gallon", xlab = "Car Weight")

# scatterplot matrix over a number of the columns
splom(mtcars[,c(1, 3:6)], main = "MTCARS Data")

# Now that we're through with mtcars, we detach it from the
# search path
detach(mtcars)

# It's no longer there
"mtcars" %in% search()

# Close the graphics window(s)
graphics.off()

################################################################
## Exercise 1.5.2,  Trellis plots
################################################################

# 1) Attach the quakes data that comes with R. Look at the
#    columns using head() or str()
#
# 2) Use xyplot to plot lat vs. long for the location of the
#    earthquakes. Label the axes and the main graphs
#    using the following command to bin the depth variable into
#    9 bins:
#
#    depthbin <- equal.count(quakes$depth, number = 9,
#                            overlap = 0)
#
#    Make sure you have loaded the lattice package via:
#    library(lattice)
#
# 3) Now use xyplot() to plot lat,long for each depthbin of
#    the earthquake to create a set of graphs in a trellis
#    display.



#########################################################
## Activity 1.5.3,  Time series analysis
#########################################################

# The data for this example contains daily counts of the number
# ('Freq') of domestic airline flights in the United States
# from 1999 until the spring of 2008

# Let's load the data, which we previously saved as an
# Rdata object.  Wrapping print() around the call to load()
# will list the name(s) of the R objects that were loaded from
# the Rdata file
print(load("dailycount.Rdata"))

# R has a built-in function for time series decompostion, where
# seasonal, trend, and irregular components can be separated
# from one another.  stl() is the function that does this.

# use R's built-in stl()
daily.stl <- stl(ts(dailycount$Freq / 1000, frequency = 7),
                 s.window = 51, s.degree = 1, t.window = 19)

# And a plot shows a visualization of the decomposition
plot(daily.stl)

# To explore some additional capability for time series
# decomposition that was developed by Ryan Hafen, we need to
# download and install his package from github.  To do that,
# we need a helper function, install_github(), which is
# available in the devtools package that is available from CRAN

# Since the 'devtools'  and 'stl' packages are already
# installed on the AWS cluster, we will skip these 3 steps
# Otherwise, you'll need to run these 3 commands:

# install.packages("devtools")
# library(devtools)
# install_github("stl2", "hafen")

# Load the stl2 package
library(stl2)

# Define a character vector of weekdays
weekdays <- c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")

# And now we calculate the time series decomposition
# (To learn more about this, begin with ?stl2 )
daily.stl2 <- stl2(dailycount$Freq / 1000, n.p = 7,
                   t = dailycount$date, s.window = 51,
                   s.degree = 1, t.window = 19,
                   sub.labels = weekdays, sub.start = 3)

# Plot the results of the decomposition
plot(daily.stl2, ylab = "Daily Flights (thousands)",
     xlab = "Time")

# We have decomposed the time series into seasonal, trend,
# and remainder components.  The trend component captures
# the overall level over time, the seasonal component (here
# day-of-week) captures changes across week over time,
# and the remainder is the residual noise not explained by
# the time series model

# When we fit models to data, we should look at those points
# where the model does not fit well.  Hence we study
# abnormal outliers in remainder:
plot.seasonal(daily.stl2, layout = c(7, 1))

# We see that Wednesday is declining over the years, while
# Monday and Tuesday are increasing.  No wonder flights
# are cheaper on Wednesdays! This pattern would have been
# difficult to see without the combination of the
# time series model and the lattice plot visualization.

# Now we turn to the trend portion of the decomposition:
# We see a drop on 9/11/2001, then a huge jump back up in 2003.
plot.trend(daily.stl2)

# This plot gives us a sense of the magnitude of the
# residuals (remainder), broken down by day of the week,
# adjusting for the seasonal effect:
plot.cycle(daily.stl2)

# Same residual plot, for each day of the week.
plot.rembycycle(daily.stl2)

# This leads us to look for places where the residuals
# are negative--indicating the model is underpredicting
# the number of flights on those days.

# What dates in remainder are large in magnitude?
ind <- which(remainder(daily.stl2) < -3)
dailycount[ind,]
# Thanksgiving, New Years, 4th of July, Christmas...

# And if we look for the largest remainder?
ind <- which(remainder(daily.stl2) < -4)
dailycount[ind,]
# We see Thanksgiving is the worst.
