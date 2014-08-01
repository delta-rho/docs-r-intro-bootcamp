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
## Exercise 1.3.5,  Named vectors
################################################################

# 1) Create a named character vector of length 3
#
# 2) Create a second named logical vector of length 3
#
# 3) Switch the names of the 2 vectors

# Solution

# A named character vector
xChar <- c(this = "one", that = "too", these = "many")
xChar

# A named logical vector
xLogical <- c(happy = TRUE, sad = FALSE, angry = TRUE)
xLogical

# Switch the names.  Begin by storing the names of xChar in a
# character vector
xCharNames <- names(xChar)

# Assign the names of xLogical to xChar
names(xChar) <- names(xLogical)

# Assign the names of xChar to xLogical
names(xLogical) <- xCharNames

# Look at the results
xChar
xLogical

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

# Solution

# Create the matrix
m <- matrix(c(2, 4, 7, 1), nrow = 2, byrow = TRUE)
m

# Calculate the trace
sum(diag(m))

# Create the column vector
v <- c(3, 5)
v

# Calcuate the product, display as a vector
as.vector(t(v) %*% m %*% v)

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
# 4) Calculate the length of each element of the list and
#    return the result as a vector

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

# Calculate the length of each element, returned as a vector
unlist(lapply(myList, length))

# End Solution

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

# Solution

# Create a numeric vector
x <- c(rep(1.2, 3), rep(3, 2), rep(7.9, 4))

# Convert it to a factor with the encoding specified
xf <- factor(x, levels = c(3, 7.9, 1.2))
xf

# Display the numerical encoding
as.numeric(xf)

# Display the levels
levels(xf)

# Convert the factor object back again to numeric and compare
xCompare <- as.numeric(levels(xf)[xf])
identical(xCompare, x)

# Create a subset when the factor is 1.2 or 3.  Both of these
# produce identical results. In the second instance,
# R is converts the numeric values of 1.2 and 3 to character.
xf[xf %in% c("1.2", "3")]
xf[xf %in% c(1.2, 3)]

# End Solution

