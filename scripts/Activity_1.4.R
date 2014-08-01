################################################################
## Activity 1.4.1,  Working directory and sourcing files
################################################################

# The code samples above assume the data files are located in
# the R working directory, which can be found with the
# function getwd()
getwd()

# All files visible from R should be accessed relative to the
# working directory.

# Let's create a new directory and then set it as the
# working directory
dir.create("working_tmp")
setwd("working_tmp")
getwd()

# Write a one-line text file: ('\n' means new line)
cat("This is one-line file\n", file = "tmpFile.txt")

# Now look at the contents of the directory
dir()

# Delete the file
unlink("tmpFile.txt")

# Go back to the original working directory.  The "../" is the
# Unix/Linux notation for moving up one directory.  This
# syntax will work in Windows too.
setwd("../")

# Note that the forward slash should be used as the path
# separator even on Windows, for example:
# setwd("C:/Users/Me/Documents")

# When you have a large amount of code in a separate file that
# you'd like to run all at once, use the source() function.
# Let's illustrate by writing some R code to a text file using
# cat(). The "\n" are newline characters.
cat("x <- 10\n",
    "y <- 20\n",
    "x + y",
    sep = "",
    file = "tmp1_code.R")

# Now "tmp1_code.R" should be in your working directory.  We
# can verify using dir()
dir(pattern = "tmp1_")

# Now we can source (i.e. run) the code in the file.  The
# 'echo' argument displays each line as it runs
source("tmp1_code.R", echo = TRUE)

# Having sourced the file, let's remove it
unlink("tmp1_code.R")

################################################################
## Activity 1.4.2,  Read and write data to/from disc
################################################################

# There are lots of ways to read data into R.  One of the
# easiest is to write your data (perhaps from Excel) to a csv
# (Comma Separated Variable) file and then read it into R

# Read in 20 rows of NetFlow data from local disk
# into local a data frame object that we'll call nfHead
nfHead <- read.csv("nf-week2-sample.csv", nrows = 20)

# Look at the structure of nfHead.  Notice that by default,
# R converts all character variables to factors, because the
# data can be stored more efficiently that way.
str(nfHead)

# We can surpress this behavior by using the
# 'stringsAsFactors = FALSE' argument in read.csv()
nfHead <- read.csv("nf-week2-sample.csv", nrows = 20,
                   stringsAsFactors = FALSE)

# Notice that the factor variables are now character
str(nfHead)

# Let't create a new subset of the data and write the results
# back to disk
nfSub <- nfHead[1:5, c("parsedDate", "firstSeenSrcIp",
                       "firstSeenSrcTotalBytes")]
nfSub

# Now write the file to disk
write.csv(nfSub, file = "a_temporary_subset.csv",
          row.names = FALSE)

# If we call the dir() function, you should see the new
# csv file listed in the working directory.  If you are
# using a Windows machine, you could open this file in Excel
dir(pattern = "csv")

# Now we can delete the file (from R)
unlink("a_temporary_subset.csv")

# We can also save nfSub as an R data object, this will only
# be readable by R. (But it will be readable by R on any
# operating system:  Windows, Mac, or Linux).
save(nfSub, file = "a_temporary_subset.Rdata")
dir(pattern = "Rdata")

# And since we've saved it, we can remove the data frame from
# R's memory
rm(nfSub)

# If we want to load some existing data that are stored in
# the Rdata format, we do the following:
objectName <- load("a_temporary_subset.Rdata")

# Note that 'objectName' is a character vector that indicates
# the name(s) of the R object(s) that were read from the Rdata
# file
objectName

# And a call to ls() shows us the 'nfSub' object exists in R's
# memory
"nfSub" %in% ls()

# And if you need more convicing it's really there:
# head() lets us look at the first 6 lines of an object
head(nfSub)

# And now we delete the Rdata file on disk
unlink("a_temporary_subset.Rdata")

################################################################
## Exercise 1.4.2,  Read and write data to/from disc
################################################################

# 1) Verify that the file "some_fake_data.csv" is in your
#    working directory using dir()
#
# 2) Read the file "some_fake_data.csv" to a data frame
#
# 2) Create a subset of the data by selecting the
#    first and last columns whenever the second column is
#    less than 7.  Try to use the column names when
#    accessing the data frame, as it's generally a better
#    programming practice
#
# 3) Write the resulting data frame to a new csv file, called
#    "more_fake_data.csv".  Use the write.csv() function


################################################################
## Activity 1.4.3,  Installing packages
################################################################

# Often times, you'll want to use methods or functions in
# R that are available only through contributed packages that
# don't come pre-installed with R.  The 'xtable' package is an
# example of a widely used package that converts data frames
# and matrices into LaTeX or html tables.

# Prior to installation, let's create a directory where R
# will install the package. This step is not usually required
# if you are installing a package on your own computer.
dir.create("Rlibs")

# To install 'xtable', we use the install.packages() function.
# The 'libs' argument tells R where to install the package on
# your computer.  Once again, if you own the computer, this
# the 'lib' argument is not usually necessary. The "repos"
# argument allows you to specify a CRAN mirror.  For this
# example, we'll use the CRAN mirror at Case Western University.
# If you omit the "repos" argument, R will prompt you with a
# pop-up window to select a CRAN mirror. Typically, you want
# to choose a mirror that is geographically close to you.
install.packages("xtable", lib = "Rlibs",
                 repos = "http://cran.case.edu")

# Once we have installed the 'xtable' package, we need
# to load it with library() in order to use it.  Again,
# we need to tell R where to look for the library, since
# we installed it to the "Rlibs" directory.  For your
# own computer, the 'lib.loc' argument is not usually
# necessary.
library(xtable, lib.loc = "Rlibs")

