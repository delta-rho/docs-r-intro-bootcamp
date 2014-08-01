### Activity 1.3: Exercise Solutions ###

Solutions for Exercises in Activity 1.3

#### Exercise 1.3.1: Numeric Vectors ####
1) Create a vector from 3 to 11, in steps of 2.

2) Create another vector from 12 to 4 in steps of -2.

3) Display the last 2 elements of the second vector.

4) Calculate the mean of the element-wise product of these
two vectors.

#### Solutions ####
First vector:

```r
x <- seq(3, 11, by = 2)
```


Second vector:

```r
y <- seq(12, 4, by = -2)
y
```

```
[1] 12 10  8  6  4
```


Determine the length of the vector.

```r
n <- length(y)
```


Select the last two elements.

```r
y[c(n - 1, n)]
```

```
[1] 6 4
```


Calculate the mean of the element-wise product of x and y.

```r
mean(x * y)
```

```
[1] 48
```



#### Exercise 1.3.2: Character vectors ####

1) Create a character vector consisting of nouns (of the
length of your choosing).

2) Create a second character vector of same length with verbs.

3) Paste the two vectors together.

4) Count the total number of characters in the entire noun
vector.  Hint, use the 'sum' function.

#### Solutions ####

Create the noun vector.

```r
nouns <- c("cats", "dogs", "elephants")
```


Create the verb vector.

```r
verbs <- c("bark", "climb", "jump")
```


Join them together.

```r
paste(nouns, verbs)
```

```
[1] "cats bark"      "dogs climb"     "elephants jump"
```


Count the number of characters.

```r
sum(nchar(nouns))
```

```
[1] 17
```



#### Exercise 1.3.3: Logical vectors ####
1) Create random numeric vector of length 1000 with values
uniformly chosen between 0 and 1.  Hint: use the 'runif'
function.

2) Count the number of elements in the vector that
fall in the interval [0.2, 0.8].  On average, it should
be 600.

#### Solutions ####

Generate 1000 random uniform draws in the interval [0, 1].

```r
x <- runif(1000)
```


Create the indicator for >= 0.2.

```r
above_2 <- x >= 0.2
```


Create the indicator for <= 0.8.

```r
below_8 <- x <= 0.8
```


Count the number of 'TRUE's that satisfy both conditions.

```r
sum(above_2 & below_8)
```

```
[1] 621
```


#### Exercise 1.3.5: Named vectors ####


1) Create a named character vector of length 3.

2) Create a second named logical vector of length 3.

3) Switch the names of the 2 vectors.

#### Solutions ####

A named character vector:

```r
xChar <- c(this = "one", that = "too", these = "many")
xChar
```

```
  this   that  these 
 "one"  "too" "many" 
```


A named logical vector:

```r
xLogical <- c(happy = TRUE, sad = FALSE, angry = TRUE)
xLogical
```

```
happy   sad angry 
 TRUE FALSE  TRUE 
```


Switch the names.  Begin by storing the names of 'xChar' in a character vector.

```r
xCharNames <- names(xChar)
```


Assign the names of 'xLogical' to 'xChar'.

```r
names(xChar) <- names(xLogical)
```


Assign the names of 'xChar' to 'xLogical'.

```r
names(xLogical) <- xCharNames
```


Look at the results:

```r
xChar
```

```
 happy    sad  angry 
 "one"  "too" "many" 
```

```r
xLogical
```

```
 this  that these 
 TRUE FALSE  TRUE 
```


#### Exercise 1.3.6: Data frames ####

1) Create a data frame with at least 7 rows with the
following columns:
    1. A character vector consisting of some repetition of
       the letters 'a', 'b' and 'c'
    2. A numeric vector of randomly generated numbers between
       0 and 1.  Hint:  use 'runif()'
    3. A second numeric vector of randomly generated numbers
       between 2 and 7.  Hint: use 'runif()' again

 2) Display the number of rows of the data frame.

 3) Assign rownames consisting of capital letters, 'A', 'B',
    'C', etc.  Hint, use the 'LETTERS' object that is part of
    R.

 4) Display the second column of the fourth and fifth rows
    using the row and column names of the data frame.

 5) Create a subset of the data by selecting those observations
    meet all of the following criteria:
      a.  The character vector has a value of 'b' or 'c'.
      b.  The value of the first numeric vector is greater than
          0.1.
      c.  The value of the second numeric vector is less than
          6.

#### Solutions ####

Create the data frame.  I'm using vectors of length 9.

