################################################################
## Activity 1.3.1,  Numeric vectors
################################################################

# Numeric vectors are the fundamental building blocks of R.
# Most of the techniques shown in this activity apply to any
# type of vector, be it a numeric, character, or logical vector.

# Suppose you wish to create an object 'x' and assign it a
# value of 5.  There are two ways to do this:
x = 5
x <- 5

# Display the object
x

# Note that R is CaSe SenSiTivE!
w <- 10
W <- 12

# The cat() function prints text to the screen, which is
# useful for writing messages.  The "\n" is the newline
# character.
cat("Little w =", w, "is different than big W =", W, "\n")

# You can create a numeric vector from 1 to 6 and display it
# three different ways
x0 <- c(1, 2, 3, 4, 5, 6)
x1 <- seq(1, 6, by = 1)
x2 <- 1:6

# View these three objects
x0
x1
x2

# Here's a sequence from 1 to 22 stepping by 3
x <- seq(1, 22, by = 3)
x

# This operation will square the elements of x
# This is a 'vectorized' calculation. This means it squares
# each element indvidually and so there is no need to loop
# over each element
y <- x^2
y

# Assign a value to m
m = 0.5

# Another vectorized calculation:  multiple each element of y
# by m
y * m

# Take the natural lograthrim of of each element of y
log(y)

# Add two sequences together, elementwise
1:3 + 2:4

# Suppose a vector is so long we don't want to display all of
# it. Let's create a vector of 500 random numbers from
# a normal distribution with mean of 3 and standard deviation
# of 2
x <- rnorm(500, mean = 3, sd = 2)

# The str() (structure) function tells us what type of object
# 'x' is and provides some examples of the first few values
str(x)

# The length() function returns the number of elements in 'x'
length(x)

# We can calculate the sum, mean, max, min, and standard
# deviation
sum(x)
mean(x)
max(x)
min(x)
sd(x)

# The summary() function provides summary statistics
summary(x)

# The head() and tail() functions shows the first or last 6
# elements, respectively
head(x)
tail(x)

# We can easily extract elements of vectors.  For example,
# let's grab the 7th element of y
y <- 1:10
y[7]

# Or let's select the 1st, 3rd, and 5th elements of y
y[c(1,3,5)]

# Or the 6th through 8th elements
y[6:8]

# To select elements that are less than 4, we first make
# an indicator, which is a vector of TRUE and FALSE elements
# indicating whether the elements are less than 4
indicator <- y < 4
indicator

# And now we select elements that are less than 4 from y
y[indicator]

# Another useful tool for generating vectors is the rep()
# function.  A vector of seven 1's:
z <- rep(1, 7)
z

# A sequence of 1 to 5, repeated twice
rep(1:5, 2)

# Another style of repeating, elementwise
rep(1:5, each = 2)

################################################################
## Exercise 1.3.1,  Numeric vectors
################################################################

# 1) Create a vector from 3 to 11, in steps of 2
#
# 2) Create another vector from 12 to 4 in steps of -2
#
# 3) Display the last 2 elements of the second vector
#
# 4) Calculate the mean of the element-wise product of these
#    two vectors


################################################################
## Activity 1.3.2,  Character vectors
################################################################

# Character vectors allow you to store non-numeric data.  They
# are used in R all the time.

# We refer to vectors of characters as strings. To create a
# character vector, we do the following:
x = c("this", "that", "those")
x

# Extracting characters is the same as extracting elements
x[2:3]

# There are numerous functions for parsing, searching,
# and connecting text.  For example:
y <- c("cat", "dog", "fish")
paste(x, y)

# Or we can extract parts of the strings, known as substrings.
# In this case, we extract the first 3 letters of each element,
# beginning at position 1, ending at position 3
substr(x, 1, 3)

# Count the number of characters in each element
nchar(x)

# Search for the string "s" in each element of 'x' and return
# a logical vector
sIndicator <- grepl("s", x)
sIndicator

# Select only those words that have "s"
x[sIndicator]

# We can test if a value is in the string using %in%. Here, we
# use an indicator variable to subset the original vector
mammalIndicator <- y %in% c("cat", "dog")
mammalIndicator

# Now select the mammals from y
y[mammalIndicator]

# Regarding quotes:  R will accept double or single quotes for
# all character strings.  Use both in the same statement if
# you need to nest them.
x <- "A string with 'inner quotes'"
x
cat(x, "\n")

