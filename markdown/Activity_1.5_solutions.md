### Activity 1.5: Exercise Solutions ###

Solutions for Exercises in Activity 1.5
  
#### Exercise 1.5.1: A simple linear regression model ####
  
1) Look at the Old Faithful geyser data in Yellowstone
National Park.  It's the `faithful` dataset available in
the base R distribution.  Use help(faithful) or `?faithful`
to see its documentation,

2) Plot the waiting time to the next eruptions vs. the
duration of the eruption,

3) Fit a simple linear regression model to predict waiting
time from the eruption duration,

4) Overlay the fitted model on the plot with a red line,

#### Solution ####

Look at the documentation.

```r
?faithful
```


Plot the data.

```r
with(faithful, plot(eruptions, waiting))
```

![plot of chunk unnamed-chunk-2](figures/knitr/unnamed-chunk-2.png) 


Fit the simple linear regression model and overlay a regression line, make it thick with the `lwd`.
(line width) argument.

```r
slrModel <- lm(waiting ~ eruptions, data = faithful)
```



```r
plot(slrModel, col = "Red", lwd = 5)
```

![plot of chunk unnamed-chunk-4](figures/knitr/unnamed-chunk-41.png) ![plot of chunk unnamed-chunk-4](figures/knitr/unnamed-chunk-42.png) ![plot of chunk unnamed-chunk-4](figures/knitr/unnamed-chunk-43.png) ![plot of chunk unnamed-chunk-4](figures/knitr/unnamed-chunk-44.png) 


Shut down the graph.

```r
dev.off()
```

```
null device 
          1 
```


#### Exercise 1.5.2: Trellis plots ####
1) Attach the quakes data that comes with R. Look at the
columns using `head()` or `str()`.

2) Use `xyplot` to plot lat vs. long for the location of the
earthquakes. Label the axes and the main graphs
using the following command to bin the depth variable into
9 bins:

```r
depthbin <- equal.count(quakes$depth, number = 9, overlap = 0)
```

Make sure you have loaded the lattice package via:
`library(lattice)`.

3) Now use `xyplot()` to plot lat,long for each depthbin of
the earthquake to create a set of graphs in a trellis
display.

#### Solution ####

Attach quakes for convenience in accessing its columns:

```r
attach(quakes)
```


Check out the data:

```r
head(quakes)
```

```
     lat  long depth mag stations
1 -20.42 181.6   562 4.8       41
2 -20.62 181.0   650 4.2       15
3 -26.00 184.1    42 5.4       43
4 -17.97 181.7   626 4.1       19
5 -20.42 182.0   649 4.0       11
6 -19.68 184.3   195 4.0       12
```

```r
str(quakes)
```

```
'data.frame':	1000 obs. of  5 variables:
 $ lat     : num  -20.4 -20.6 -26 -18 -20.4 ...
 $ long    : num  182 181 184 182 182 ...
 $ depth   : int  562 650 42 626 649 195 82 194 211 622 ...
 $ mag     : num  4.8 4.2 5.4 4.1 4 4 4.8 4.4 4.7 4.3 ...
 $ stations: int  41 15 43 19 11 12 43 15 35 19 ...
```


Create the depth binning variable:

```r
library(lattice)
depth_bin <- equal.count(quakes$depth, number = 9, overlap = 0)
```


Produce the plot:

```r
xyplot(lat ~long | depth_bin,
main = "Earthquakes in the Pacific",
xlab = "longitude", ylab = "latitude")
```

![plot of chunk unnamed-chunk-9](figures/knitr/unnamed-chunk-9.png) 


Detach the quakes data frame:

```r
detach(quakes)
```



