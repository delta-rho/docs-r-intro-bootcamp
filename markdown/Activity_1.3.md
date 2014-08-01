### Activity 1.3: Data Structures ###

#### Activity 1.3.1:  Numeric vectors
Numeric vectors are the fundamental building blocks of R.
Most of the techniques shown in this activity apply to any
type of vector, be it a numeric, character, or logical vector.

Suppose you wish to create an object `x` and assign it a
value of 5.  There are two ways to do this:

```r
x = 5
x <- 5
```


Display the object:

```r
x
```

```
[1] 5
```


Note that R is CaSe SenSiTivE!

```r
w <- 10
W <- 12
```


The `cat()` function prints text to the screen, which is
useful for writing messages.  The "\n" is the newline
character.

```r
cat("Little w =", w, "is different than big W =", W, "\n")
```

```
Little w = 10 is different than big W = 12 
```


You can create a numeric vector from 1 to 6 and display it
three different ways.

```r
x0 <- c(1, 2, 3, 4, 5, 6)
x1 <- seq(1, 6, by = 1)
x2 <- 1:6
```


View these three objects:

```r
x0
```

```
[1] 1 2 3 4 5 6
```

```r
x1
```

```
[1] 1 2 3 4 5 6
```

```r
x2
```

```
[1] 1 2 3 4 5 6
```


Here's a sequence from 1 to 22 stepping by 3.

```r
x <- seq(1, 22, by = 3)
x
```

```
[1]  1  4  7 10 13 16 19 22
```


This operation will square the elements of `x`.
This is a 'vectorized' calculation. This means it squares
each element indvidually and so there is no need to loop
over each element.

```r
y <- x^2
y
```

```
[1]   1  16  49 100 169 256 361 484
```


Assign a value to m:

```r
m = 0.5
```


Another vectorized calculation:  multiple each element of `y`
by m:

```r
y * m
```

```
[1]   0.5   8.0  24.5  50.0  84.5 128.0 180.5 242.0
```


Take the natural lograthrim of of each element of `y`:

```r
log(y)
```

```
[1] 0.000 2.773 3.892 4.605 5.130 5.545 5.889 6.182
```


Add two sequences together, elementwise:

```r
1:3 + 2:4
```

```
[1] 3 5 7
```


Suppose a vector is so long we don't want to display all of
it. Let's create a vector of 500 random numbers from
a normal distribution with mean of 3 and standard deviation
of 2.

```r
x <- rnorm(500, mean = 3, sd = 2)
```


The `str()` (structure) function tells us what type of object
`x` is and provides some examples of the first few values.

```r
str(x)
```

```
 num [1:500] -0.317 5.686 1.995 0.847 -0.276 ...
```


The `length()` function returns the number of elements in `x`.

```r
length(x)
```

```
[1] 500
```


We can calculate the sum, mean, max, min, and standard
deviation.

```r
sum(x)
```

```
[1] 1481
```

```r
mean(x)
```

```
[1] 2.963
```

```r
max(x)
```

```
[1] 8.478
```

```r
min(x)
```

```
[1] -3.619
```

```r
sd(x)
```

```
[1] 2.013
```


The `summary()` function provides summary statistics.

```r
summary(x)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  -3.62    1.77    3.00    2.96    4.34    8.48 
```


The `head()` and `tail()` functions shows the first or last 6 elements, respectively.

```r
head(x)
```

```
[1] -0.3169  5.6865  1.9949  0.8469 -0.2756  3.3026
```

```r
tail(x)
```

```
[1] 4.265 4.945 2.506 4.195 1.736 2.229
```


We can easily extract elements of vectors.  For example,
let's grab the 7th element of `y`:

```r
y <- 1:10
y[7]
```

```
[1] 7
```


Or let's select the 1st, 3rd, and 5th elements of `y`:

```r
y[c(1,3,5)]
```

```
[1] 1 3 5
```


Or the 6th through 8th elements:

```r
y[6:8]
```

```
[1] 6 7 8
```


To select elements that are less than 4, we first make
an indicator, which is a vector of TRUE and FALSE elements
indicating whether the elements are less than 4.

```r
indicator <- y < 4
indicator
```

```
 [1]  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
```


And now we select elements that are less than 4 from `y`:

```r
y[indicator]
```

```
[1] 1 2 3
```


Another useful tool for generating vectors is the `rep()`
function.  A vector of seven 1's:

```r
z <- rep(1, 7)
z
```

```
[1] 1 1 1 1 1 1 1
```


A sequence of 1 to 5, repeated twice:

```r
rep(1:5, 2)
```

```
 [1] 1 2 3 4 5 1 2 3 4 5
```


Another style of repeating, elementwise:

```r
rep(1:5, each = 2)
```

```
 [1] 1 1 2 2 3 3 4 4 5 5
```


#### Exercise 1.3.1: Numeric vectors


1) Create a vector from 3 to 11, in steps of 2.

2) Create another vector from 12 to 4 in steps of -2.

3) Display the last 2 elements of the second vector.

4) Calculate the mean of the element-wise product of these
   two vectors.

#### Activity 1.3.2: Character vectors


Character vectors allow you to store non-numeric data.  They
are used in R all the time.

We refer to vectors of characters as strings. To create a
character vector, we do the following:

```r
x = c("this", "that", "those")
x
```

```
[1] "this"  "that"  "those"
```


Extracting characters is the same as extracting elements.

```r
x[2:3]
```

```
[1] "that"  "those"
```


There are numerous functions for parsing, searching,
and connecting text.  For example:

```r
y <- c("cat", "dog", "fish")
paste(x, y)
```

```
[1] "this cat"   "that dog"   "those fish"
```