################################################################
## Exercise 1.3.2,  Character vectors
################################################################

# 1) Create a character vector consisting of nouns (of the
#    length of your choosing)
#
# 2) Create a second character vector of same length with
#    verbs
#
# 3) Paste the two vectors together
#
# 4) Count the total number of characters in the entire noun
#    vector.  Hint, use the 'sum' function


################################################################
## Activity 1.3.3,  Logical vectors
################################################################

# Logical vectors are used to select subsets of data and
# define logical expressions in R programming

# To create a logical vector:
z <- c(TRUE, FALSE, TRUE, TRUE)
z

# Or, equivalently
z <- c(T, F, T, T)
z

# We can select elements like any other vector
z[c(2,4)]

# The which() function returns the indexes of a logical vector
# that are TRUE
which(z)

# And we can summarize over each element in the vector.  For
# example, the any() function returns TRUE if any elements are
# TRUE
any(z)

# And the all() function returns TRUE if all elments are
# TRUE
all(z)

# We can also count the number of true values in a logical
# vector using the sum() function
sum(z)

# And we can negate a logical vector
!z

# Let's create another logical vector, which will be TRUE
# for the elements of 1,2,3,4 that are <= 2
y <- 1:4 <= 2
y

# We can perform 'and' comparisons betwen two logical
# vectors, elementwise
z & y

# As well as 'or' comparisons, elementwise
z | y

################################################################
## Exercise 1.3.3,  Logical vectors
################################################################

# 1) Create random numeric vector of length 1000 with values
#    uniformly chosen between 0 and 1.  Hint: use the 'runif'
#    function
#
# 2) Count the number of elements in the vector that
#    fall in the interval [0.2, 0.8].  On average, it should
#    be 600


################################################################
## Activity 1.3.4,  Integer and complex vectors
################################################################

# For most applications in R, it will likely not make a
# difference if you represent integer values as 'numeric'.
# The difference between the 'integer' and 'numeric' classes
# is that objects of class 'integer' are coded
# as type 'int' in the primitive C or Fortran code that is
# running underneath the R interpeter, and objects of class
# 'numeric' are usually typed as 'double'.  But it might be
# important to you in some cases.

# Notice this results in an integer
x <- 1:3
str(x)
is.integer(x)

# Whereas these end up being numeric:
str(c(1, 2, 3))
str(seq(1, 3, 1))

# There are two fullproof ways to create integer vectors.
# Here are two identical approaches
x1 <- as.integer(c(1, 5, -2))
x2 <- c(1L, 5L, -2L)
x1
x2

# Note how they are identical (not juse in value, but also
# in type)
identical(x1, x2)

# Whereas if we create a numeric vector, they are not identical
# because x1 is of class 'integer' and x3 is of class 'numeric'
x3 <- c(1, 2, 3)
identical(x1, x3)

# R can also store and perform mathematical operations with
# complex values (a + bi).  Here's a complex vector
v1 <- complex(real = 1:3, imaginary = 4:6)
v1
str(v1)

# And here are some operations on the complex vector, the sum,
# and extracting the real and imaginary portions of the vector
sum(v1)
Re(v1)
Im(v1)

# See ?complex for more details


################################################################
## Activity 1.3.5,  Named vectors
################################################################

# The elements of vectors in R can be named for convenience.
# Here's how to create a named vector
aNamedVec <- c(type = 1, count = 7, max = 10)
aNamedVec

# You can also assign names using quoted strings, which can
# include spaces or special characters:
bNamedVec <- c("a type" = 1, "b%type" = 7)
bNamedVec

# And you can extract elements of a named vector by the names.
# Notice how the name is displayed, along with the value of
# the vector
aNamedVec["type"]

# Suppose you would like extract the element without the name.
# You can do this using the 'double brace' syntax:
aNamedVec[["type"]]

# And you can extract more than one element
aNamedVec[c("type", "max")]

# But attempting to strip the names when you extract
# more than one element doesn't work:
try(aNamedVec[[c("type", "max")]])

# Speaking of removing names, here's how you can do that:
names(aNamedVec) <- NULL
aNamedVec

# And you can use names() to put the names back in again, or
# to change the names
names(aNamedVec) <- c("type1", "count1", "max1")
aNamedVec

# And you can extract the names as well:
names(aNamedVec)

