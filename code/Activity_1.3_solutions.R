

x <- seq(3, 11, by = 2)



y <- seq(12, 4, by = -2)
y



n <- length(y)



y[c(n - 1, n)]



mean(x * y)



nouns <- c("cats", "dogs", "elephants")



verbs <- c("bark", "climb", "jump")



paste(nouns, verbs)



sum(nchar(nouns))



x <- runif(1000)



above_2 <- x >= 0.2



below_8 <- x <= 0.8



sum(above_2 & below_8)



xChar <- c(this = "one", that = "too", these = "many")
xChar



xLogical <- c(happy = TRUE, sad = FALSE, angry = TRUE)
xLogical



xCharNames <- names(xChar)



names(xChar) <- names(xLogical)



names(xLogical) <- xCharNames



xChar
xLogical



X <- data.frame(char = rep(letters[1:3], 3),
                num1 = runif(9),
                num2 = runif(9, min = 2, max = 7))



n <- nrow(X)
n



rownames(X) <- LETTERS[1:n]



X



X[c("D", "E"), "num1"]



criteria1 <- X$char %in% c("b", "c")
criteria2 <- X$num1 > 0.1
criteria3 <- X$num2 < 6
allCrit <- criteria1 & criteria2 & criteria3



sum(allCrit)



X[allCrit,]



allCrit <- rep(FALSE, n)
X[allCrit,]



m <- matrix(c(2, 4, 7, 1), nrow = 2, byrow = TRUE)
m



sum(diag(m))



v <- c(3, 5)
v



as.vector(t(v) %*% m %*% v)



myList <- list(charVec = c("this", "that"),
               numVec = rnorm(7),
               mat = matrix(1:4, nrow = 2))
myList



myList[c("mat", "charVec")]
myList[c(3, 1)]



myList[["numVec"]]
myList$numVec



unlist(lapply(myList, length))


