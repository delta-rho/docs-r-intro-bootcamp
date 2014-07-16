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

# Solution

# See the documentation
?faithful

# Plot the data
with(faithful, plot(eruptions, waiting))

# Fit the simple linear regression model
slrModel <- lm(waiting ~ eruptions, data = faithful)

# Overlay a regression line, make it thick with the 'lwd'
# (line width) argument
abline(slrModel, col = "Red", lwd = 5)

# Shut down the graph
dev.off()

# End Solution

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

# Solution

# Attach quakes for convenience in accessing its columns
attach(quakes)

# Check out the data
head(quakes)
str(quakes)

# Create the depth binning variable
depth_bin <- equal.count(quakes$depth, number = 9, overlap = 0)

# Produce the plot
xyplot(lat ~long | depth_bin,
       main = "Earthquakes in the Pacific",
       xlab = "longitude", ylab = "latitude")

# Detach the quakes data frame
detach(quakes)

# End Solution

