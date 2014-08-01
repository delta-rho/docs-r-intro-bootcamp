

x = 5
x <- 5



x



w <- 10
W <- 12



cat("Little w =", w, "is different than big W =", W, "\n")



x0 <- c(1, 2, 3, 4, 5, 6)
x1 <- seq(1, 6, by = 1)
x2 <- 1:6



x0
x1
x2



x <- seq(1, 22, by = 3)
x



y <- x^2
y



m = 0.5



y * m



log(y)



1:3 + 2:4



x <- rnorm(500, mean = 3, sd = 2)



str(x)



length(x)



sum(x)
mean(x)
max(x)
min(x)
sd(x)



summary(x)



head(x)
tail(x)



y <- 1:10
y[7]



y[c(1,3,5)]



y[6:8]



indicator <- y < 4
indicator



y[indicator]



z <- rep(1, 7)
z



rep(1:5, 2)



rep(1:5, each = 2)



x = c("this", "that", "those")
x



x[2:3]



y <- c("cat", "dog", "fish")
paste(x, y)



substr(x, 1, 3)



nchar(x)



sIndicator <- grepl("s", x)
sIndicator



x[sIndicator]



mammalIndicator <- y %in% c("cat", "dog")
mammalIndicator



y[mammalIndicator]



x <- "A string with 'inner quotes'"
x
cat(x, "\n")



z <- c(TRUE, FALSE, TRUE, TRUE)
z



z <- c(T, F, T, T)
z



z[c(2,4)]



which(z)



any(z)



all(z)



sum(z)



!z



y <- 1:4 <= 2
y



z & y



z | y



x <- 1:3
str(x)
is.integer(x)



str(c(1, 2, 3))
str(seq(1, 3, 1))



x1 <- as.integer(c(1, 5, -2))
x2 <- c(1L, 5L, -2L)
x1
x2



identical(x1, x2)



x3 <- c(1, 2, 3)
identical(x1, x3)



v1 <- complex(real = 1:3, imaginary = 4:6)
v1
str(v1)



sum(v1)
Re(v1)
Im(v1)



aNamedVec <- c(type = 1, count = 7, max = 10)
aNamedVec



bNamedVec <- c("a type" = 1, "b%type" = 7)
bNamedVec



aNamedVec["type"]



aNamedVec[["type"]]



aNamedVec[c("type", "max")]



try(aNamedVec[[c("type", "max")]])



names(aNamedVec) <- NULL
aNamedVec



names(aNamedVec) <- c("type1", "count1", "max1")
aNamedVec



names(aNamedVec)



df <- data.frame(a = 1:6, b = letters[1:6],
                 c = rep(c(TRUE, FALSE), each = 3))
df



mtcars



str(mtcars)



head(mtcars)



nrow(mtcars)



ncol(mtcars)



rownames(mtcars)



colnames(mtcars)



summary(mtcars)



mtcars[3, 4]



mtcars["Datsun 710", "hp"]



mtcars[3:5, ]
mtcars[c("Datsun 710", "Hornet 4 Drive", "Hornet Sportabout"),]



mtcars[c(1,30), c(1, 5:7)]
mtcars[c("Mazda RX4", "Ferrari Dino"), c("mpg", "drat",
                                         "wt", "qsec")]



indicator <- (mtcars[,"hp"] > 150) & (mtcars[,"mpg"] > 15)
mtcars[indicator, c("hp", "mpg")]



japanese <- c("Mazda RX4", "Mazda RX4 Wag", "Datsun 710",
              "Honda Civic", "Toyota Corolla", "Toyota Corona")
japaneseInd <- rownames(mtcars) %in% japanese
nonJapan <- mtcars[!japaneseInd,]



nrow(mtcars) - nrow(nonJapan)
length(japanese)



gears <- mtcars$gear



str(gears)



table(gears)



table(mtcars[,c("cyl", "gear")])



m1 <- matrix(1:15, nrow = 5, ncol = 3)
m1
str(m1)



m1 <- matrix(1:15, nrow = 5, ncol = 3, byrow = TRUE)
m1



rownames(m1) <- paste("Row", 1:5, sep = "")
colnames(m1) <- paste("Col", 1:3, sep = "")
m1



m1 <- matrix(1:15, nrow = 5, ncol = 3,
             dimnames = list(paste("Row", 1:5, sep = ""),
                             paste("Col", 1:3, sep = "")))
m1



rownames(m1)
colnames(m1)



length(m1)



ncol(m1)



nrow(m1)



m1[c("Row1", "Row3"), c("Col1", "Col2")]



m1[c(1, 3), 1:2]



x <- sample(c(TRUE, FALSE), 9, replace = TRUE)



m2 <- matrix(x, ncol = 3)
m2
str(m2)



x1 <- as.vector(m2)
x1
identical(x, x1)



matrix(NA,  ncol = 2, nrow = 2)



matrix(1,   ncol = 2, nrow = 2)
matrix(1:2, ncol = 2, nrow = 2)



matrix(1:3, ncol = 2, nrow = 2)



v1 <- 1:3
v2 <- 4:6
m1 <- matrix(c(3, 11, 16, 1, 4, 1, 4, 14, 19), nrow = 3)
m2 <- matrix(1:9, ncol = 3)



t(v1)



t(m1)



t(v1) %*% v2



as.vector(t(v1) %*% v2)



v1 %*% t(v2)



m1 %*% m2



solve(m1)



eigen(m2)



det(m1)



diag(m2)



rbind(m1, m2)



cbind(m1, m2)



m1 + m2
m1 - m2
m1 * m2
m1 / m2



sum(m1)



prod(m1)



rowSums(m1)
colSums(m1)



rowMeans(m1)
colMeans(m1)



colSums(m1) / nrow(m1)



diag(5)



aList <- list(a = 1:5, b = rep(TRUE, 2), c = letters[1:3])
aList
str(aList)



names(aList)



names(aList) <- c("a.new", "b.new", "c.new")
aList



aList[1]
aList[[1]]



aList["b.new"]
aList[["b.new"]]



aList$b.new



aList[c("c.new", "b.new")]



try(aList[[c("c.new", "b.new")]])



length(aList)



aNewList <- list(d = "nice", e = 12.7,
                 f = complex(real = 1, imaginary = 7))
aNewList



bList <- c(aList, aNewList)
bList



lapply(bList, length)



lapply(bList, is.character)



str(lapply(bList, as.character))



unlist(aList)



cList <- list(a = 1:3, b = 4:10)
cList
unlist(cList)



names(aList) <- NULL
aList



aList[2:3]



lapply(aList, names)



unlist(lapply(aList, is.numeric))



dList <- list(1:10, rep(TRUE, 2), rnorm(3), diag(2))
dList



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
data.frame(original = numVar, numerical.coding = as.numeric(f5),
           labels = as.character(f5))



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