# These naming principles apply to any type of vector:
# integer, numeric, character, logical, or complex

################################################################
## Exercise 1.3.5,  Named vectors
################################################################

# 1) Create a named character vector of length 3
#
# 2) Create a second named logical vector of length 3
#
# 3) Switch the names of the 2 vectors


################################################################
## Activity 1.3.6,  Data frames
################################################################

# Data frames consist of rows and columns (like a spreadsheet).
# They are the most common way to store data in R.  Columns
# can be of any type:  numeric, character, logical, complex, or
# factors. (We haven't learned about factors--that's a more
# advanced topic).

# Here's how we could manually create a simple data frame
df <- data.frame(a = 1:6, b = letters[1:6],
                 c = rep(c(TRUE, FALSE), each = 3))
df

# And here's a more interesting data frame with the specs of
# various automobiles that is included in the datasets package
# that comes with R:
mtcars

# There are a number of tools to extract info from data frames
# and create subsets.

# The 'str' function tells the names and types of variables in
# the data frame
str(mtcars)

# Look at the first 6 rows of the data frame
head(mtcars)

# We can display the number of rows
nrow(mtcars)

# We can display the number of columns
ncol(mtcars)

# We can extract the rownames as a character vector
rownames(mtcars)

# We can extract the colum names as a character vector
colnames(mtcars)

# And we can see summaries of each column
summary(mtcars)

# We can subset a data frame similar to the way we extracted
# elements from vectors.  For example, let's extract the
# 3rd row and 4th column of mtcars
mtcars[3, 4]

# Equivalently, we could have used the row and column name
# to extract the data:
mtcars["Datsun 710", "hp"]

# In general, using the row and column name is a better
# programming practice than using just the row or column
# numbers because it makes code easier to read and there's no
# mistaking which rows or columns were selected

# Or rows 3, 4, and 5
# These two statements give the same result
mtcars[3:5, ]
mtcars[c("Datsun 710", "Hornet 4 Drive", "Hornet Sportabout"),]

# Or extract multiple rows and columns simultaneously.
# These are equivalent:
mtcars[c(1,30), c(1, 5:7)]
mtcars[c("Mazda RX4", "Ferrari Dino"), c("mpg", "drat",
                                         "wt", "qsec")]

# Suppose we wish to look at the vehicles that have high power
# but still good gas mileage: e.g. cars with horsepower > 150
# and mpg > 15
indicator <- (mtcars[,"hp"] > 150) & (mtcars[,"mpg"] > 15)
mtcars[indicator, c("hp", "mpg")]

# Suppose we wish to exclude Japanese-made cars from the data:
japanese <- c("Mazda RX4", "Mazda RX4 Wag", "Datsun 710",
              "Honda Civic", "Toyota Corolla", "Toyota Corona")
japaneseInd <- rownames(mtcars) %in% japanese
nonJapan <- mtcars[!japaneseInd,]

# Did we get them all?  If so, these two numbers should be
# the same
nrow(mtcars) - nrow(nonJapan)
length(japanese)

# And as if there weren't enough options, a single column can
# be extracted from a data frame using the $.  For example,
# let's get the number of gears
gears <- mtcars$gear

# Notice it's a numeric vector
str(gears)

# And we can tabulate the number of vehicles with 3, 4, or 5
# gears:
table(gears)

# Last of all, for variables that are discrete (with relatively
# few values, we might want to do a cross tabluation.  Here's
# an example comparing the number of gears to the number of
# cylinders
table(mtcars[,c("cyl", "gear")])

################################################################
## Exercise 1.3.6,  Data frames
################################################################

# 1) Create a data frame with at least 7 rows with the
#    following columns:
#    1. A character vector consisting of some repetition of
#       the letters 'a', 'b' and 'c'
#    2. A numeric vector of randomly generated numbers between
#       0 and 1.  Hint:  use runif()
#    3. A second numeric vector of randomly generated numbers
#       between 2 and 7.  Hint: use runif() again
#
# 2) Display the number of rows of the data frame
#
# 3) Assign rownames consisting of capital letters, 'A', 'B',
#    'C', etc.  Hint, use the 'LETTERS' object that is part of
#    R
#
# 4) Display the second column of the fourth and fifth rows
#    using the row and column names of the data frame
#
# 5) Create a subset of the data by selecting those observations
#    meet all of the following criteria:
#    a.  The character vector has a value of 'b' or 'c'
#    b.  The value of the first numeric vector is greater than
#        0.1
#    c.  The value of the second numeric vector is less than