```r
X <- data.frame(char = rep(letters[1:3], 3),
                num1 = runif(9),
                num2 = runif(9, min = 2, max = 7))
```


Get the number of rows of the data frame.

```r
n <- nrow(X)
n
```

```
[1] 9
```


Assign rownames.

```r
rownames(X) <- LETTERS[1:n]
```


Display the data frame.

```r
X
```

```
  char   num1  num2
A    a 0.4792 5.289
B    b 0.9005 6.151
C    c 0.1059 6.042
D    a 0.9707 6.014
E    b 0.7683 2.479
F    c 0.3620 3.118
G    a 0.3899 4.113
H    b 0.1370 5.031
I    c 0.7532 5.396
```


Display 2nd column, 4th and 5th rows using names.

```r
X[c("D", "E"), "num1"]
```

```
[1] 0.9707 0.7683
```



Create a subset of the data to satisfy the criteria.

```r
criteria1 <- X$char %in% c("b", "c")
criteria2 <- X$num1 > 0.1
criteria3 <- X$num2 < 6
allCrit <- criteria1 & criteria2 & criteria3
```


How many rows satisfy the criteria?

```r
sum(allCrit)
```

```
[1] 4
```


Display the subset.

```r
X[allCrit,]
```

```
  char   num1  num2
E    b 0.7683 2.479
F    c 0.3620 3.118
H    b 0.1370 5.031
I    c 0.7532 5.396
```


What happens if all values of 'allCrit' are false? We get back a data frame with no rows.

```r
allCrit <- rep(FALSE, n)
X[allCrit,]
```

```
[1] char num1 num2
<0 rows> (or 0-length row.names)
```


#### Exercise 1.3.7: Matrices ####

 1) Create a 2 x 2 matrix with the following elements:
    (2, 4, 7, 1), loaded rowwise.

 2) Calculate the trace (the sum of the diagonal elements)
    of the matrix.  Hint: use the 'sum()' function.

 3) Create a column vector of length 2 with the elements
    (3, 5).

 4) Using matrix multiplication, and your results from (1)
    and (3), find the product of the transpose of the column
    vector, the matrix, and the column vector.  Display the
    result should as a single number (not a 1 x 1 matrix).

#### Solutions ####

Create the matrix.

```r
m <- matrix(c(2, 4, 7, 1), nrow = 2, byrow = TRUE)
m
```

```
     [,1] [,2]
[1,]    2    4
[2,]    7    1
```


Calculate the trace.

```r
sum(diag(m))
```

```
[1] 3
```


Create the column vector.


```r
v <- c(3, 5)
v
```

```
[1] 3 5
```


Calcuate the product, display as a vector.

```r
as.vector(t(v) %*% m %*% v)
```

```
[1] 208
```


#### Exercise 1.3.8:  Lists ####


 1) Create a named list with 3 elements:  a character vector,
    a numeric vector, and a 2 x 2 matrix.

 2) Extract the third and first elements of the list,
    in that order.

 3) Extract the 2nd element without the elment name.

 4) Calculate the length of each element of the list and
    return the result as a vector.

#### Solutions ####

Create a list with three named elements.

```r
myList <- list(charVec = c("this", "that"),
               numVec = rnorm(7),
               mat = matrix(1:4, nrow = 2))
myList
```

```
$charVec
[1] "this" "that"

$numVec
[1] -1.6877 -0.6149 -1.0904  0.5628  0.5989 -0.0645 -0.2693

$mat
     [,1] [,2]
[1,]    1    3
[2,]    2    4
```


Extract the third and first elements.  Two ways to do this:

```r
myList[c("mat", "charVec")]
```

```
$mat
     [,1] [,2]
[1,]    1    3
[2,]    2    4

$charVec
[1] "this" "that"
```

```r
myList[c(3, 1)]
```

```
$mat
     [,1] [,2]
[1,]    1    3
[2,]    2    4

$charVec
[1] "this" "that"
```


Extract the 2nd element.  Two ways to do this:

```r
myList[["numVec"]]
```

```
[1] -1.6877 -0.6149 -1.0904  0.5628  0.5989 -0.0645 -0.2693
```

```r
myList$numVec
```

```
[1] -1.6877 -0.6149 -1.0904  0.5628  0.5989 -0.0645 -0.2693
```


Calculate the length of each element, returned as a vector.

```r
unlist(lapply(myList, length))
```

```
charVec  numVec     mat 
      2       7       4 
```

