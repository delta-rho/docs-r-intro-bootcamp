

str(cars)



plot(cars[, "speed"], cars[, "dist"], xlab = "Speed", ylab = "Distance")



slrModel <- lm(dist ~ speed, data = cars)



str(slrModel)



summary(slrModel)



coef(slrModel)



plot(cars[, "speed"], cars[, "dist"], xlab = "Speed", ylab = "Distance")
abline(slrModel, col = "Blue")



plot(cars[, "speed"], cars[, "dist"], xlab = "Speed", ylab = "Distance")
lines(lowess(cars$speed, cars$dist), col = "Red")



dev.off()



graphics.off()



library(lattice)



attach(mtcars)



search()



"mtcars" %in% search()



head(mtcars$mpg)



head(mtcars[, "mpg"])



head(mpg)



gear.f <- factor(gear, levels = c(3, 4, 5), labels = c("3gears", "4gears", "5gears"))
cyl.f <- factor(cyl, levels = c(4, 6, 8), labels = c("4cyl", "6cyl", "8cyl"))



densityplot(~mpg, main = "Density Plot", xlab = "Miles per Gallon")



densityplot(~mpg | cyl.f, main = "Density Plot by Number of Cylinders", xlab = "Miles per Gallon")



xyplot(mpg ~ wt | cyl.f * gear.f, main = "Scatterplots by Cylinders and Gears", 
    ylab = "Miles per Gallon", xlab = "Car Weight")



splom(mtcars[, c(1, 3:6)], main = "MTCARS Data")



detach(mtcars)



"mtcars" %in% search()



graphics.off()



print(load("dailycount.Rdata"))



daily.stl <- stl(ts(dailycount$Freq/1000, frequency = 7), s.window = 51, s.degree = 1, 
    t.window = 19)



plot(daily.stl)



install.packages("devtools")
library(devtools)
install_github("stl2", "hafen")



install.packages("stl12", lib = "Rlibs", repos = "http://cran.case.edu")



library(stl2)



weekdays <- c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")



daily.stl2 <- stl2(dailycount$Freq/1000, n.p = 7, t = dailycount$date, s.window = 51, 
    s.degree = 1, t.window = 19, sub.labels = weekdays, sub.start = 3)



plot(daily.stl2, ylab = "Daily Flights (thousands)", xlab = "Time")



plot.seasonal(daily.stl2, layout = c(7, 1))



plot.trend(daily.stl2)



plot.cycle(daily.stl2)



plot.rembycycle(daily.stl2)



ind <- which(remainder(daily.stl2) < -3)
dailycount[ind, ]



ind <- which(remainder(daily.stl2) < -4)
dailycount[ind, ]