Or we can extract parts of the strings, known as substrings.
In this case, we extract the first 3 letters of each element,
beginning at position 1, ending at position 3.

```r
substr(x, 1, 3)
```

```
[1] "thi" "tha" "tho"
```


Count the number of characters in each element:

```r
nchar(x)
```

```
[1] 4 4 5
```


Search for the string "s" in each element of `x` and return
a logical vector:

```r
sIndicator <- grepl("s", x)
sIndicator
```

```
[1]  TRUE FALSE  TRUE
```


Select only those words that have "s":

```r
x[sIndicator]
```

```
[1] "this"  "those"
```


We can test if a value is in the string using `%in%`. Here, we
use an indicator variable to subset the original vector.

```r
mammalIndicator <- y %in% c("cat", "dog")
mammalIndicator
```

```
[1]  TRUE  TRUE FALSE
```


Now select the mammals from `y`:

```r
y[mammalIndicator]
```

```
[1] "cat" "dog"
```


Regarding quotes:  R will accept double or single quotes for
all character strings.  Use both in the same statement if
you need to nest them.

```r
x <- "A string with 'inner quotes'"
x
```

```
[1] "A string with 'inner quotes'"
```

```r
cat(x, "\n")
```

```
A string with 'inner quotes' 
```



#### Exercise 1.3.2: Character vectors
1) Create a character vector consisting of nouns (of the
   length of your choosing).
   
2) Create a second character vector of same length with
verbs.

3) Paste the two vectors together.

4) Count the total number of characters in the entire noun
   vector.  Hint, use the `sum` function.


#### Activity 1.3.3: Logical vectors


Logical vectors are used to select subsets of data and
define logical expressions in R programming.

To create a logical vector:

```r
z <- c(TRUE, FALSE, TRUE, TRUE)
z
```

```
[1]  TRUE FALSE  TRUE  TRUE
```


Or, equivalently:

```r
z <- c(T, F, T, T)
z
```

```
[1]  TRUE FALSE  TRUE  TRUE
```


We can select elements like any other vector.

```r
z[c(2,4)]
```

```
[1] FALSE  TRUE
```


The `which()` function returns the indexes of a logical vector
that are TRUE.

```r
which(z)
```

```
[1] 1 3 4
```


And we can summarize over each element in the vector.  For
example, the `any()` function returns TRUE if any elements are
TRUE.

```r
any(z)
```

```
[1] TRUE
```


And the `all()` function returns TRUE if all elments are
TRUE.

```r
all(z)
```

```
[1] FALSE
```


We can also count the number of true values in a logical
vector using the `sum()` function.

```r
sum(z)
```

```
[1] 3
```


And we can negate a logical vector.

```r
!z
```

```
[1] FALSE  TRUE FALSE FALSE
```


Let's create another logical vector, which will be TRUE
for the elements of 1,2,3,4 that are <= 2 :

```r
y <- 1:4 <= 2
y
```

```
[1]  TRUE  TRUE FALSE FALSE
```


We can perform 'and' comparisons betwen two logical
vectors, elementwise.

```r
z & y
```

```
[1]  TRUE FALSE FALSE FALSE
```


As well as 'or' comparisons, elementwise.

```r
z | y
```

```
[1] TRUE TRUE TRUE TRUE
```


#### Exercise 1.3.3: Logical vectors
1) Create random numeric vector of length 1000 with values
    uniformly chosen between 0 and 1.  Hint: use the `runif`
    function.

2) Count the number of elements in the vector that
    fall in the interval [0.2, 0.8].  On average, it should
    be 600.

#### Activity 1.3.4: Integer and complex vectors


For most applications in R, it will likely not make a
difference if you represent integer values as 'numeric'.
The difference between the 'integer' and 'numeric' classes
is that objects of class 'integer' are coded
as type 'int' in the primitive C or Fortran code that is
running underneath the R interpeter, and objects of class
'numeric' are usually typed as 'double'.  But it might be
important to you in some cases.

Notice this results in an integer:

```r
x <- 1:3
str(x)
```

```
 int [1:3] 1 2 3
```

```r
is.integer(x)
```

```
[1] TRUE
```


Whereas these end up being numeric:

```r
str(c(1, 2, 3))
```

```
 num [1:3] 1 2 3
```

```r
str(seq(1, 3, 1))
```

```
 num [1:3] 1 2 3
```


There are two fullproof ways to create integer vectors.
Here are two identical approaches:

```r
x1 <- as.integer(c(1, 5, -2))
x2 <- c(1L, 5L, -2L)
x1
```

```
[1]  1  5 -2
```

```r
x2
```

```
[1]  1  5 -2
```


Note how they are identical (not juse in value, but also
in type).

```r
identical(x1, x2)
```

```
[1] TRUE
```


Whereas if we create a numeric vector, they are not identical
because x1 is of class 'integer' and x3 is of class 'numeric'.

```r
x3 <- c(1, 2, 3)
identical(x1, x3)
```

```
[1] FALSE
```


R can also store and perform mathematical operations with
complex values (a + bi).  Here's a complex vector:

```r
v1 <- complex(real = 1:3, imaginary = 4:6)
v1
```

```
[1] 1+4i 2+5i 3+6i
```

```r
str(v1)
```

```
 cplx [1:3] 1+4i 2+5i 3+6i
```


And here are some operations on the complex vector, the sum,
and extracting the real and imaginary portions of the vector.

```r
sum(v1)
```

```
[1] 6+15i
```

```r
Re(v1)
```

```
[1] 1 2 3
```

```r
Im(v1)
```

```
[1] 4 5 6
```


See `?complex` for more details.

#### Activity 1.3.5: Named vectors