# We can get a listing of the functions contained in the
# 'xtable' package using:
help(package = xtable)

# All good packages have documentation for their functions.
# Let's look at the help for the xtable() function
?xtable

# Suppose we wanted to create an html table for
# a portion of the mtcars data with the vehicles that have
# high power and relatively good gas mileage:
indicator <- (mtcars[,"hp"] > 150) & (mtcars[,"mpg"] > 15)
mtSub <- mtcars[indicator, c("hp", "mpg")]

# Now create the html table that we can copy and paste to
# an html editor using xtable() from the 'xtable' package
mtSub.xtable <- xtable(mtSub)
print(mtSub.xtable, type = "html")

# We can also render the table for use in a LaTeX document:
print(mtSub.xtable)

################################################################
## Activity 1.4.4,  Making your own functions
################################################################

# Functions are the core computational unit of R.  To the
# extent possble, good R coders divide their work into modular,
# generalizable, and reusable pieces of code that are
# often writen as functions.

# All functions in R have inputs (arguments) and outputs
# (values).  Let's define a function called simple() that
# adds two numbers together and substracts 7
simple <- function(x, y) {
  return(x + y - 7)
}

# To display the function, simply type it's name
simple

# To call the function, add in parameter values for x and y:
simple(4, 7)

# Note how we can put vectors in the arguments
simple(1:3, 5:7)

# Here's function with both unnamed and named arguments and
# some if/else statements.  Notice the indentation! This is
# a standard coding practice for readability.  Here, 'x' is an
# unnamed argument, and 'method' is a 'named' argument because
# it has a default value.
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

# Let's try it using the default for the 'method' argument.
# Note that the unnamed argument, 'x', must be supplied in
# order for the function to be called, whereas the named
# argument, 'method', will use the default value if nothing
# is supplied for it
simp1(1:7)

# Equivalenty we could have called
simp1(1:7, method = "sum")

# And now for the product, assigning the result to 'x'
x <- simp1(1:7, method = "prod")
x

# And this will throw the error. We'll wrap it in
# the try() function which will keep the error from crashing
# this script when it is sourced (i.e. run all at once)
try(simp1(1:7, method = "granny"))

# Here's a function with a 'for' loop that returns nothing.
# But it does print the iterations of the loop.  Notice the
# commenting inside the function.  Commenting is essential for
# readability! With liberal use of comments, you (at the
# very least) will know what you were doing if you revisit
# the code in the future.
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

# Call it long
simp2(3)

# Call it short
simp2(3, long = FALSE)

# In some cases, you need to return more than one object from
# your function.  The standard way to do this in R is to
# return a list.  (MANY of the base and contributed
# functions in R return lists).  Here's how:
simp3 <- function(x, y) {

  return(list(sum = x + y,
              product = x * y,
              quotient = x / y))

}

# Upon calling the function, notice it how the named list is
# returned.
simp3(3, 7)

# We can call it and extract the 'sum' from the list.
simp3(3, 7)$sum

# Or you can extract using brackets:
simp3(3, 7)["sum"]
simp3(3, 7)[1]

# And recall, if you want to strip the label name, use the
# double brackets [[]]
simp3(3, 7)[["sum"]]
simp3(3, 7)[[1]]

# Or call it, assign the output to an object, and then extract
# the last two elements
y <- simp3(3, 7)
y[2:3]

# Many R coders do not use the return() function at the end
# of their function definitions. I prefer to use return() for
# readability and clarity of the code but, technically, it is
# redundant.  The last object that is stated at the end of the
# function is automatically returned, as illustrated here:
simp4 <- function(x, y) {

    z1 <- x + 7
    z2 <- z1 * y

    # z2 is returned
    z2

}

# Call the function
simp4(3, -2)

# What if the output you return from a function is so large
# you would never want to have it displayed on the screen?  R
# has a nice trick for this:  the invisible() function
simp5 <- function(n) {

  # Make a vector
  x <- 1:n

  # Write a message that tells you the mean of the vector
  cat("The mean of the numbers from 1 to", n, "is", mean(x),
      "\n")

  # Invisibly return the vector
  invisible(x)

}

# Now, if I call the function without assigning it to an
# object, the value 'x' is not returned.  Only the cat()
# statement is printed.
simp5(100)

# But if I assign it to an object, the vector is returned
# and assigned to the object.
y <- simp5(100)
head(y)
tail(y)

# Functions can also be defined without arguments.  A common
# reason to do this might be to wrap a large script into a
# single unit of code.  This can be especially helpful
# if you need to write code with control statements (e.g.,
# if/then/else statements, for/while loops, etc.).  Control
# statements behave better in R if they are encapsulated
# within a function.
simp6 <- function() {

  # Take 1 random draw from a poisson distribution with mean 20
  aRandomPoissonNumber <- rpois(1, lambda = 20)

  # Create some text to return
  textToReturn <- paste("A random Poisson variate:",
                        aRandomPoissonNumber)

  # Return the text string
  return(textToReturn)

}

# Call it
simp6()
simp6()

################################################################
## Exercise 1.4.4,  Making your own functions
################################################################

# 1) Create a function that takes two numerical, unnamed
#    arguments, (say, 'x' and 'y') and a single named argument
#    that will determine whether your function multiplies
#    (the default) or divides your two numeric arguments,
#    'x' and 'y'
#
# 2) Call the function using scalar inputs for 'x' and 'y'
#    such that 'x' is multiplied by 'y'
#
# 3) Call the function using vector inputs for 'x' and 'y'
#    such that 'x' is divided by 'y'

