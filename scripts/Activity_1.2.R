################################################################
## Activity 1.2.1,  Help commands
################################################################

# When you don't know exactly what you're looking for,
# search for a topic.  There are two ways to do this:
help.search("graphics")
??graphics

# When you know the name of the R function, e.g. the function
# print(), there are two ways to do this:
help(print)
?print

# Sometimes you just need a reminder about the arguments (the
# inputs) of a function.  The args() function can help in
# this situation.  Here are the arguments for the rnorm()
# function, which generates normal random variates
args(rnorm)

# Examples are often included in the documentation of functions
# at the bottom of the documentation.  Look at:
?seq

# You can execute the example code for a function all at once
# using the example() function:
example(seq)

################################################################
## Activity 1.2.2,  Demos
################################################################

# Some R packages include demonstrations you can run to learn
# about their capability.  Be sure to hit "Enter" to
# cycle through the components of each demo

# Here's one from the 'graphics' package, which gives a nice
# demonstration of the breadth of graphical capability in R
demo("graphics")

# And here's one about generalized linear models (glm)
demo(lm.glm)

################################################################
## Activity 1.2.3,  R as a calculator
################################################################

# Addition
7 + 3

# Subtraction
7 - 3

# Multiplication
7 * 3

# Division
7 / 3

# Integer division
7 %/% 3

# Division remainder (the modulo)
7 %% 3

# exponentiation
exp(7)

# Natural logarithm
log(7)

# Base 10 log
log10(1000)

# Examples of common mathematical functions and constants
sqrt(16)
cos(pi)

# Powers:  2 to the 5th
2^5

# Large and small numbers
1.7e+05
1.7e-03

# And there are numerous statistical functions.  For example:
# The probability a standard normal random variable takes
# a value of 1.96 or lower:
pnorm(1.96)

# And the probability of 4 heads in 12 fair coin flips
dbinom(4, 12, 0.5)

# And, best of all, it handles division by 0 gracefully :)
1 / 0

# R can also perform all the standard matrix operations:
# inner and outer products, matrix multiplication, matrix
# inversion, transpose, eigen vectors and values, various
# decompositions, etc.  It has built-in numerical routines for
# root-finding, optimization, integration, differentiation,
# etc.