The elements of vectors in R can be named for convenience.
Here's how to create a named vector:

```r
aNamedVec <- c(type = 1, count = 7, max = 10)
aNamedVec
```

```
 type count   max 
    1     7    10 
```


You can also assign names using quoted strings, which can
include spaces or special characters:

```r
bNamedVec <- c("a type" = 1, "b%type" = 7)
bNamedVec
```

```
a type b%type 
     1      7 
```


And you can extract elements of a named vector by the names.
Notice how the name is displayed, along with the value of
the vector.

```r
aNamedVec["type"]
```

```
type 
   1 
```


Suppose you would like extract the element without the name.
You can do this using the 'double brace' syntax:

```r
aNamedVec[["type"]]
```

```
[1] 1
```


And you can extract more than one element:

```r
aNamedVec[c("type", "max")]
```

```
type  max 
   1   10 
```


But attempting to strip the names when you extract
more than one element doesn't work:

```r
try(aNamedVec[[c("type", "max")]])
```


Speaking of removing names, here's how you can do that:

```r
names(aNamedVec) <- NULL
aNamedVec
```

```
[1]  1  7 10
```


And you can use `names()` to put the names back in again, or
to change the names

```r
names(aNamedVec) <- c("type1", "count1", "max1")
aNamedVec
```

```
 type1 count1   max1 
     1      7     10 
```


And you can extract the names as well:

```r
names(aNamedVec)
```

```
[1] "type1"  "count1" "max1"  
```


These naming principles apply to any type of vector:
integer, numeric, character, logical, or complex

#### Exercise 1.3.5: Named vectors

1) Create a named character vector of length 3.

2) Create a second named logical vector of length 3.

3) Switch the names of the 2 vectors.


#### Activity 1.3.6: Data frames

Data frames consist of rows and columns (like a spreadsheet).
They are the most common way to store data in R.  Columns
can be of any type:  numeric, character, logical, complex, or
factors. (We haven't learned about factors--that's a more
advanced topic).

Here's how we could manually create a simple data frame:

```r
df <- data.frame(a = 1:6, b = letters[1:6],
                 c = rep(c(TRUE, FALSE), each = 3))
df
```

```
  a b     c
1 1 a  TRUE
2 2 b  TRUE
3 3 c  TRUE
4 4 d FALSE
5 5 e FALSE
6 6 f FALSE
```


And here's a more interesting data frame with the specs of
various automobiles that is included in the datasets package
that comes with R:

```r
mtcars
```

```
                     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```


There are a number of tools to extract info from data frames
and create subsets.

The `str` function tells the names and types of variables in
the data frame.

```r
str(mtcars)
```

```
'data.frame':	32 obs. of  11 variables:
 $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
 $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
 $ disp: num  160 160 108 258 360 ...
 $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
 $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
 $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
 $ qsec: num  16.5 17 18.6 19.4 17 ...
 $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
 $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
 $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
 $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```


Look at the first 6 rows of the data frame:

```r
head(mtcars)
```

```
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```


We can display the number of rows.

```r
nrow(mtcars)
```

```
[1] 32
```


We can display the number of columns.

```r
ncol(mtcars)
```

```
[1] 11
```


We can extract the rownames as a character vector.

```r
rownames(mtcars)
```

```
 [1] "Mazda RX4"           "Mazda RX4 Wag"       "Datsun 710"         
 [4] "Hornet 4 Drive"      "Hornet Sportabout"   "Valiant"            
 [7] "Duster 360"          "Merc 240D"           "Merc 230"           
[10] "Merc 280"            "Merc 280C"           "Merc 450SE"         
[13] "Merc 450SL"          "Merc 450SLC"         "Cadillac Fleetwood" 
[16] "Lincoln Continental" "Chrysler Imperial"   "Fiat 128"           
[19] "Honda Civic"         "Toyota Corolla"      "Toyota Corona"      
[22] "Dodge Challenger"    "AMC Javelin"         "Camaro Z28"         
[25] "Pontiac Firebird"    "Fiat X1-9"           "Porsche 914-2"      
[28] "Lotus Europa"        "Ford Pantera L"      "Ferrari Dino"       
[31] "Maserati Bora"       "Volvo 142E"         
```


We can extract the colum names as a character vector.

```r
colnames(mtcars)
```

```
 [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
[11] "carb"
```


And we can see summaries of each column.

```r
summary(mtcars)
```

```
      mpg            cyl            disp             hp       
 Min.   :10.4   Min.   :4.00   Min.   : 71.1   Min.   : 52.0  
 1st Qu.:15.4   1st Qu.:4.00   1st Qu.:120.8   1st Qu.: 96.5  
 Median :19.2   Median :6.00   Median :196.3   Median :123.0  
 Mean   :20.1   Mean   :6.19   Mean   :230.7   Mean   :146.7  
 3rd Qu.:22.8   3rd Qu.:8.00   3rd Qu.:326.0   3rd Qu.:180.0  
 Max.   :33.9   Max.   :8.00   Max.   :472.0   Max.   :335.0  
      drat            wt            qsec            vs       
 Min.   :2.76   Min.   :1.51   Min.   :14.5   Min.   :0.000  
 1st Qu.:3.08   1st Qu.:2.58   1st Qu.:16.9   1st Qu.:0.000  
 Median :3.69   Median :3.33   Median :17.7   Median :0.000  
 Mean   :3.60   Mean   :3.22   Mean   :17.8   Mean   :0.438  
 3rd Qu.:3.92   3rd Qu.:3.61   3rd Qu.:18.9   3rd Qu.:1.000  
 Max.   :4.93   Max.   :5.42   Max.   :22.9   Max.   :1.000  
       am             gear           carb     
 Min.   :0.000   Min.   :3.00   Min.   :1.00  
 1st Qu.:0.000   1st Qu.:3.00   1st Qu.:2.00  
 Median :0.000   Median :4.00   Median :2.00  
 Mean   :0.406   Mean   :3.69   Mean   :2.81  
 3rd Qu.:1.000   3rd Qu.:4.00   3rd Qu.:4.00  
 Max.   :1.000   Max.   :5.00   Max.   :8.00  
```