################################################################
## Activity 1.3.7,  Matrices
################################################################

# Matrices in R are similar to data frames, with one key
# difference:  all elements in a data frame must be the same
# type, either integer, numeric, character, logical, or complex.

# Here is a simple matrix of integers.  Notice how R loads
# the matrix columnwise by default
m1 <- matrix(1:15, nrow = 5, ncol = 3)
m1
str(m1)

# We could also load the matrix rowwise:
m1 <- matrix(1:15, nrow = 5, ncol = 3, byrow = TRUE)
m1

# We can add column names and rownames:
rownames(m1) <- paste("Row", 1:5, sep = "")
colnames(m1) <- paste("Col", 1:3, sep = "")
m1

# Alternatively, we can add in the row and column names from
# the start when we build the matrix using the 'dimnames'
# argument
m1 <- matrix(1:15, nrow = 5, ncol = 3,
             dimnames = list(paste("Row", 1:5, sep = ""),
                             paste("Col", 1:3, sep = "")))
m1


# We can also use rownames() and colnames() to extract
# names from the matrix
rownames(m1)
colnames(m1)

# We can get summary information about the matrix, like
# the total number of elements, using length()
length(m1)

# The number of columns
ncol(m1)

# And the number of rows
nrow(m1)

# As with data frames, we can extract elements using row and
# column names:
m1[c("Row1", "Row3"), c("Col1", "Col2")]

# Or we can extract using row/column indexes
m1[c(1, 3), 1:2]

# Likewise, we can create a matrix of of other types.  Let's
# create a matrix of boolean values (logicals).  In this case,
# we'll start with a random vector of length 9 that consists
# of TRUEs and FALSEs using the sample() function
x <- sample(c(TRUE, FALSE), 9, replace = TRUE)

# To build the matrix, notice that we only need to specify
# the number of rows, or the number of columns, but not both.
# This is because the length of 'x', combined the row or column
# number is sufficient to define the matrix.
m2 <- matrix(x, ncol = 3)
m2
str(m2)

# And you can melt a matrix back into a vector using as.vector()
x1 <- as.vector(m2)
x1
identical(x, x1)

# You can also create a matrix of empty values
matrix(NA,  ncol = 2, nrow = 2)

# Or a matrix of repeated values
matrix(1,   ncol = 2, nrow = 2)
matrix(1:2, ncol = 2, nrow = 2)

# But if the vector you provide doesn't divide evenly into the
# number of matrix elements, you get warned:
matrix(1:3, ncol = 2, nrow = 2)

# All the standard matrix operations are available in R. Let's
# create a set of conformable column vectors and matrices to
# illustrate:
v1 <- 1:3
v2 <- 4:6
m1 <- matrix(c(3, 11, 16, 1, 4, 1, 4, 14, 19), nrow = 3)
m2 <- matrix(1:9, ncol = 3)

# Transpose the column vector to create a row vector
t(v1)

# Transpose the matrix
t(m1)

# Inner product of two vectors.  Notice it returns a 1 x 1
# matrix.
t(v1) %*% v2

# If you want to just have a simple vector (non-matrix)
# object returned after calculating the inner product:
as.vector(t(v1) %*% v2)

# Outer product of two vectors
v1 %*% t(v2)

# Matrix multiplication
m1 %*% m2

# Matrix inversion
solve(m1)

# Calculate eigen vectors and values
eigen(m2)

# Calculate the determinant
det(m1)

# Extract the diagonal elements
diag(m2)

# Stack matrices on top of each other using "row bind"
rbind(m1, m2)

# Join matrices side by side using "column bind"
cbind(m1, m2)

# By the way, rbind() and cbind() work the same way for data
# frames too, so long as the variable types and the
# dimensions of the data frames are conformable.

# Elementwise arithmetic operations
m1 + m2
m1 - m2
m1 * m2
m1 / m2

# Add all the elements in the matrix
sum(m1)

# Take the product of all the elments in the matrix
prod(m1)

# Calculate the sums of the rows, of the columns
rowSums(m1)
colSums(m1)

# Calculate the means of the rows, of the columns
rowMeans(m1)
colMeans(m1)

# Use the sums to get the same results as the rowMeans
colSums(m1) / nrow(m1)

# Create a 5 x 5 identity matrix
diag(5)

