#get the median and mean of each column in mtcars

data(mtcars)
names(mtcars)
str(mtcars)


#using a function

median_func <- function(x) {
  out <- vector(mode = "double", length = length(x))
  for (i in seq_along(x)) {
    out[i] <- median(x[[i]])
  }
  out
}


median_vals <- median_func(mtcars)


mean_func <- function(x) {
  out <- vector(mode = "double", length = length(x))
  for (i in seq_along(x)) {
    out[i] <- mean(x[[i]])
  }
  out
}


mean_vals <- median_func(mtcars)


element_func <- function(x, f) {
  out <- vector(mode = "double", length = length(x))
  for (i in seq_along(x)) {
    out[i] <- f(x[[i]])
  }
  out
}

median_vals1 <- element_func(mtcars, median)
mean_vals1 <- element_func(mtcars, mean)

#using functionals
sapply(mtcars, median)
sapply(mtcars, mean)

#using map functions from the purrr package
library(purrr)
map_dbl(mtcars, median)
map_dbl(mtcars, mean)