We can subset a data frame similar to the way we extracted
elements from vectors.  For example, let's extract the
3rd row and 4th column of mtcars.

```r
mtcars[3, 4]
```

```
[1] 93
```


Equivalently, we could have used the row and column name
to extract the data:

```r
mtcars["Datsun 710", "hp"]
```

```
[1] 93
```


In general, using the row and column name is a better
programming practice than using just the row or column
numbers because it makes code easier to read and there's no
mistaking which rows or columns were selected.

Alternativaly, you can specify rows 3, 4, and 5.
These two statements give the same result:

```r
mtcars[3:5, ]
```

```
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
```

```r
mtcars[c("Datsun 710", "Hornet 4 Drive", "Hornet Sportabout"),]
```

```
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
```


Or extract multiple rows and columns simultaneously.
These are equivalent:

```r
mtcars[c(1,30), c(1, 5:7)]
```

```
              mpg drat   wt  qsec
Mazda RX4    21.0 3.90 2.62 16.46
Ferrari Dino 19.7 3.62 2.77 15.50
```

```r
mtcars[c("Mazda RX4", "Ferrari Dino"), c("mpg", "drat",
                                         "wt", "qsec")]
```

```
              mpg drat   wt  qsec
Mazda RX4    21.0 3.90 2.62 16.46
Ferrari Dino 19.7 3.62 2.77 15.50
```


Suppose we wish to look at the vehicles that have high power
but still good gas mileage (e.g. cars with horsepower > 150
and mpg > 15):

```r
indicator <- (mtcars[,"hp"] > 150) & (mtcars[,"mpg"] > 15)
mtcars[indicator, c("hp", "mpg")]
```

```
                   hp  mpg
Hornet Sportabout 175 18.7
Merc 450SE        180 16.4
Merc 450SL        180 17.3
Merc 450SLC       180 15.2
Pontiac Firebird  175 19.2
Ford Pantera L    264 15.8
Ferrari Dino      175 19.7
```


Suppose we wish to exclude Japanese-made cars from the data:

```r
japanese <- c("Mazda RX4", "Mazda RX4 Wag", "Datsun 710",
              "Honda Civic", "Toyota Corolla", "Toyota Corona")
japaneseInd <- rownames(mtcars) %in% japanese
nonJapan <- mtcars[!japaneseInd,]
```


Did we get them all?  If so, these two numbers should be
the same.

```r
nrow(mtcars) - nrow(nonJapan)
```

```
[1] 6
```

```r
length(japanese)
```

```
[1] 6
```


And as if there weren't enough options, a single column can
be extracted from a data frame using the $.  For example,
let's get the number of gears:

```r
gears <- mtcars$gear
```


Notice it's a numeric vector.

```r
str(gears)
```

```
 num [1:32] 4 4 4 3 3 3 3 4 4 4 ...
```


And we can tabulate the number of vehicles with 3, 4, or 5
gears:

```r
table(gears)
```

```
gears
 3  4  5 
15 12  5 
```


Last of all, for variables that are discrete, with relatively
few values, we might want to do a cross tabluation.  Here's
an example comparing the number of gears to the number of
cylinders.

```r
table(mtcars[,c("cyl", "gear")])
```

```
   gear
cyl  3  4  5
  4  1  8  2
  6  2  4  1
  8 12  0  2
```


#### Exercise 1.3.6: Data frames

1) Create a data frame with at least 7 rows with the
following columns:
    1. A character vector consisting of some repetition of
       the letters 'a', 'b' and 'c'
    2. A numeric vector of randomly generated numbers between
       0 and 1.  Hint:  use `runif()`
    3. A second numeric vector of randomly generated numbers
       between 2 and 7.  Hint: use `runif()` again

 2) Display the number of rows of the data frame.

 3) Assign rownames consisting of capital letters, 'A', 'B',
    'C', etc.  Hint, use the `LETTERS` object that is part of
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
#### Activity 1.3.7: Matrices
Matrices in R are similar to data frames, with one key
difference:  all elements in a data frame must be the same
type, either integer, numeric, character, logical, or complex.

Here is a simple matrix of integers.  Notice how R loads
the matrix columnwise by default.

```r
m1 <- matrix(1:15, nrow = 5, ncol = 3)
m1
```

```
     [,1] [,2] [,3]
[1,]    1    6   11
[2,]    2    7   12
[3,]    3    8   13
[4,]    4    9   14
[5,]    5   10   15
```

```r
str(m1)
```

```
 int [1:5, 1:3] 1 2 3 4 5 6 7 8 9 10 ...
```


We could also load the matrix rowwise:

```r
m1 <- matrix(1:15, nrow = 5, ncol = 3, byrow = TRUE)
m1
```

```
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6
[3,]    7    8    9
[4,]   10   11   12
[5,]   13   14   15
```


We can add column names and rownames:

```r
rownames(m1) <- paste("Row", 1:5, sep = "")
colnames(m1) <- paste("Col", 1:3, sep = "")
m1
```

```
     Col1 Col2 Col3
Row1    1    2    3
Row2    4    5    6
Row3    7    8    9
Row4   10   11   12
Row5   13   14   15
```


