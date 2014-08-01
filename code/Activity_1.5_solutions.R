

?faithful



with(faithful, plot(eruptions, waiting))



slrModel <- lm(waiting ~ eruptions, data = faithful)



plot(slrModel, col = "Red", lwd = 5)



dev.off()



attach(quakes)



head(quakes)
str(quakes)



library(lattice)
depth_bin <- equal.count(quakes$depth, number = 9, overlap = 0)



xyplot(lat ~long | depth_bin,
main = "Earthquakes in the Pacific",
xlab = "longitude", ylab = "latitude")



detach(quakes)


