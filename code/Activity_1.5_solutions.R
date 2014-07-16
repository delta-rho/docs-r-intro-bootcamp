

?faithful



with(faithful, plot(eruptions, waiting))



slrModel <- lm(waiting ~ eruptions, data = faithful)



slrModel <- lm(waiting ~ eruptions, data = faithful)
plot(faithful[,'eruptions'], faithful[,'waiting'])
abline(slrModel, col = "Red", lwd = 5)



dev.off()



x <- c(rep(1.2, 3), rep(3, 2), rep(7.9, 4))



xf <- factor(x, levels = c(3, 7.9, 1.2))
xf



as.numeric(xf)



levels(xf)



xCompare <- as.numeric(levels(xf)[xf])
identical(xCompare, x)



xf[xf %in% c("1.2", "3")]
xf[xf %in% c(1.2, 3)]



attach(quakes)



head(quakes)
str(quakes)



library(lattice)
depth_bin <- equal.count(quakes$depth, number = 9, overlap = 0)



xyplot(lat ~long | depth_bin,
       main = "Earthquakes in the Pacific",
       xlab = "longitude", ylab = "latitude")



detach(quakes)