Alternatively, we can add in the row and column names from
the start when we build the matrix using the `dimnames`
argument.

```r
m1 <- matrix(1:15, nrow = 5, ncol = 3,
             dimnames = list(paste("Row", 1:5, sep = ""),
                             paste("Col", 1:3, sep = "")))
m1
```

```
     Col1 Col2 Col3
Row1    1    6   11
Row2    2    7   12
Row3    3    8   13
Row4    4    9   14
Row5    5   10   15
```



We can also use `rownames()` and `colnames()` to extract
names from the matrix.

```r
rownames(m1)
```

```
[1] "Row1" "Row2" "Row3" "Row4" "Row5"
```

```r
colnames(m1)
```

```
[1] "Col1" "Col2" "Col3"
```


We can get summary information about the matrix, like
the total number of elements, using `length()`.

```r
length(m1)
```

```
[1] 15
```


The number of columns:

```r
ncol(m1)
```

```
[1] 3
```


And the number of rows:

```r
nrow(m1)
```

```
[1] 5
```



As with data frames, we can extract elements using row and
column names:

```r
m1[c("Row1", "Row3"), c("Col1", "Col2")]
```

```
     Col1 Col2
Row1    1    6
Row3    3    8
```


Or we can extract using row/column indexes:

```r
m1[c(1, 3), 1:2]
```

```
     Col1 Col2
Row1    1    6
Row3    3    8
```


Likewise, we can create a matrix of of other types.  Let's
create a matrix of boolean values (logicals).  In this case,
we'll start with a random vector of length 9 that consists
of TRUEs and FALSEs using the `sample()` function.

```r
x <- sample(c(TRUE, FALSE), 9, replace = TRUE)
```


To build the matrix, notice that we only need to specify
the number of rows, or the number of columns, but not both.
This is because the length of `x`, combined the row or column
number is sufficient to define the matrix.

```r
m2 <- matrix(x, ncol = 3)
m2
```

```
      [,1]  [,2]  [,3]
[1,] FALSE FALSE  TRUE
[2,] FALSE  TRUE  TRUE
[3,]  TRUE FALSE FALSE
```

```r
str(m2)
```

```
 logi [1:3, 1:3] FALSE FALSE TRUE FALSE TRUE FALSE ...
```


And you can melt a matrix back into a vector using `as.vector()`:

```r
x1 <- as.vector(m2)
x1
```

```
[1] FALSE FALSE  TRUE FALSE  TRUE FALSE  TRUE  TRUE FALSE
```

```r
identical(x, x1)
```

```
[1] TRUE
```


You can also create a matrix of empty values:

```r
matrix(NA,  ncol = 2, nrow = 2)
```

```
     [,1] [,2]
[1,]   NA   NA
[2,]   NA   NA
```


Or a matrix of repeated values:

```r
matrix(1,   ncol = 2, nrow = 2)
```

```
     [,1] [,2]
[1,]    1    1
[2,]    1    1
```

```r
matrix(1:2, ncol = 2, nrow = 2)
```

```
     [,1] [,2]
[1,]    1    1
[2,]    2    2
```


But if the vector you provide doesn't divide evenly into the
number of matrix elements, you get warned:

```r
matrix(1:3, ncol = 2, nrow = 2)
```

```
Warning: data length [3] is not a sub-multiple or multiple of the number
of rows [2]
```

```
     [,1] [,2]
[1,]    1    3
[2,]    2    1
```


All the standard matrix operations are available in R. Let's
create a set of conformable column vectors and matrices to
illustrate:

```r
v1 <- 1:3
v2 <- 4:6
m1 <- matrix(c(3, 11, 16, 1, 4, 1, 4, 14, 19), nrow = 3)
m2 <- matrix(1:9, ncol = 3)
```


Transpose the column vector to create a row vector:

```r
t(v1)
```

```
     [,1] [,2] [,3]
[1,]    1    2    3
```


Transpose the matrix:

```r
t(m1)
```

```
     [,1] [,2] [,3]
[1,]    3   11   16
[2,]    1    4    1
[3,]    4   14   19
```


Inner product of two vectors.  Notice it returns a 1 x 1
matrix.

```r
t(v1) %*% v2
```

```
     [,1]
[1,]   32
```


If you want to just have a simple vector (non-matrix)
object returned after calculating the inner product:

```r
as.vector(t(v1) %*% v2)
```

```
[1] 32
```


Outer product of two vectors:

```r
v1 %*% t(v2)
```

```
     [,1] [,2] [,3]
[1,]    4    5    6
[2,]    8   10   12
[3,]   12   15   18
```


Matrix multiplication:

```r
m1 %*% m2
```

```
     [,1] [,2] [,3]
[1,]   17   41   65
[2,]   61  148  235
[3,]   75  183  291
```


Matrix inversion:

```r
solve(m1)
```

```
       [,1]    [,2]     [,3]
[1,] -5.636  1.3636  0.18182
[2,] -1.364  0.6364 -0.18182
[3,]  4.818 -1.1818 -0.09091
```


Calculate eigen vectors and values:

```r
eigen(m2)
```

```
$values
[1]  1.612e+01 -1.117e+00 -5.701e-16

$vectors
        [,1]    [,2]    [,3]
[1,] -0.4645 -0.8829  0.4082
[2,] -0.5708 -0.2395 -0.8165
[3,] -0.6770  0.4039  0.4082
```


Calculate the determinant:

```r
det(m1)
```

```
[1] -11
```


Extract the diagonal elements:

```r
diag(m2)
```

```
[1] 1 5 9
```


Stack matrices on top of each other using "row bind":

```r
rbind(m1, m2)
```

