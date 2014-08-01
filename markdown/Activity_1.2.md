## Activity 1: Introduction to R ##

### Activity 1.2: Getting Started ###

#### Activity 1.2.1: Help commands


When you don't know exactly what you're looking for,
search for a topic.  There are two ways to do this:


```r
help.search("graphics")
??graphics
```


When you know the name of the R function, e.g. the function
`print()`, there are two ways to do this:

```r
help(print)
?print
```



Sometimes you just need a reminder about the arguments (the
inputs) of a function.  The `args()` function can help in
this situation.  Here are the arguments for the `rnorm()`
function, which generates normal random variates:

```r
args(rnorm)
```

```
function (n, mean = 0, sd = 1) 
NULL
```


Examples are often included in the documentation of functions
at the bottom of the documentation.  Look at:


```r
?seq
```


You can execute the example code for a function all at once
using the `example()` function:


```r
example(seq)
```

```

seq> seq(0, 1, length.out = 11)
 [1] 0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0

seq> seq(stats::rnorm(20)) # effectively 'along'
 [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20

seq> seq(1, 9, by = 2)     # matches 'end'
[1] 1 3 5 7 9

seq> seq(1, 9, by = pi)    # stays below 'end'
[1] 1.000 4.142 7.283

seq> seq(1, 6, by = 3)
[1] 1 4

seq> seq(1.575, 5.125, by = 0.05)
 [1] 1.575 1.625 1.675 1.725 1.775 1.825 1.875 1.925 1.975 2.025 2.075
[12] 2.125 2.175 2.225 2.275 2.325 2.375 2.425 2.475 2.525 2.575 2.625
[23] 2.675 2.725 2.775 2.825 2.875 2.925 2.975 3.025 3.075 3.125 3.175
[34] 3.225 3.275 3.325 3.375 3.425 3.475 3.525 3.575 3.625 3.675 3.725
[45] 3.775 3.825 3.875 3.925 3.975 4.025 4.075 4.125 4.175 4.225 4.275
[56] 4.325 4.375 4.425 4.475 4.525 4.575 4.625 4.675 4.725 4.775 4.825
[67] 4.875 4.925 4.975 5.025 5.075 5.125

seq> seq(17) # same as 1:17, or even better seq_len(17)
 [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17
```


#### Activity 1.2.2: Demos


Some R packages include demonstrations you can run to learn
about their capability.  Be sure to hit "Enter" to
cycle through the components of each demo.

Here's one from the `graphics` package, which gives a nice
demonstration of the breadth of graphical capability in R.


```r
demo("graphics")
```

```


	demo(graphics)
	---- ~~~~~~~~

> #  Copyright (C) 1997-2009 The R Core Team
> 
> require(datasets)

> require(grDevices); require(graphics)

> ## Here is some code which illustrates some of the differences between
> ## R and S graphics capabilities.  Note that colors are generally specified
> ## by a character string name (taken from the X11 rgb.txt file) and that line
> ## textures are given similarly.  The parameter "bg" sets the background
> ## parameter for the plot and there is also an "fg" parameter which sets
> ## the foreground color.
> 
> 
> x <- stats::rnorm(50)

> opar <- par(bg = "white")

> plot(x, ann = FALSE, type = "n")
```

![plot of chunk unnamed-chunk-6](figures/knitr/unnamed-chunk-61.png) 

```

> abline(h = 0, col = gray(.90))

> lines(x, col = "green4", lty = "dotted")

> points(x, bg = "limegreen", pch = 21)

> title(main = "Simple Use of Color In a Plot",
+       xlab = "Just a Whisper of a Label",
+       col.main = "blue", col.lab = gray(.8),
+       cex.main = 1.2, cex.lab = 1.0, font.main = 4, font.lab = 3)

> ## A little color wheel.	 This code just plots equally spaced hues in
> ## a pie chart.	If you have a cheap SVGA monitor (like me) you will
> ## probably find that numerically equispaced does not mean visually
> ## equispaced.  On my display at home, these colors tend to cluster at
> ## the RGB primaries.  On the other hand on the SGI Indy at work the
> ## effect is near perfect.
> 
> par(bg = "gray")

> pie(rep(1,24), col = rainbow(24), radius = 0.9)
```

![plot of chunk unnamed-chunk-6](figures/knitr/unnamed-chunk-62.png) 

```

> title(main = "A Sample Color Wheel", cex.main = 1.4, font.main = 3)

> title(xlab = "(Use this as a test of monitor linearity)",
+       cex.lab = 0.8, font.lab = 3)

> ## We have already confessed to having these.  This is just showing off X11
> ## color names (and the example (from the postscript manual) is pretty "cute".
> 
> pie.sales <- c(0.12, 0.3, 0.26, 0.16, 0.04, 0.12)

> names(pie.sales) <- c("Blueberry", "Cherry",
+ 		      "Apple", "Boston Cream", "Other", "Vanilla Cream")

> pie(pie.sales,
+     col = c("purple","violetred1","green3","cornsilk","cyan","white"))
```

