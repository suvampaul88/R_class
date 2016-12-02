#Install packages using install.packages("package name"), i.e. install.packages("stringr")

library(stringr)
library(tibble)

#read in data
setwd("~/Desktop/R_class")
data <- read.csv("data.csv")

as_tibble(data)


#let's problem solve

#get var name before the first underscore
loc <- str_locate(data$question, "_")
str_sub(data$question, 1, loc[, "start"] -1)


#get var name that's between two underscores
loc2 <- str_locate_all(data$question, "_")
str_sub(data$question,  unlist((lapply(loc2, "[[", 1))) + 1, unlist((lapply(loc2, "[[", 2))) - 1)


#task: get the cmt in bkpns_comm_orgtm_intro_cmt by itself

library(stringr)

var <- c("back_comm_sp","bkpns_comm_orgtm_intro_cmt")
loc2 <- str_locate_all(var, "_")
loc2 # this is a list of matrices with positin of each _ in the var vector

#I need to get the last place where _ start to pull cmt out, and want to return NA if there is no lats place
lapply(loc2, get_last_element)
unlist((lapply(loc2, get_last_element)))
unlist((lapply(loc2, "[[", 4)))

as.numeric(str_detect(var, "cmt"))

is_comment <- function(stringval) {
  stringr::str_detect(stringval, "cmt")
  
}

is_comment(var)

a <- matrix(c(4,5,6,6,21,3,4,5,3), ncol = 3, nrow = 3)
length(a)
a[length(a)]
a[length(a)-1]

get_last_element <- function(a_matrix) {
  a_matrix[length(a_matrix)]
}

get_last_element(a)
  
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