```
     [,1] [,2] [,3]
[1,]    3    1    4
[2,]   11    4   14
[3,]   16    1   19
[4,]    1    4    7
[5,]    2    5    8
[6,]    3    6    9
```


Join matrices side by side using "column bind":

```r
cbind(m1, m2)
```

```
     [,1] [,2] [,3] [,4] [,5] [,6]
[1,]    3    1    4    1    4    7
[2,]   11    4   14    2    5    8
[3,]   16    1   19    3    6    9
```


By the way, `rbind()` and `cbind()` work the same way for data
frames too, so long as the variable types and the
dimensions of the data frames are conformable.

Elementwise arithmetic operations:

```r
m1 + m2
```

```
     [,1] [,2] [,3]
[1,]    4    5   11
[2,]   13    9   22
[3,]   19    7   28
```

```r
m1 - m2
```

```
     [,1] [,2] [,3]
[1,]    2   -3   -3
[2,]    9   -1    6
[3,]   13   -5   10
```

```r
m1 * m2
```

```
     [,1] [,2] [,3]
[1,]    3    4   28
[2,]   22   20  112
[3,]   48    6  171
```

```r
m1 / m2
```

```
      [,1]   [,2]   [,3]
[1,] 3.000 0.2500 0.5714
[2,] 5.500 0.8000 1.7500
[3,] 5.333 0.1667 2.1111
```


Add all the elements in the matrix:

```r
sum(m1)
```

```
[1] 73
```


Take the product of all the elments in the matrix:

```r
prod(m1)
```

```
[1] 2247168
```


Calculate the sums of the rows and of the columns:

```r
rowSums(m1)
```

```
[1]  8 29 36
```

```r
colSums(m1)
```

```
[1] 30  6 37
```


Calculate the means of the rows and of the columns:

```r
rowMeans(m1)
```

```
[1]  2.667  9.667 12.000
```

```r
colMeans(m1)
```

```
[1] 10.00  2.00 12.33
```


Use the sums to get the same results as the rowMeans

```r
colSums(m1) / nrow(m1)
```

```
[1] 10.00  2.00 12.33
```


Create a 5 x 5 identity matrix:

```r
diag(5)
```

```
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    0    0    0    0
[2,]    0    1    0    0    0
[3,]    0    0    1    0    0
[4,]    0    0    0    1    0
[5,]    0    0    0    0    1
```


#### Exercise 1.3.7:  Matrices
1) Create a 2 x 2 matrix with the following elements:
   (2, 4, 7, 1), loaded rowwise.

2) Calculate the trace (the sum of the diagonal elements)
   of the matrix.  Hint: use the `sum()` function.

3) Create a column vector of length 2 with the elements
   (3, 5).

4) Using matrix multiplication, and your results from (1)
   and (3), find the product of the transpose of the column
   vector, the matrix, and the column vector.  Display the
   result should as a single number (not a 1 x 1 matrix).

#### Activity 1.3.8:  Lists
Lists are one of the most flexible objects in R.  A list is
a collection of R objects--and these objects do not have to
be of any particular type or size.  These objects can even
be other lists.

Let's build a simple list.  Notice how the elements are quite
heterogenous (different data types, different lengths).

```r
aList <- list(a = 1:5, b = rep(TRUE, 2), c = letters[1:3])
aList
```

```
$a
[1] 1 2 3 4 5

$b
[1] TRUE TRUE

$c
[1] "a" "b" "c"
```

```r
str(aList)
```

```
List of 3
 $ a: int [1:5] 1 2 3 4 5
 $ b: logi [1:2] TRUE TRUE
 $ c: chr [1:3] "a" "b" "c"
```


We can extract the names:

```r
names(aList)
```

```
[1] "a" "b" "c"
```


And we can assign new names:

```r
names(aList) <- c("a.new", "b.new", "c.new")
aList
```

```
$a.new
[1] 1 2 3 4 5

$b.new
[1] TRUE TRUE

$c.new
[1] "a" "b" "c"
```


We can extract elements of the list using indexes, where
the double-brace [[]] notation removes the name.

```r
aList[1]
```

```
$a.new
[1] 1 2 3 4 5
```

```r
aList[[1]]
```

```
[1] 1 2 3 4 5
```


We can also extract elements by names:

```r
aList["b.new"]
```

```
$b.new
[1] TRUE TRUE
```

```r
aList[["b.new"]]
```

```
[1] TRUE TRUE
```


Like dataframes, we can also extract single elements from
a list using the `$`, just like we can with data frames

```r
aList$b.new
```

```
[1] TRUE TRUE
```


And we can extract multiple elements as well:

```r
aList[c("c.new", "b.new")]
```

```
$c.new
[1] "a" "b" "c"

$b.new
[1] TRUE TRUE
```


But if we use the double bracket with more than one element,
we end up with trouble:

```r
try(aList[[c("c.new", "b.new")]])
```


The length() function returns the number of elements

```r
length(aList)
```

```
[1] 3
```


Let's create new list:

```r
aNewList <- list(d = "nice", e = 12.7,
                 f = complex(real = 1, imaginary = 7))
aNewList
```

```
$d
[1] "nice"

$e
[1] 12.7

$f
[1] 1+7i
```


And append the new list to the first list using c()

```r
bList <- c(aList, aNewList)
bList
```

```
$a.new
[1] 1 2 3 4 5

$b.new
[1] TRUE TRUE

$c.new
[1] "a" "b" "c"

$d
[1] "nice"

$e
[1] 12.7

$f
[1] 1+7i
```


We can individually operate on each element in the list
as well, using `lapply()`.  For example, suppose we wanted
to know the length of each element in the list:

```r
lapply(bList, length)
```

