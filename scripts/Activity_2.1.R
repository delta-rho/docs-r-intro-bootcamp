###########################################################
### Activity 2.1
### DataDR and Trelliscope example with the adult 
### dataset (census data)
###########################################################

## Activity 2.1.1
library(datadr)
library(trelliscope)

# look at the dataset
str(adult)


## Activity 2.1.2
# express data as a local "distributed data frame"
adultDdf <- ddf(adult, update=TRUE)

adultDdf


## Activity 2.1.3
# look at data summary statistics
summary(adultDdf)


## Activity 2.1.4
# divide the ddf by the variable "education"
byEducation <- divide(adultDdf, by = "education", update=TRUE)

# look at division keys
getKeys(byEducation)


##Activity 2.1.5
# look at subsets of the ddf
head(byEducation[["education=Bachelors"]][[2]])


## Activity 2.1.6
# compute mean and standard dev of hoursperweek for each subset and recombine into one table
edMeanAndVar <- recombine(byEducation,
   apply = function(x) {
      list(
         mean=mean(x$age, na.rm=TRUE), 
         stdev=sqrt(var(x$age, na.rm=TRUE))
      )
   },
   combine = combRbind()
)

# look at results 
edMeanAndVar
   

## Activity 2.1.7
# divide by work class
byWorkClass <- divide(adultDdf, by="workclass")

getKeys(byWorkClass)


## Activity 2.1.8
# panel function: education vs hours per week, conditioned on income category
pf1 <- function(x)
   xyplot(hoursperweek ~ educationnum | income, 
      data = x,
      xlab="Years of Education",
      ylab="Hours per Week"
   )
   
# test it on one data division
pf1(byWorkClass[["workclass=Federal-gov"]][[2]])


## Activity 2.1.9
# cognostics function
cf <- function(x) {
   list(
      fracAbove50K = cog(mean(x$incomebin), desc = "fraction above $50K income"),
      minEducation = cog(min(x$educationnum), desc = "min number of education years"),
      meanEducation = cog(mean(x$educationnum), desc = "mean number of education years"),
      maxEducation = cog(max(x$educationnum), desc = "max number of education years"),
      minnHoursPerWeek = cog(min(x$hoursperweek), desc="min hours per week worked"),
      meanHoursPerWeek = cog(mean(x$hoursperweek), desc="mean hours per week worked"),
      maxHoursPerWeek = cog(max(x$hoursperweek), desc="max hours per week worked")
   )
}


## Activity 2.1.10
cf(byWorkClass[[1]][[2]])
 

## Activity 2.1.11
# create visualization database
vdbConn("vdb_census", autoYes = TRUE)
   
# create display with this panel and cognostics functions
makeDisplay(byWorkClass,
   name = "hours_and_education_by_workclass",
   desc = "hours and education by workclass",
   panelFn = pf1, cogFn = cf,
   width = 400, height = 400
)

# view the display
myport <- Sys.getenv("TR_PORT")
view(port=myport)


## Activity 2.1.12 
# make boxplots of education divided by below and above $50K
pf2 <- function(x)
   boxplot(educationnum ~ income, data = x,
      xlab="Income", ylab="Education")
pf2(byWorkClass[[1]][[2]])

# a second type of plot on the same data
makeDisplay(byWorkClass,
   name = "education_boxplot_by_workclass",
   desc = "education boxplot by workclass",
   panelFn = pf2, cogFn = cf,
   width = 400, height = 400
)

# launch viewer
view(port=myport)
