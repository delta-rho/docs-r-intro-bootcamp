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

# Solution:

# First vector
x <- seq(3, 11, by = 2)

# Second vector
y <- seq(12, 4, by = -2)
y

# Determine the length of the vector
n <- length(y)

# Select the last two elements
y[c(n - 1, n)]

# Calculte the mean of the element-wise product of x and y
mean(x * y)

# End Solution

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

# Solution:

# Create the noun vector
nouns <- c("cats", "dogs", "elephants")

# Create the verb vector
verbs <- c("bark", "climb", "jump")

# Join them together
paste(nouns, verbs)

# Count the number of characters
sum(nchar(nouns))

# End Solution

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

# Solution

# Generate 1000 random uniform draws in the interval [0, 1]
x <- runif(1000)

# Create the indicator for >= 0.2
above_2 <- x >= 0.2

# Create the indicator for <= 0.8
below_8 <- x <= 0.8

# Count the number of 'TRUE's that satisfy both conditions
sum(above_2 & below_8)

# End Solution

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

# Solution

# Create the data frame.  I'm using vectors of length 9
X <- data.frame(char = rep(letters[1:3], 3),
                num1 = runif(9),
                num2 = runif(9, min = 2, max = 7))

# Get the number of rows of the data frame
n <- nrow(X)
n

# Assign rownames
rownames(X) <- LETTERS[1:n]

# Display the data frame
X

# Display 2nd column, 4th and 5th rows using names
X[c("D", "E"), "num1"]


# Create a subset of the data to satisfy the criteria
criteria1 <- X$char %in% c("b", "c")
criteria2 <- X$num1 > 0.1
criteria3 <- X$num2 < 6
allCrit <- criteria1 & criteria2 & criteria3

# How many rows satisfy the criteria?
sum(allCrit)

# Display the subset
X[allCrit,]

# What happens if all values of 'allCrit' are false? We get
# back a data frame with no rows
allCrit <- rep(FALSE, n)
X[allCrit,]

# End Solution

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

# Solution

# Create a list with three named elements
myList <- list(charVec = c("this", "that"),
               numVec = rnorm(7),
               mat = matrix(1:4, nrow = 2))
myList

# Extract the third and first elements.  Two ways to do this:
myList[c("mat", "charVec")]
myList[c(3, 1)]

# Extract the 2nd element.  Two ways to do this:
myList[["numVec"]]
myList$numVec


# End Solution