```
$a.new
[1] 5

$b.new
[1] 2

$c.new
[1] 3

$d
[1] 1

$e
[1] 1

$f
[1] 1
```


Or suppose we wish to test whether each element is of type
"character", which we can do using the is.character() function

```r
lapply(bList, is.character)
```

```
$a.new
[1] FALSE

$b.new
[1] FALSE

$c.new
[1] TRUE

$d
[1] TRUE

$e
[1] FALSE

$f
[1] FALSE
```


Or perhaps we wish to convert every element into a character
vector, using `as.character()`:

```r
str(lapply(bList, as.character))
```

```
List of 6
 $ a.new: chr [1:5] "1" "2" "3" "4" ...
 $ b.new: chr [1:2] "TRUE" "TRUE"
 $ c.new: chr [1:3] "a" "b" "c"
 $ d    : chr "nice"
 $ e    : chr "12.7"
 $ f    : chr "1+7i"
```


If we want to deconstruct the list into a single vector,
we can use `unlist()`, which will create chose the type of
the resulting vector.

```r
unlist(aList)
```

```
a.new1 a.new2 a.new3 a.new4 a.new5 b.new1 b.new2 c.new1 c.new2 c.new3 
   "1"    "2"    "3"    "4"    "5" "TRUE" "TRUE"    "a"    "b"    "c" 
```


Here's another example of unlist with numeric vectors:

```r
cList <- list(a = 1:3, b = 4:10)
cList
```

```
$a
[1] 1 2 3

$b
[1]  4  5  6  7  8  9 10
```

```r
unlist(cList)
```

```
a1 a2 a3 b1 b2 b3 b4 b5 b6 b7 
 1  2  3  4  5  6  7  8  9 10 
```


We could remove the names from "aList":

```r
names(aList) <- NULL
aList
```

```
[[1]]
[1] 1 2 3 4 5

[[2]]
[1] TRUE TRUE

[[3]]
[1] "a" "b" "c"
```


But without names, you can only access the elements with
index numbers:

```r
aList[2:3]
```

```
[[1]]
[1] TRUE TRUE

[[2]]
[1] "a" "b" "c"
```


However, you can still use `lapply()` with a list that
doesn't have names.  Here we're applying the `names()` funtion
to each element of the list. The resulting NULL output
for each element confirms the names are indeed gone.

```r
lapply(aList, names)
```

```
[[1]]
NULL

[[2]]
NULL

[[3]]
NULL
```


Notice how adding `unlist()` collapes the output into a
vector.

```r
unlist(lapply(aList, is.numeric))
```

```
[1]  TRUE FALSE FALSE
```


And you can create a list without names from the start:

```r
dList <- list(1:10, rep(TRUE, 2), rnorm(3), diag(2))
dList
```

```
[[1]]
 [1]  1  2  3  4  5  6  7  8  9 10

[[2]]
[1] TRUE TRUE

[[3]]
[1]  1.853 -1.113  1.232

[[4]]
     [,1] [,2]
[1,]    1    0
[2,]    0    1
```


Last of all, there is an important connection between
lists and data frames.  Data frames are special cases of
lists!  A data frame is a list of vectors of potentially
different types that all have the same length.

#### Exercise 1.3.8: Lists
1) Create a named list with 3 elements:  a character vector,
   a numeric vector, and a 2 x 2 matrix.

2) Extract the third and first elements of the list,
   in that order.

3) Extract the 2nd element without the elment name.

4) Calculate the length of each element of the list and
   return the result as a vector.

#### Activity 1.3.9: Factors

"Factors" is a technique R uses to efficiently encode
categorical variables.  Factors are primarily used in
statistical models. Consider that a categorical predictor
variable, with n distinct possible values, must be
represented by n-1 dummy (or indicator) variables in the
model matrix. The factor representation tells R to
automatically create the dummy variables that are used in,
e.g., Analyis of Variance (ANOVA) and Analysis of Covariance
(ANCOVA) models.  Factors are also used for plotting data
in groups.

Suppose we had a categorical variable with three possible
values: "animal", "plant", or "non-living".  We'll use
`sample()` to randomly order the character vector.

```r
var <- sample(c(rep("animal", 3), rep("plant", 2),
                rep("non-living", 4)))
var
```

```
[1] "animal"     "non-living" "animal"     "non-living" "animal"    
[6] "non-living" "non-living" "plant"      "plant"     
```


We could create a factor vector as follows:

```r
f1 <- factor(var)
f1
```

```
[1] animal     non-living animal     non-living animal     non-living
[7] non-living plant      plant     
Levels: animal non-living plant
```


Notice in the structure, we see levels and the numeric
encodings of the categorical values.

```r
str(f1)
```

```
 Factor w/ 3 levels "animal","non-living",..: 1 2 1 2 1 2 2 3 3
```


Factors have a nice summary() method that counts the number
of elements that occur in each level

```r
summary(f1)
```

```
    animal non-living      plant 
         3          4          2 
```


We can extract the levels from the factor vector.  Note how
they appear in alphabetical order by default.

```r
levels(f1)
```

```
[1] "animal"     "non-living" "plant"     
```


In this case, this means that "animal" is assigned a value of
1, "non-living" a value of 2, and "plant" a value of 3.  We
can see the numerical encodings by using `as.numeric()`.

```r
as.numeric(f1)
```

```
[1] 1 2 1 2 1 2 2 3 3
```


And we can pair the codings side-by-side in a data frame
with the original character vector to see the mapping.

```r
data.frame(original = var, numerical.coding = as.numeric(f1))
```

