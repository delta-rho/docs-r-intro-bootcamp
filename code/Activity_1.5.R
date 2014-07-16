

str(cars)



plot(cars[,"speed"], cars[,"dist"],
xlab = "Speed", ylab = "Distance")



slrModel <- lm(dist ~ speed, data = cars)



str(slrModel)



summary(slrModel)



coef(slrModel)



slrModel <- lm(cars[,"dist"]~ cars[,"speed"])
plot(cars[,"speed"], cars[,"dist"], xlab='Speed', ylab='Distance')
abline(a=-17.57, b= 3.93, col = "Blue")



slrModel <- lm(cars[,"dist"]~ cars[,"speed"])
plot(cars[,"speed"], cars[,"dist"], xlab='Speed', ylab='Distance')
abline(a=-17.57, b= 3.93, col = "Blue")
lines(lowess(cars$speed, cars$dist), col = "Red")



dev.off()



graphics.off()



var <- sample(c(rep("animal", 3), rep("plant", 2),
                rep("non-living", 4)))
var



f1 <- factor(var)
f1



str(f1)



summary(f1)



levels(f1)



as.numeric(f1)



data.frame(original = var, numerical.coding = as.numeric(f1))



f2 <- factor(var, levels = c("plant", "animal", "non-living"))



data.frame(original = var, numerical.coding = as.numeric(f2))



f2 == "plant"



which(f2 == "plant")



varRestored1 <- as.character(f1)
identical(var, varRestored1)



varRestored2 <- as.character(f2)
identical(var, varRestored2)



numVar <- rep(4:1, each = 2)
numVar
f3 <- factor(numVar)
f3



numVarRestored <- as.integer(levels(f3)[f3])
identical(numVarRestored, numVar)



f4 <- factor(numVar, levels = 1:4,
             labels = c("good", "bad", "ugly", "obnoxious"))



f4
str(f4)
data.frame(original = numVar, numerical.coding = as.numeric(f4),
labels = as.character(f4))



f5 <- factor(numVar, levels = c(2, 1, 4, 3),
labels = c("good", "bad", "ugly", "obnoxious"))
f5
data.frame(original = numVar, 
            numerical.coding = as.numeric(f5),
            labels = as.character(f5)
          )



subsetLogical <- f5 == "good"
subsetIndexes <- which(f5 %in% c("good", "ugly"))



f5[subsetLogical]
f5[subsetIndexes]



x <- rnorm(length(numVar))



m1 <- lm(x ~ f3)



coef(m1)
levels(f3)



coef(lm(x ~ f4))
levels(f4)



library(lattice)



attach(mtcars)



search()



"mtcars" %in% search()



head(mtcars$mpg)
head(mtcars[,"mpg"])



head(mpg)



gear.f <- factor(gear, levels = c(3, 4, 5),
labels = c("3gears", "4gears", "5gears"))

cyl.f <- factor(cyl, levels = c(4, 6, 8),
labels = c("4cyl", "6cyl", "8cyl"))



densityplot(~mpg, main = "Density Plot",
            xlab = "Miles per Gallon")



densityplot(~mpg | cyl.f,
            main = "Density Plot by Number of Cylinders",
            xlab = "Miles per Gallon")



xyplot(mpg ~ wt | cyl.f * gear.f,
       main = "Scatterplots by Cylinders and Gears",
       ylab = "Miles per Gallon", xlab = "Car Weight")



splom(mtcars[,c(1, 3:6)], main = "MTCARS Data")



detach(mtcars)



"mtcars" %in% search()



graphics.off()



print(load("dailycount.Rdata"))



daily.stl <- stl(ts(dailycount$Freq / 1000, frequency = 7),
                 s.window = 51, s.degree = 1, t.window = 19)



plot(daily.stl)



install.packages("devtools")
library(devtools)
install_github("stl2", "hafen")



library(stl2)



weekdays <- c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")



daily.stl2 <- stl2(dailycount$Freq / 1000, n.p = 7,
t = dailycount$date, s.window = 51,
s.degree = 1, t.window = 19,
sub.labels = weekdays, sub.start = 3)



plot(daily.stl2, ylab = "Daily Flights (thousands)",
xlab = "Time")



plot.seasonal(daily.stl2, layout = c(7, 1))



plot.trend(daily.stl2)



plot.cycle(daily.stl2)



plot.rembycycle(daily.stl2)



ind <- which(remainder(daily.stl2) < -3)
dailycount[ind,]



ind <- which(remainder(daily.stl2) < -4)
dailycount[ind,]