################################################################
## Exercise 1.3.7,  Matrices
################################################################

# 1) Create a 2 x 2 matrix with the following elements:
#    (2, 4, 7, 1), loaded rowwise.
#
# 2) Calculate the trace (the sum of the diagonal elements)
#    of the matrix.  Hint: use the sum() function
#
# 3) Create a column vector of length 2 with the elements
#    (3, 5)
#
# 4) Using matrix multiplication, and your results from (1)
#    and (3), find the product of the transpose of the column
#    vector, the matrix, and the column vector.  Display the
#    result should as a single number (not a 1 x 1 matrix).



################################################################
## Activity 1.3.8,  Lists
################################################################

# Lists are one of the most flexible objects in R.  A list is
# a collection of R objects--and these objects do not have to
# be of any particular type or size.  These objects can even
# be other lists.

# Let's build a simple list.  Notice how the elements are quite
# heterogenous (different data types, different lengths)
aList <- list(a = 1:5, b = rep(TRUE, 2), c = letters[1:3])
aList
str(aList)

# We can extract the names
names(aList)

# And we can assign new names
names(aList) <- c("a.new", "b.new", "c.new")
aList

# We can extract elements of the list using indexes, where
# the double-brace [[]] notation removes the name
aList[1]
aList[[1]]

# We can also extract elements by names:
aList["b.new"]
aList[["b.new"]]

# Like dataframes, we can also extract single elements from
# a list using the '$', just like we can with data frames
aList$b.new

# And we can extract multiple elements as well
aList[c("c.new", "b.new")]

# But if we use the double bracket with more than one element,
# we end up with trouble
try(aList[[c("c.new", "b.new")]])

# The length() function returns the number of elements
length(aList)

# Let's create new list:
aNewList <- list(d = "nice", e = 12.7,
                 f = complex(real = 1, imaginary = 7))
aNewList

# And append the new list to the first list using c()
bList <- c(aList, aNewList)
bList

# We can individually operate on each element in the list
# as well, using lapply().  For example, suppose we wanted
# to know the length of each element in the list:
lapply(bList, length)

# Or suppose we wish to test whether each element is of type
# "character", which we can do using the is.character() function
lapply(bList, is.character)

# Or perhaps we wish to convert every element into a character
# vector, using as.character()
str(lapply(bList, as.character))

# If we want to deconstruct the list into a single vector,
# we can use unlist(), which will create chose the type of
# the resulting vector
unlist(aList)

# Here's another example of unlist with numeric vectors
cList <- list(a = 1:3, b = 4:10)
cList
unlist(cList)

# We could remove the names from "aList"
names(aList) <- NULL
aList

# But without names, you can only access the elements with
# index numbers
aList[2:3]

# However, you can still use lapply() with a list that
# doesn't have names.  Here we're applying the names() funtion
# to each element of the list. The resulting NULL output
# for each element confirms the names are indeed gone.
lapply(aList, names)

# Notice how adding unlist() collapes the output into a
# vector
unlist(lapply(aList, is.numeric))

# And you can create a list without names from the start
dList <- list(1:10, rep(TRUE, 2), rnorm(3), diag(2))
dList

# Last of all, there is an important connection between
# lists and data frames.  Data frames are special cases of
# lists!  A data frame is a list of vectors of potentially
# different types that all have the same length.

################################################################
## Exercise 1.3.8,  Lists
################################################################

# 1) Create a named list with 3 elements:  a character vector,
#    a numeric vector, and a 2 x 2 matrix
#
# 2) Extract the third and first elements of the list,
#    in that order
#
# 3) Extract the 2nd element without the elment name
#
# 4) Calculate the length of each element of the list and
#    return the result as a vector


################################################################
## Activity 1.3.9,  Factors
################################################################

# "Factors" is a technique R uses to efficiently encode
# categorical variables.  Factors are primarily used in
# statistical models. Consider that a categorical predictor
# variable, with n distinct possible values, must be
# represented by n-1 dummy (or indicator) variables in the
# model matrix. The factor representation tells R to
# automatically create the dummy variables that are used in,
# e.g., Analyis of Variance (ANOVA) and Analysis of Covariance
# (ANCOVA) models.  Factors are also used for plotting data
# in groups.

