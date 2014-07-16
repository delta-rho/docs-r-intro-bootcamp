

dir(pattern = "some_fake")



d <- read.csv("some_fake_data.csv")



str(d)



selIndicator <- d[,"beta"] < 7



dSubset <- d[selIndicator, c("alpha", "gamma")]



write.csv(dSubset, file = "more_fake_data.csv",
          row.names = FALSE)



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



f(3, 5)



f(1:3, 7:9, type = "divide")


