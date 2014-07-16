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