```
    original numerical.coding
1     animal                1
2 non-living                2
3     animal                1
4 non-living                2
5     animal                1
6 non-living                2
7 non-living                2
8      plant                3
9      plant                3
```


Suppose we prefer a different mapping: plant = 1, animal = 2,
and non-living = 3. This will do the trick:

```r
f2 <- factor(var, levels = c("plant", "animal", "non-living"))
```


And we can see the new mapping:

```r
data.frame(original = var, numerical.coding = as.numeric(f2))
```

```
    original numerical.coding
1     animal                2
2 non-living                3
3     animal                2
4 non-living                3
5     animal                2
6 non-living                3
7 non-living                3
8      plant                1
9      plant                1
```


We subset factors by referencing their level names, not their
numerical coding.  For example if we wanted to identify the
elements that were "plants", we could do the following:

```r
f2 == "plant"
```

```
[1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE
```


Or, to get the index numbers:

```r
which(f2 == "plant")
```

```
[1] 8 9
```


If the original data that were used to create a factor are
character, converting the factor back to a character vector
is straightforward using `as.character()`:

```r
varRestored1 <- as.character(f1)
identical(var, varRestored1)
```

```
[1] TRUE
```


And this back-conversion works regardles of how the levels
were specified:

```r
varRestored2 <- as.character(f2)
identical(var, varRestored2)
```

```
[1] TRUE
```


We can also create factors from numeric variables as well
(provided the variable has a limited number of distinct
values).

```r
numVar <- rep(4:1, each = 2)
numVar
```

```
[1] 4 4 3 3 2 2 1 1
```

```r
f3 <- factor(numVar)
f3
```

```
[1] 4 4 3 3 2 2 1 1
Levels: 1 2 3 4
```


If the original data that were used to create a factor are
numeric, we have to take some special steps to properly
convert the factor back to its original integer (or numeric)
values.

```r
numVarRestored <- as.integer(levels(f3)[f3])
identical(numVarRestored, numVar)
```

```
[1] TRUE
```


And we can even give levels new names, or labels.
Suppose we want 1 = "good", 2 = "bad", 3 = "ugly", and 4 = "obnoxious".

```r
f4 <- factor(numVar, levels = 1:4,
             labels = c("good", "bad", "ugly", "obnoxious"))
```


Let's check it out in a variety of ways:

```r
f4
```

```
[1] obnoxious obnoxious ugly      ugly      bad       bad       good     
[8] good     
Levels: good bad ugly obnoxious
```

```r
str(f4)
```

```
 Factor w/ 4 levels "good","bad","ugly",..: 4 4 3 3 2 2 1 1
```

```r
data.frame(original = numVar, numerical.coding = as.numeric(f4),
           labels = as.character(f4))
```

```
  original numerical.coding    labels
1        4                4 obnoxious
2        4                4 obnoxious
3        3                3      ugly
4        3                3      ugly
5        2                2       bad
6        2                2       bad
7        1                1      good
8        1                1      good
```


We can also create a new mapping:  2 = "good", 1 = "bad",
4 = "ugly", and 3 = "obnoxious".

```r
f5 <- factor(numVar, levels = c(2, 1, 4, 3),
             labels = c("good", "bad", "ugly", "obnoxious"))
f5
```

```
[1] ugly      ugly      obnoxious obnoxious good      good      bad      
[8] bad      
Levels: good bad ugly obnoxious
```

```r
data.frame(original = numVar, numerical.coding = as.numeric(f5),
           labels = as.character(f5))
```

```
  original numerical.coding    labels
1        4                3      ugly
2        4                3      ugly
3        3                4 obnoxious
4        3                4 obnoxious
5        2                1      good
6        2                1      good
7        1                2       bad
8        1                2       bad
```


As before, if we want to reference elements of the factor, for
the purpose of subsetting, we have to use the level labels:

```r
subsetLogical <- f5 == "good"
subsetIndexes <- which(f5 %in% c("good", "ugly"))
```


And we can then subset the factor accordingly:

```r
f5[subsetLogical]
```

```
[1] good good
Levels: good bad ugly obnoxious
```

```r
f5[subsetIndexes]
```

```
[1] ugly ugly good good
Levels: good bad ugly obnoxious
```


Let's see how levels work in practice with ANOVA. Let's
first cook up some fake data from the standard normal
distribution to go with our numerical factor.

```r
x <- rnorm(length(numVar))
```


And then we'll look at the coefficients of an ANOVA model and
how R labels them based on the factor levels.  First, we
fit the ANOVA model:

```r
m1 <- lm(x ~ f3)
```


Notice how the parameter (coefficient) names of the ANOVA
model are `f3` with the levels of `f3` appended to them
(except for the first level, which is captured in the
intercept).

```r
coef(m1)
```

```
(Intercept)         f32         f33         f34 
     0.4176     -1.9077     -0.2581     -1.4518 
```

```r
levels(f3)
```

```
[1] "1" "2" "3" "4"
```


And here we have `f4` with the levels of `f4` appended

```r
coef(lm(x ~ f4))
```

```
(Intercept)       f4bad      f4ugly f4obnoxious 
     0.4176     -1.9077     -0.2581     -1.4518 
```

```r
levels(f4)
```

```
[1] "good"      "bad"       "ugly"      "obnoxious"
```


#### Exercise 1.3.9: Factors
1) Create a numeric vector with arbitrarily repeated
   values of 1.2, 3, and 7.9.

2) Create the numeric vector to a factor, where 3 will be
   numerically encoded as a 1, 7.9 as a 2, and 1.2 as 3.
   Display the numerical encoding.

3) Display the levels of the factor.

4) Convert the factor back to the original numerical vector.

5) Create a subset of the factor when it equals 1.2 or 3.



