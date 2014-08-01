### Activity 1.4: Exercise Solutions ###

Solutions for Exercises in Activity 1.4

#### Exercise 1.4.2: Read and write data to/from disc ####

1) Verify that the file "some_fake_data.csv" is in your
   working directory using `dir()`.

2) Read the file "some_fake_data.csv" to a data frame.

2) Create a subset of the data by selecting the
   first and last columns whenever the second column is
   less than 7.  Try to use the column names when
   accessing the data frame, as it's generally a better
   programming practice.
   
3) Write the resulting data frame to a new csv file, called
   "more_fake_data.csv".  Use the `write.csv()` function.
   
#### Solution ####

Check for the presence of the data.


```r
dir(pattern = "some_fake")
```

```
[1] "some_fake_data.csv"
```

Read data.


```r
d <- read.csv("some_fake_data.csv")
```

Look at the structure, notice the column names.


```r
str(d)
```

```
'data.frame':	10 obs. of  3 variables:
 $ alpha: Factor w/ 10 levels "a","b","c","d",..: 1 2 3 4 5 6 7 8 9 10
 $ beta : int  1 2 3 4 5 6 7 8 9 10
 $ gamma: num  -0.637 -0.459 0.897 -0.358 -0.577 ...
```

Create an indicator for when the 2nd column is less than 7.


```r
selIndicator <- d[,"beta"] < 7
```

Create the requested subset.


```r
dSubset <- d[selIndicator, c("alpha", "gamma")]
```

Write the output.


```r
write.csv(dSubset, file = "more_fake_data.csv",
          row.names = FALSE)
```




#### Exercise 1.4.4: Making your own functions ####


1) Create a function that takes two numerical, unnamed
   arguments, (say, `x` and `y`) and a single named argument
   that will determine whether your function multiplies
   (the default) or divides your two numeric arguments,
   `x` and `y`.

2) Call the function using scalar inputs for `x` and `y`
   such that `x` is multiplied by `y`.

3) Call the function using vector inputs for `x` and `y`
   such that `x` is divided by `y`.

#### Solution ####

Define the function.


```r
f <- function(x, y, type = "multiply") {

  if (type == "multiply") {
    out <- x * y
  }
  else if (type == "divide") {
    out <- x / y
  }
  else {
    stop("'type' must be either 'multiply' or 'divide'")
  }

  return(out)

}
```

Call it to multiply scalar values of x and y.


```r
f(3, 5)
```

```
[1] 15
```

Call it to divide two vectors.


```r
f(1:3, 7:9, type = "divide")
```

```
[1] 0.1429 0.2500 0.3333
```

