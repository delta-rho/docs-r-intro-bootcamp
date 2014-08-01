

getwd()



dir.create("working_tmp")
setwd("working_tmp")
getwd()



cat("This is one-line file\n", file = "tmpFile.txt")



dir()



unlink("tmpFile.txt")



setwd("../")



cat("x <- 10\n",
    "y <- 20\n",
    "x + y",
    sep = "",
    file = "tmp1_code.R")



dir(pattern = "tmp1_")



source("tmp1_code.R", echo = TRUE)



unlink("tmp1_code.R")



nfHead <- read.csv("nf-week2-sample.csv", nrows = 20)



str(nfHead)



nfHead <- read.csv("nf-week2-sample.csv", nrows = 20,
                   stringsAsFactors = FALSE)



str(nfHead)



nfSub <- nfHead[1:5, c("parsedDate", "firstSeenSrcIp",
                       "firstSeenSrcTotalBytes")]
nfSub



write.csv(nfSub, file = "a_temporary_subset.csv",
          row.names = FALSE)



dir(pattern = "csv")



unlink("a_temporary_subset.csv")



save(nfSub, file = "a_temporary_subset.Rdata")
dir(pattern = "Rdata")



rm(nfSub)



objectName <- load("a_temporary_subset.Rdata")



objectName



"nfSub" %in% ls()



head(nfSub)



unlink("a_temporary_subset.Rdata")



dir.create("Rlibs")



install.packages("xtable", lib = "Rlibs",
                 repos = "http://cran.case.edu")



library(xtable, lib.loc = "Rlibs")



?xtable



indicator <- (mtcars[,"hp"] > 150) & (mtcars[,"mpg"] > 15)
mtSub <- mtcars[indicator, c("hp", "mpg")]



mtSub.xtable <- xtable(mtSub)
print(mtSub.xtable, type = "html")



print(mtSub.xtable)



simple <- function(x, y) {
  return(x + y - 7)
}



simple



simple(4, 7)



simple(1:3, 5:7)



simp1 <- function(x, method = "sum") {

  if (method == "sum") {
    out <- sum(x)
  }
  else if (method == "prod") {
    out <- prod(x)
  }
  else {
    stop("'method' must be 'sum' or 'prod'")
  }

  return(out)

}



simp1(1:7)



simp1(1:7, method = "sum")



x <- simp1(1:7, method = "prod")
x



try(simp1(1:7, method = "granny"))



simp2 <- function(begin, long = TRUE) {

  # Determine the value of 'end' depending on the value of
  # 'long'
  if (long) {
    end <- begin + 10
  }
  else {
    end <- begin + 5
  }

  # A for loop from begin to end that prints each value in the
  # loop
  for (i in begin:end) {
    cat("Iteration", i, "\n")
  }

}



simp2(3)



simp2(3, long = FALSE)



simp3 <- function(x, y) {

  return(list(sum = x + y,
              product = x * y,
              quotient = x / y))

}



simp3(3, 7)



simp3(3, 7)$sum



simp3(3, 7)["sum"]
simp3(3, 7)[1]



simp3(3, 7)[["sum"]]
simp3(3, 7)[[1]]



y <- simp3(3, 7)
y[2:3]



simp4 <- function(x, y) {

    z1 <- x + 7
    z2 <- z1 * y

    # z2 is returned
    z2

}



simp4(3, -2)



simp5 <- function(n) {

  # Make a vector
  x <- 1:n

  # Write a message that tells you the mean of the vector
  cat("The mean of the numbers from 1 to", n, "is", mean(x),
      "\n")

  # Invisibly return the vector
  invisible(x)

}



simp5(100)



y <- simp5(100)
head(y)
tail(y)



simp6 <- function() {

  # Take 1 random draw from a poisson distribution with mean 20
  aRandomPoissonNumber <- rpois(1, lambda = 20)

  # Create some text to return
  textToReturn <- paste("A random Poisson variate:",
                        aRandomPoissonNumber)

  # Return the text string
  return(textToReturn)

}




simp6()
simp6()