![plot of chunk unnamed-chunk-6](figures/knitr/unnamed-chunk-63.png) 

```

> title(main = "January Pie Sales", cex.main = 1.8, font.main = 1)

> title(xlab = "(Don't try this at home kids)", cex.lab = 0.8, font.lab = 3)

> ## Boxplots:  I couldn't resist the capability for filling the "box".
> ## The use of color seems like a useful addition, it focuses attention
> ## on the central bulk of the data.
> 
> par(bg="cornsilk")

> n <- 10

> g <- gl(n, 100, n*100)

> x <- rnorm(n*100) + sqrt(as.numeric(g))

> boxplot(split(x,g), col="lavender", notch=TRUE)
```

![plot of chunk unnamed-chunk-6](figures/knitr/unnamed-chunk-64.png) 

```

> title(main="Notched Boxplots", xlab="Group", font.main=4, font.lab=1)

> ## An example showing how to fill between curves.
> 
> par(bg="white")

> n <- 100

> x <- c(0,cumsum(rnorm(n)))

> y <- c(0,cumsum(rnorm(n)))

> xx <- c(0:n, n:0)

> yy <- c(x, rev(y))

> plot(xx, yy, type="n", xlab="Time", ylab="Distance")
```

![plot of chunk unnamed-chunk-6](figures/knitr/unnamed-chunk-65.png) 

```

> polygon(xx, yy, col="gray")

> title("Distance Between Brownian Motions")

> ## Colored plot margins, axis labels and titles.	 You do need to be
> ## careful with these kinds of effects.	It's easy to go completely
> ## over the top and you can end up with your lunch all over the keyboard.
> ## On the other hand, my market research clients love it.
> 
> x <- c(0.00, 0.40, 0.86, 0.85, 0.69, 0.48, 0.54, 1.09, 1.11, 1.73, 2.05, 2.02)

> par(bg="lightgray")

> plot(x, type="n", axes=FALSE, ann=FALSE)
```

![plot of chunk unnamed-chunk-6](figures/knitr/unnamed-chunk-66.png) 

```

> usr <- par("usr")

> rect(usr[1], usr[3], usr[2], usr[4], col="cornsilk", border="black")

> lines(x, col="blue")

> points(x, pch=21, bg="lightcyan", cex=1.25)

> axis(2, col.axis="blue", las=1)

> axis(1, at=1:12, lab=month.abb, col.axis="blue")

> box()

> title(main= "The Level of Interest in R", font.main=4, col.main="red")

> title(xlab= "1996", col.lab="red")

> ## A filled histogram, showing how to change the font used for the
> ## main title without changing the other annotation.
> 
> par(bg="cornsilk")

> x <- rnorm(1000)

> hist(x, xlim=range(-4, 4, x), col="lavender", main="")
```

![plot of chunk unnamed-chunk-6](figures/knitr/unnamed-chunk-67.png) 

```

> title(main="1000 Normal Random Variates", font.main=3)

> ## A scatterplot matrix
> ## The good old Iris data (yet again)
> 
> pairs(iris[1:4], main="Edgar Anderson's Iris Data", font.main=4, pch=19)
```

![plot of chunk unnamed-chunk-6](figures/knitr/unnamed-chunk-68.png) 

```

> pairs(iris[1:4], main="Edgar Anderson's Iris Data", pch=21,
+       bg = c("red", "green3", "blue")[unclass(iris$Species)])
```

![plot of chunk unnamed-chunk-6](figures/knitr/unnamed-chunk-69.png) 

```

> ## Contour plotting
> ## This produces a topographic map of one of Auckland's many volcanic "peaks".
> 
> x <- 10*1:nrow(volcano)

> y <- 10*1:ncol(volcano)

> lev <- pretty(range(volcano), 10)

> par(bg = "lightcyan")

> pin <- par("pin")

> xdelta <- diff(range(x))

> ydelta <- diff(range(y))

> xscale <- pin[1]/xdelta

> yscale <- pin[2]/ydelta

> scale <- min(xscale, yscale)

> xadd <- 0.5*(pin[1]/scale - xdelta)

> yadd <- 0.5*(pin[2]/scale - ydelta)

> plot(numeric(0), numeric(0),
+      xlim = range(x)+c(-1,1)*xadd, ylim = range(y)+c(-1,1)*yadd,
+      type = "n", ann = FALSE)
```

![plot of chunk unnamed-chunk-6](figures/knitr/unnamed-chunk-610.png) 

```

> usr <- par("usr")

> rect(usr[1], usr[3], usr[2], usr[4], col="green3")

> contour(x, y, volcano, levels = lev, col="yellow", lty="solid", add=TRUE)

> box()

> title("A Topographic Map of Maunga Whau", font= 4)

> title(xlab = "Meters North", ylab = "Meters West", font= 3)

> mtext("10 Meter Contour Spacing", side=3, line=0.35, outer=FALSE,
+       at = mean(par("usr")[1:2]), cex=0.7, font=3)

> ## Conditioning plots
> 
> par(bg="cornsilk")

> coplot(lat ~ long | depth, data = quakes, pch = 21, bg = "green3")
```

