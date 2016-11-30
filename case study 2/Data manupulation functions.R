#Helpful for data wrangling/manipulation

#tidyr
#reshape2
#dplyr

#helpful paper: https://www.jstatsoft.org/article/view/v040i01



#set directory
setwd("~/Desktop/R_class/case study 2")

#input path
input_path <- "/Users/suvampaul/Desktop/R_class/case study 2/data/input"



#helper functions
parse_filename <- function(stringval) {
  loc <- stringr::str_locate(stringval, "_")
  stringr::str_sub(stringval, 1, loc[, "start"] -1)
}

reshape_list <- function(data) {
  data_molten <- reshape2::melt(data, id.vars = "student_id",  variable.name = "question", value.name = "response")
}




#Data Manipulation

#read in data
fi <- list.files(input_path,full.names=T)
dat <- lapply(fi,function(i) {read.csv(i, stringsAsFactors = FALSE)})

#name the list components
basename(fi)
names(dat) <- parse_filename(basename(fi))

#reshape the data
dat2 <- lapply(dat, reshape_list)


#make list of data frames into a single data frame for analysis
data <- plyr::ldply(dat2, stringsAsFactors = FALSE)
data$.id <- NULL

#output path

output_path <- "/Users/suvampaul/Desktop/R_class/case study 2/data/output/"
lapply(names(dat2), function(x) write.csv(dat2[[x]], paste0(output_path,x,'.csv'), row.names = FALSE))




#data manipulation functions
read_in_data <- function(inputpath) {
  fi <- list.files(input_path,full.names=T)
  dat <- lapply(fi,function(i) {read.csv(i, stringsAsFactors = FALSE)})
  dat
}


reshape_listdat <- function(input_path, listdat) {
  fi <- list.files(input_path,full.names=T)
  dat <- lapply(listdat, reshape_list)
  names(dat) <- parse_filename(basename(fi))
  dat
}


write_data <- function(listdata) {
  lapply(names(listdata), function(x) write.csv(listdata[[x]], paste0(output_path,x,'.csv'), row.names = FALSE))
}


read_files_in_directory <- function(outputpath) {
  fi <- list.files(outputpath,full.names=T)
  plyr::ldply(fi, read.csv, stringsAsFactors = FALSE)
}