# Suppose we had a categorical variable with three possible
# values: "animal", "plant", or "non-living".  We'll use
# sample() to randomly order the character vector
var <- sample(c(rep("animal", 3), rep("plant", 2),
                rep("non-living", 4)))
var

# We could create a factor vector as follows:
f1 <- factor(var)
f1

# Notice in the structure, we see levels and the numeric
# encodings of the categorical values
str(f1)

# Factors have a nice summary() method that counts the number
# of elements that occur in each level
summary(f1)

# We can extract the levels from the factor vector.  Note how
# they appear in alphabetical order by default.
levels(f1)

# In this case, this means that "animal" is assigned a value of
# 1, "non-living" a value of 2, and "plant" a value of 3.  We
# can see the numerical encodings by using as.numeric()
as.numeric(f1)

# And we can pair the codings side-by-side in a data frame
# with the original character vector to see the mapping
data.frame(original = var, numerical.coding = as.numeric(f1))

# Suppose we prefer a different mapping: plant = 1, animal = 2,
# and non-living = 3. This will do the trick:
f2 <- factor(var, levels = c("plant", "animal", "non-living"))

# And we can see the new mapping:
data.frame(original = var, numerical.coding = as.numeric(f2))

# We subset factors by referencing their level names, not their
# numerical coding.  For example if we wanted to identify the
# elements that were "plants", we could do the following:
f2 == "plant"

# Or, to get the index numbers:
which(f2 == "plant")

# If the original data that were used to create a factor are
# character, converting the factor back to a character vector
# is straightforward using as.character(),
varRestored1 <- as.character(f1)
identical(var, varRestored1)

# And this back-conversion works regardles of how the levels
# were specified
varRestored2 <- as.character(f2)
identical(var, varRestored2)

# We can also create factors from numeric variables as well
# (provided the variable has a limited number of distinct
# values)
numVar <- rep(4:1, each = 2)
numVar
f3 <- factor(numVar)
f3

# If the original data that were used to create a factor are
# numeric, we have to take some special steps to properly
# convert the factor back to its original integer (or numeric)
# values.
numVarRestored <- as.integer(levels(f3)[f3])
identical(numVarRestored, numVar)

# And we can even give levels new names, or labels.
# Suppose we want 1 = "good", 2 = "bad", 3 = "ugly", and
# 4 = "obnoxious".
f4 <- factor(numVar, levels = 1:4,
             labels = c("good", "bad", "ugly", "obnoxious"))

# Let's check it out in a variety of ways
f4
str(f4)
data.frame(original = numVar, numerical.coding = as.numeric(f4),
           labels = as.character(f4))

# We can also create a new mapping:  2 = "good", 1 = "bad",
# 4 = "ugly", and 3 = "obnoxious"
f5 <- factor(numVar, levels = c(2, 1, 4, 3),
             labels = c("good", "bad", "ugly", "obnoxious"))
f5
data.frame(original = numVar, numerical.coding = as.numeric(f5),
           labels = as.character(f5))

# As before, if we want to reference elements of the factor, for
# the purpose of subsetting, we have to use the level labels:
subsetLogical <- f5 == "good"
subsetIndexes <- which(f5 %in% c("good", "ugly"))

# And we can then subset the factor accordingly
f5[subsetLogical]
f5[subsetIndexes]

# Let's see how levels work in practice with ANOVA. Let's
# first cook up some fake data from the standard normal
# distribution to go with our numerical factor
x <- rnorm(length(numVar))

# And then we'll look at the coefficients of an ANOVA model and
# how R labels them based on the factor levels.  First, we
# fit the ANOVA model:
m1 <- lm(x ~ f3)

# Notice how the parameter (coefficient) names of the ANOVA
# model are 'f3' with the levels of 'f3' appended to them
# (except for the first level, which is captured in the
# intercept).
coef(m1)
levels(f3)

# And here we have 'f4' with the levels of 'f4' appended
coef(lm(x ~ f4))
levels(f4)

################################################################
## Exercise 1.3.9,  Factors
################################################################

# 1) Create a numeric vector with arbitrarily repeated
#    values of 1.2, 3, and 7.9 .
#
# 2) Create the numeric vector to a factor, where 3 will be
#    numerically encoded as a 1, 7.9 as a 2, and 1.2 as 3.
#    Display the numerical encoding
#
# 3) Display the levels of the factor
#
# 4) Convert the factor back to the original numerical vector
#
# 5) Create a subset of the factor when it equals 1.2 or 3