![plot of chunk unnamed-chunk-6](figures/knitr/unnamed-chunk-611.png) 

```

> par(opar)
```


And here's one about generalized linear models (glm):

```r
demo(lm.glm)
```

```


	demo(lm.glm)
	---- ~~~~~~

> ### Examples from: "An Introduction to Statistical Modelling"
> ###			By Annette Dobson
> ###
> ### == with some additions ==
> 
> #  Copyright (C) 1997-2008 The R Core Team
> 
> require(stats); require(graphics)

> ## Plant Weight Data (Page 9)
> ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)

> trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)

> group <- gl(2,10, labels=c("Ctl","Trt"))

> weight <- c(ctl,trt)

> anova  (lm(weight~group))
Analysis of Variance Table

Response: weight
          Df Sum Sq Mean Sq F value Pr(>F)
group      1   0.69   0.688    1.42   0.25
Residuals 18   8.73   0.485               

> summary(lm(weight~group -1))

Call:
lm(formula = weight ~ group - 1)

Residuals:
    Min      1Q  Median      3Q     Max 
-1.0710 -0.4937  0.0685  0.2462  1.3690 

Coefficients:
         Estimate Std. Error t value Pr(>|t|)    
groupCtl     5.03       0.22    22.9  9.5e-15 ***
groupTrt     4.66       0.22    21.2  3.6e-14 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.696 on 18 degrees of freedom
Multiple R-squared:  0.982,	Adjusted R-squared:  0.98 
F-statistic:  485 on 2 and 18 DF,  p-value: <2e-16


> ## Birth Weight Data (Page 14)
> age <- c(40, 38, 40, 35, 36, 37, 41, 40, 37, 38, 40, 38,
+ 	 40, 36, 40, 38, 42, 39, 40, 37, 36, 38, 39, 40)

> birthw <- c(2968, 2795, 3163, 2925, 2625, 2847, 3292, 3473, 2628, 3176,
+ 	    3421, 2975, 3317, 2729, 2935, 2754, 3210, 2817, 3126, 2539,
+ 	    2412, 2991, 2875, 3231)

> sex <- gl(2,12, labels=c("M","F"))

> plot(age, birthw, col=as.numeric(sex), pch=3*as.numeric(sex),
+      main="Dobson's Birth Weight Data")
```

![plot of chunk unnamed-chunk-7](figures/knitr/unnamed-chunk-71.png) 

