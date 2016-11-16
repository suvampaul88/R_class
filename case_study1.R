#read in data

library(stringr)
library(tibble)

setwd("~/Desktop")
data <- read.csv("data.csv")

as_tibble(data)


#let's problem solve
loc <- str_locate(data$question, "_")
str_sub(data$question, 1, loc[, "start"] -1)



loc2 <- str_locate_all(data$question, "_")
str_sub(data$question,  unlist((lapply(loc2, "[[", 1))) + 1, unlist((lapply(loc2, "[[", 2))) - 1)


#let's create functions
parse_case <- function(stringval) {
  loc <- str_locate(stringval, "_")
  str_sub(stringval, 1, loc[, "start"] -1)
}


parse_skills <- function(stringval) {
  loc <- str_locate_all(stringval, "_")
  str_sub(stringval, unlist((lapply(loc, "[[", 1))) + 1, unlist((lapply(loc, "[[", 2))) - 1)
}

parse_varname <- function(stringval) {
  loc <- str_locate_all(stringval, "_")
  str_sub(stringval, unlist((lapply(loc, "[[", 2))) + 1)
}



#let's wrangle
data$case <- parse_case(data$question)
data$skills <- parse_skills(data$question)
data$varname <- parse_varname(data$question)