```

> lines(lowess(age[sex=='M'], birthw[sex=='M']), col=1)

> lines(lowess(age[sex=='F'], birthw[sex=='F']), col=2)

> legend("topleft", levels(sex), col=1:2, pch=3*(1:2), lty=1, bty="n")

> summary(l1 <- lm(birthw ~ sex + age),    correlation=TRUE)

Call:
lm(formula = birthw ~ sex + age)

Residuals:
   Min     1Q Median     3Q    Max 
-257.5 -125.3  -58.4  169.0  304.0 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  -1610.3      786.1   -2.05    0.053 .  
sexF          -163.0       72.8   -2.24    0.036 *  
age            120.9       20.5    5.91  7.3e-06 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 177 on 21 degrees of freedom
Multiple R-squared:  0.64,	Adjusted R-squared:  0.606 
F-statistic: 18.7 on 2 and 21 DF,  p-value: 2.19e-05

Correlation of Coefficients:
     (Intercept) sexF 
sexF  0.07            
age  -1.00       -0.12


> summary(l0 <- lm(birthw ~ sex + age -1), correlation=TRUE)

Call:
lm(formula = birthw ~ sex + age - 1)

Residuals:
   Min     1Q Median     3Q    Max 
-257.5 -125.3  -58.4  169.0  304.0 

Coefficients:
     Estimate Std. Error t value Pr(>|t|)    
sexM  -1610.3      786.1   -2.05    0.053 .  
sexF  -1773.3      794.6   -2.23    0.037 *  
age     120.9       20.5    5.91  7.3e-06 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 177 on 21 degrees of freedom
Multiple R-squared:  0.997,	Adjusted R-squared:  0.996 
F-statistic: 2.26e+03 on 3 and 21 DF,  p-value: <2e-16

Correlation of Coefficients:
     sexM  sexF 
sexF  1.00      
age  -1.00 -1.00


> anova(l1,l0)
Analysis of Variance Table

Model 1: birthw ~ sex + age
Model 2: birthw ~ sex + age - 1
  Res.Df    RSS Df Sum of Sq F Pr(>F)
1     21 658771                      
2     21 658771  0 -4.19e-09         

> summary(li <- lm(birthw ~ sex + sex:age -1), correlation=TRUE)

Call:
lm(formula = birthw ~ sex + sex:age - 1)

Residuals:
   Min     1Q Median     3Q    Max 
-246.7 -138.1  -39.1  176.6  274.3 

Coefficients:
         Estimate Std. Error t value Pr(>|t|)    
sexM        -1269       1115   -1.14  0.26849    
sexF        -2142       1164   -1.84  0.08057 .  
sexM:age      112         29    3.86  0.00099 ***
sexF:age      130         30    4.35  0.00031 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 181 on 20 degrees of freedom
Multiple R-squared:  0.997,	Adjusted R-squared:  0.996 
F-statistic: 1.63e+03 on 4 and 20 DF,  p-value: <2e-16

Correlation of Coefficients:
         sexM  sexF  sexM:age
sexF      0.00               
sexM:age -1.00  0.00         
sexF:age  0.00 -1.00  0.00   


> anova(li,l0)
Analysis of Variance Table

Model 1: birthw ~ sex + sex:age - 1
Model 2: birthw ~ sex + age - 1
  Res.Df    RSS Df Sum of Sq    F Pr(>F)
1     20 652425                         
2     21 658771 -1     -6346 0.19   0.66

> summary(zi <- glm(birthw ~ sex + age, family=gaussian()))

Call:
glm(formula = birthw ~ sex + age, family = gaussian())

Deviance Residuals: 
   Min      1Q  Median      3Q     Max  
-257.5  -125.3   -58.4   169.0   304.0  

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  -1610.3      786.1   -2.05    0.053 .  
sexF          -163.0       72.8   -2.24    0.036 *  
age            120.9       20.5    5.91  7.3e-06 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for gaussian family taken to be 31370)

    Null deviance: 1829873  on 23  degrees of freedom
Residual deviance:  658771  on 21  degrees of freedom
AIC: 321.4

Number of Fisher Scoring iterations: 2


> summary(z0 <- glm(birthw ~ sex + age - 1, family=gaussian()))

Call:
glm(formula = birthw ~ sex + age - 1, family = gaussian())

Deviance Residuals: 
   Min      1Q  Median      3Q     Max  
-257.5  -125.3   -58.4   169.0   304.0  

Coefficients:
     Estimate Std. Error t value Pr(>|t|)    
sexM  -1610.3      786.1   -2.05    0.053 .  
sexF  -1773.3      794.6   -2.23    0.037 *  
age     120.9       20.5    5.91  7.3e-06 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for gaussian family taken to be 31370)

    Null deviance: 213198964  on 24  degrees of freedom
Residual deviance:    658771  on 21  degrees of freedom
AIC: 321.4

Number of Fisher Scoring iterations: 2


> anova(zi, z0)
Analysis of Deviance Table

Model 1: birthw ~ sex + age
Model 2: birthw ~ sex + age - 1
  Resid. Df Resid. Dev Df Deviance
1        21     658771            
2        21     658771  0 5.82e-10

> summary(z.o4 <- update(z0, subset = -4))

Call:
glm(formula = birthw ~ sex + age - 1, family = gaussian(), subset = -4)

Deviance Residuals: 
   Min      1Q  Median      3Q     Max  
-253.9  -129.5   -53.5   165.0   251.1  

Coefficients:
     Estimate Std. Error t value Pr(>|t|)    
sexM  -2318.0      801.6   -2.89   0.0090 ** 
sexF  -2455.4      803.8   -3.05   0.0063 ** 
age     138.5       20.7    6.69  1.6e-06 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for gaussian family taken to be 26925)

    Null deviance: 204643339  on 23  degrees of freedom
Residual deviance:    538508  on 20  degrees of freedom
AIC: 304.7

Number of Fisher Scoring iterations: 2


> summary(zz <- update(z0, birthw ~ sex+age-1 + sex:age))

Call:
glm(formula = birthw ~ sex + age + sex:age - 1, family = gaussian())

Deviance Residuals: 
   Min      1Q  Median      3Q     Max  
-246.7  -138.1   -39.1   176.6   274.3  

Coefficients:
         Estimate Std. Error t value Pr(>|t|)    
sexM      -1268.7     1114.6   -1.14  0.26849    
sexF      -2141.7     1163.6   -1.84  0.08057 .  
age         112.0       29.0    3.86  0.00099 ***
sexF:age     18.4       41.8    0.44  0.66389    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for gaussian family taken to be 32621)

    Null deviance: 213198964  on 24  degrees of freedom
Residual deviance:    652425  on 20  degrees of freedom
AIC: 323.2

Number of Fisher Scoring iterations: 2


> anova(z0,zz)
Analysis of Deviance Table

Model 1: birthw ~ sex + age - 1
Model 2: birthw ~ sex + age + sex:age - 1
  Resid. Df Resid. Dev Df Deviance
1        21     658771            
2        20     652425  1     6346

> ## Poisson Regression Data (Page 42)
> x <- c(-1,-1,0,0,0,0,1,1,1)

> y <- c(2,3,6,7,8,9,10,12,15)

> summary(glm(y~x, family=poisson(link="identity")))

Call:
glm(formula = y ~ x, family = poisson(link = "identity"))

Deviance Residuals: 
   Min      1Q  Median      3Q     Max  
-0.702  -0.338  -0.111   0.296   0.718  

Coefficients:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)    7.452      0.884    8.43  < 2e-16 ***
x              4.935      1.089    4.53  5.9e-06 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 18.4206  on 8  degrees of freedom
Residual deviance:  1.8947  on 7  degrees of freedom
AIC: 40.01

Number of Fisher Scoring iterations: 3


> ## Calorie Data (Page 45)
> calorie <- data.frame(
+     carb = c(33,40,37,27,30,43,34,48,30,38,
+ 	     50,51,30,36,41,42,46,24,35,37),
+     age	 = c(33,47,49,35,46,52,62,23,32,42,
+ 	     31,61,63,40,50,64,56,61,48,28),
+     wgt	 = c(100, 92,135,144,140,101, 95,101, 98,105,
+ 	     108, 85,130,127,109,107,117,100,118,102),
+     prot = c(14,15,18,12,15,15,14,17,15,14,
+ 	     17,19,19,20,15,16,18,13,18,14))

> summary(lmcal <- lm(carb~age+wgt+prot, data= calorie))

Call:
lm(formula = carb ~ age + wgt + prot, data = calorie)

Residuals:
   Min     1Q Median     3Q    Max 
-10.34  -4.82   0.99   3.85   7.91 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)   
(Intercept)  36.9601    13.0713    2.83   0.0121 * 
age          -0.1137     0.1093   -1.04   0.3139   
wgt          -0.2280     0.0833   -2.74   0.0146 * 
prot          1.9577     0.6349    3.08   0.0071 **
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 5.96 on 16 degrees of freedom
Multiple R-squared:  0.481,	Adjusted R-squared:  0.383 
F-statistic: 4.93 on 3 and 16 DF,  p-value: 0.013


> ## Extended Plant Data (Page 59)
> ctl <-	c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)

> trtA <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)

> trtB <- c(6.31,5.12,5.54,5.50,5.37,5.29,4.92,6.15,5.80,5.26)

> group <- gl(3, length(ctl), labels=c("Ctl","A","B"))

> weight <- c(ctl,trtA,trtB)

> anova(lmwg <- lm(weight~group))
Analysis of Variance Table

Response: weight
          Df Sum Sq Mean Sq F value Pr(>F)  
group      2   3.77   1.883    4.85  0.016 *
Residuals 27  10.49   0.389                 
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

> summary(lmwg)

Call:
lm(formula = weight ~ group)

Residuals:
   Min     1Q Median     3Q    Max 
-1.071 -0.418 -0.006  0.263  1.369 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)    5.032      0.197   25.53   <2e-16 ***
groupA        -0.371      0.279   -1.33    0.194    
groupB         0.494      0.279    1.77    0.088 .  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.623 on 27 degrees of freedom
Multiple R-squared:  0.264,	Adjusted R-squared:  0.21 
F-statistic: 4.85 on 2 and 27 DF,  p-value: 0.0159


> coef(lmwg)
(Intercept)      groupA      groupB 
      5.032      -0.371       0.494 

> coef(summary(lmwg))#- incl.  std.err,  t- and P- values.
            Estimate Std. Error t value  Pr(>|t|)
(Intercept)    5.032     0.1971  25.527 1.937e-20
groupA        -0.371     0.2788  -1.331 1.944e-01
groupB         0.494     0.2788   1.772 8.768e-02

> ## Fictitious Anova Data (Page 64)
> y <- c(6.8,6.6,5.3,6.1,7.5,7.4,7.2,6.5,7.8,9.1,8.8,9.1)

> a <- gl(3,4)

> b <- gl(2,2, length(a))

> anova(z <- lm(y~a*b))
Analysis of Variance Table

Response: y
          Df Sum Sq Mean Sq F value Pr(>F)   
a          2  12.74    6.37   25.82 0.0011 **
b          1   0.40    0.40    1.64 0.2482   
a:b        2   1.21    0.60    2.45 0.1672   
Residuals  6   1.48    0.25                  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

> ## Achievement Scores (Page 70)
> y <- c(6,4,5,3,4,3,6, 8,9,7,9,8,5,7, 6,7,7,7,8,5,7)

> x <- c(3,1,3,1,2,1,4, 4,5,5,4,3,1,2, 3,2,2,3,4,1,4)

> m <- gl(3,7)

> anova(z <- lm(y~x+m))
Analysis of Variance Table

Response: y
          Df Sum Sq Mean Sq F value  Pr(>F)    
x          1   36.6    36.6    60.4 5.4e-07 ***
m          2   16.9     8.5    14.0 0.00026 ***
Residuals 17   10.3     0.6                    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

> ## Beetle Data (Page 78)
> dose <- c(1.6907, 1.7242, 1.7552, 1.7842, 1.8113, 1.8369, 1.861, 1.8839)

> x <- c( 6, 13, 18, 28, 52, 53, 61, 60)

> n <- c(59, 60, 62, 56, 63, 59, 62, 60)

> dead <- cbind(x, n-x)

> summary(     glm(dead ~ dose, family=binomial(link=logit)))

Call:
glm(formula = dead ~ dose, family = binomial(link = logit))

Deviance Residuals: 
   Min      1Q  Median      3Q     Max  
-1.594  -0.394   0.833   1.259   1.594  

Coefficients:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)   -60.72       5.18   -11.7   <2e-16 ***
dose           34.27       2.91    11.8   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 284.202  on 7  degrees of freedom
Residual deviance:  11.232  on 6  degrees of freedom
AIC: 41.43

Number of Fisher Scoring iterations: 4


> summary(     glm(dead ~ dose, family=binomial(link=probit)))

Call:
glm(formula = dead ~ dose, family = binomial(link = probit))

Deviance Residuals: 
   Min      1Q  Median      3Q     Max  
 -1.57   -0.47    0.75    1.06    1.34  

Coefficients:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)   -34.94       2.65   -13.2   <2e-16 ***
dose           19.73       1.49    13.3   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 284.20  on 7  degrees of freedom
Residual deviance:  10.12  on 6  degrees of freedom
AIC: 40.32

Number of Fisher Scoring iterations: 4


> summary(z <- glm(dead ~ dose, family=binomial(link=cloglog)))

Call:
glm(formula = dead ~ dose, family = binomial(link = cloglog))

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-0.8033  -0.5513   0.0309   0.3832   1.2888  

Coefficients:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)   -39.57       3.24   -12.2   <2e-16 ***
dose           22.04       1.80    12.2   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 284.2024  on 7  degrees of freedom
Residual deviance:   3.4464  on 6  degrees of freedom
AIC: 33.64

Number of Fisher Scoring iterations: 4


> anova(z, update(z, dead ~ dose -1))
Analysis of Deviance Table

Model 1: dead ~ dose
Model 2: dead ~ dose - 1
  Resid. Df Resid. Dev Df Deviance
1         6        3.4            
2         7      285.2 -1     -282

> ## Anther Data (Page 84)
> ## Note that the proportions below are not exactly
> ## in accord with the sample sizes quoted below.
> ## In particular, the value 0.555 does not seem sensible.
> ##	[MM: huh?  round(round(n*p)/n, 3) looks almost exactly like "p" !]
> n <- c(102,  99,   108,	 76,   81,   90)

> p <- c(0.539,0.525,0.528,0.724,0.617,0.555)

> x <- round(n*p)

> ## x <- n*p
> y <- cbind(x,n-x)

> f <- rep(c(40,150,350),2)

> (g <- gl(2,3))
[1] 1 1 1 2 2 2
Levels: 1 2

> summary(glm(y ~ g*f, family=binomial(link="logit")))

Call:
glm(formula = y ~ g * f, family = binomial(link = "logit"))

Deviance Residuals: 
      1        2        3        4        5        6  
 0.0827  -0.1300   0.0441   0.4232  -0.6008   0.1952  

Coefficients:
             Estimate Std. Error z value Pr(>|z|)  
(Intercept)  0.145672   0.197545    0.74    0.461  
g2           0.796314   0.312505    2.55    0.011 *
f           -0.000123   0.000878   -0.14    0.889  
g2:f        -0.002049   0.001348   -1.52    0.129  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 10.45197  on 5  degrees of freedom
Residual deviance:  0.60387  on 2  degrees of freedom
AIC: 38.17

Number of Fisher Scoring iterations: 3


> summary(glm(y ~ g + f, family=binomial(link="logit")))

Call:
glm(formula = y ~ g + f, family = binomial(link = "logit"))

Deviance Residuals: 
     1       2       3       4       5       6  
-0.551  -0.278   0.797   1.156  -0.369  -0.658  

Coefficients:
             Estimate Std. Error z value Pr(>|z|)  
(Intercept)  0.306643   0.167629    1.83    0.067 .
g2           0.405554   0.174560    2.32    0.020 *
f           -0.000997   0.000665   -1.50    0.134  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 10.4520  on 5  degrees of freedom
Residual deviance:  2.9218  on 3  degrees of freedom
AIC: 38.49

Number of Fisher Scoring iterations: 3


> ## The "final model"
> summary(glm.p84 <- glm(y~g,  family=binomial(link="logit")))

Call:
glm(formula = y ~ g, family = binomial(link = "logit"))

Deviance Residuals: 
      1        2        3        4        5        6  
 0.1715  -0.1095  -0.0618   1.7721  -0.1904  -1.3969  

Coefficients:
            Estimate Std. Error z value Pr(>|z|)  
(Intercept)    0.123      0.114    1.08    0.280  
g2             0.399      0.174    2.29    0.022 *
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 10.452  on 5  degrees of freedom
Residual deviance:  5.173  on 4  degrees of freedom
AIC: 38.74

Number of Fisher Scoring iterations: 3


> op <- par(mfrow = c(2,2), oma = c(0,0,1,0))

> plot(glm.p84) # well ?
```

![plot of chunk unnamed-chunk-7](figures/knitr/unnamed-chunk-72.png) 

```

> par(op)

> ## Tumour Data (Page 92)
> counts <- c(22,2,10,16,54,115,19,33,73,11,17,28)

> type <- gl(4,3,12,labels=c("freckle","superficial","nodular","indeterminate"))

> site <- gl(3,1,12,labels=c("head/neck","trunk","extremities"))

> data.frame(counts,type,site)
   counts          type        site
1      22       freckle   head/neck
2       2       freckle       trunk
3      10       freckle extremities
4      16   superficial   head/neck
5      54   superficial       trunk
6     115   superficial extremities
7      19       nodular   head/neck
8      33       nodular       trunk
9      73       nodular extremities
10     11 indeterminate   head/neck
11     17 indeterminate       trunk
12     28 indeterminate extremities

> summary(z <- glm(counts ~ type + site, family=poisson()))

Call:
glm(formula = counts ~ type + site, family = poisson())

Deviance Residuals: 
   Min      1Q  Median      3Q     Max  
-3.045  -1.074   0.130   0.586   5.135  

Coefficients:
                  Estimate Std. Error z value Pr(>|z|)    
(Intercept)          1.754      0.204    8.60  < 2e-16 ***
typesuperficial      1.694      0.187    9.08  < 2e-16 ***
typenodular          1.302      0.193    6.73  1.7e-11 ***
typeindeterminate    0.499      0.217    2.30   0.0217 *  
sitetrunk            0.444      0.155    2.86   0.0043 ** 
siteextremities      1.201      0.138    8.68  < 2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 295.203  on 11  degrees of freedom
Residual deviance:  51.795  on  6  degrees of freedom
AIC: 122.9

Number of Fisher Scoring iterations: 5


> ## Randomized Controlled Trial (Page 93)
> counts <- c(18,17,15, 20,10,20, 25,13,12)

> outcome   <- gl(3, 1, length(counts))

> treatment <- gl(3, 3)

> summary(z <- glm(counts ~ outcome + treatment, family=poisson()))

Call:
glm(formula = counts ~ outcome + treatment, family = poisson())

Deviance Residuals: 
      1        2        3        4        5        6        7        8  
-0.6712   0.9627  -0.1696  -0.2200  -0.9555   1.0494   0.8472  -0.0917  
      9  
-0.9666  

Coefficients:
             Estimate Std. Error z value Pr(>|z|)    
(Intercept)  3.04e+00   1.71e-01   17.81   <2e-16 ***
outcome2    -4.54e-01   2.02e-01   -2.25    0.025 *  
outcome3    -2.93e-01   1.93e-01   -1.52    0.128    
treatment2   1.34e-15   2.00e-01    0.00    1.000    
treatment3   1.42e-15   2.00e-01    0.00    1.000    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 10.5814  on 8  degrees of freedom
Residual deviance:  5.1291  on 4  degrees of freedom
AIC: 56.76

Number of Fisher Scoring iterations: 4


> ## Peptic Ulcers and Blood Groups
> counts <- c(579, 4219, 911, 4578, 246, 3775, 361, 4532, 291, 5261, 396, 6598)

> group <- gl(2, 1, 12, labels=c("cases","controls"))

> blood <- gl(2, 2, 12, labels=c("A","O"))

> city  <- gl(3, 4, 12, labels=c("London","Manchester","Newcastle"))

> cbind(group, blood, city, counts) # gives internal codes for the factors
      group blood city counts
 [1,]     1     1    1    579
 [2,]     2     1    1   4219
 [3,]     1     2    1    911
 [4,]     2     2    1   4578
 [5,]     1     1    2    246
 [6,]     2     1    2   3775
 [7,]     1     2    2    361
 [8,]     2     2    2   4532
 [9,]     1     1    3    291
[10,]     2     1    3   5261
[11,]     1     2    3    396
[12,]     2     2    3   6598

> summary(z1 <- glm(counts ~ group*(city + blood), family=poisson()))

Call:
glm(formula = counts ~ group * (city + blood), family = poisson())

Deviance Residuals: 
     1       2       3       4       5       6       7       8       9  
-0.752   3.018   0.610  -2.814   0.171  -0.434  -0.141   0.398   0.932  
    10      11      12  
-2.269  -0.774   2.065  

Coefficients:
                             Estimate Std. Error z value Pr(>|z|)    
(Intercept)                    6.3924     0.0348  183.92  < 2e-16 ***
groupcontrols                  1.9081     0.0369   51.69  < 2e-16 ***
cityManchester                -0.8980     0.0482  -18.65  < 2e-16 ***
cityNewcastle                 -0.7742     0.0461  -16.79  < 2e-16 ***
bloodO                         0.4019     0.0387   10.39  < 2e-16 ***
groupcontrols:cityManchester   0.8407     0.0505   16.64  < 2e-16 ***
groupcontrols:cityNewcastle    1.0729     0.0482   22.25  < 2e-16 ***
groupcontrols:bloodO          -0.2321     0.0404   -5.74  9.5e-09 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 26717.157  on 11  degrees of freedom
Residual deviance:    29.241  on  4  degrees of freedom
AIC: 154.3

Number of Fisher Scoring iterations: 3


> summary(z2 <- glm(counts ~ group*city + blood, family=poisson()),
+         correlation = TRUE)

Call:
glm(formula = counts ~ group * city + blood, family = poisson())

Deviance Residuals: 
     1       2       3       4       5       6       7       8       9  
-3.769   3.717   3.281  -3.442  -1.767   0.239   1.557  -0.217  -1.146  
    10      11      12  
-1.469   1.022   1.328  

Coefficients:
                             Estimate Std. Error z value Pr(>|z|)    
(Intercept)                    6.5139     0.0266   244.6   <2e-16 ***
groupcontrols                  1.7756     0.0280    63.4   <2e-16 ***
cityManchester                -0.8980     0.0482   -18.6   <2e-16 ***
cityNewcastle                 -0.7742     0.0461   -16.8   <2e-16 ***
bloodO                         0.1899     0.0113    16.8   <2e-16 ***
groupcontrols:cityManchester   0.8407     0.0505    16.6   <2e-16 ***
groupcontrols:cityNewcastle    1.0729     0.0482    22.2   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 26717.157  on 11  degrees of freedom
Residual deviance:    62.558  on  5  degrees of freedom
AIC: 185.6

Number of Fisher Scoring iterations: 4

Correlation of Coefficients:
                             (Intercept) groupcontrols cityManchester
groupcontrols                -0.90                                   
cityManchester               -0.52        0.50                       
cityNewcastle                -0.55        0.52          0.30         
bloodO                       -0.23        0.00          0.00         
groupcontrols:cityManchester  0.50       -0.55         -0.95         
groupcontrols:cityNewcastle   0.52       -0.58         -0.29         
                             cityNewcastle bloodO
groupcontrols                                    
cityManchester                                   
cityNewcastle                                    
bloodO                        0.00               
groupcontrols:cityManchester -0.29          0.00 
groupcontrols:cityNewcastle  -0.96          0.00 
                             groupcontrols:cityManchester
groupcontrols                                            
cityManchester                                           
cityNewcastle                                            
bloodO                                                   
groupcontrols:cityManchester                             
groupcontrols:cityNewcastle   0.32                       


> anova(z2, z1, test = "Chisq")
Analysis of Deviance Table

Model 1: counts ~ group * city + blood
Model 2: counts ~ group * (city + blood)
  Resid. Df Resid. Dev Df Deviance Pr(>Chi)    
1         5       62.6                         
2         4       29.2  1     33.3  7.8e-09 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```



#### Activity 1.2.3:  R as a calculator
Addition:

```r
7 + 3
```

```
[1] 10
```


Subtraction:

```r
7 - 3
```

```
[1] 4
```


Multiplication:

```r
7 * 3
```

```
[1] 21
```


Division:

```r
7 / 3
```

```
[1] 2.333
```


Integer division:

```r
7 %/% 3
```

```
[1] 2
```


Division remainder (the modulo):

```r
7 %% 3
```

```
[1] 1
```


exponentiation:

```r
exp(7)
```

```
[1] 1097
```


Natural logarithm:

```r
log(7)
```

```
[1] 1.946
```


Base 10 log:

```r
log10(1000)
```

```
[1] 3
```


Examples of common mathematical functions and constants:

```r
sqrt(16)
```

```
[1] 4
```

```r
cos(pi)
```

```
[1] -1
```


Powers:  2 to the 5th:

```r
2^5
```

```
[1] 32
```


Large and small numbers:

```r
1.7e+05
```

```
[1] 170000
```

```r
1.7e-03
```

```
[1] 0.0017
```


And there are numerous statistical functions.  For example:
The probability a standard normal random variable takes
a value of 1.96 or lower:

```r
pnorm(1.96)
```

```
[1] 0.975
```


And the probability of 4 heads in 12 fair coin flips:

```r
dbinom(4, 12, 0.5)
```

```
[1] 0.1208
```


And, best of all, it handles division by 0 gracefully :) 

```r
1 / 0
```

```
[1] Inf
```


R can also perform all the standard matrix operations:
inner and outer products, matrix multiplication, matrix
inversion, transpose, eigen vectors and values, various
decompositions, etc.  It has built-in numerical routines for
root-finding, optimization, integration, differentiation,
etc.

