#######################
#### Read JSON File####
#######################

## This file will create one dataframe for review data

# clear memory
rm(list = ls())

# load packages
library(jsonlite)
library(lubridate)

# load the original data
setwd("~/Desktop/yelp data challenge/Yelp data")
txt = readLines("raw_data/review.json")
print("original review data loaded")

# number of chunks for initial processing
n_chunk = 1000

# number of lines to read per chunk except the last one
n_lines = round(length(txt)/n_chunk)

# current chunk of data
c_chunk = txt[1:n_lines]


################################################
# process the first chunk of data
data_chunk = lapply(c_chunk, fromJSON)

# create col names for the dataframe
cnames = names(data_chunk[[1]])

# function to retrieve review information
retrieve_r_info = function(cname){
  rr = function(row_review){
    if(is.null(row_review[[cname]])){
      NA
    } else row_review[[cname]]
  }
  return(sapply(data_chunk, rr))
}

# create the data frame for review data
df_review = data.frame(retrieve_r_info(cnames[1]), stringsAsFactors = F)
for (i in 2:length(cnames)){
  information = retrieve_r_info(cnames[i])
  df_review = data.frame(df_review, information, stringsAsFactors = F)
}
colnames(df_review) = cnames
rm("information")
print("chunk 1 processing finished")


################################################
## process the rest of the data
for (i in 2:n_chunk){
  
  # load data
  if (i < n_chunk){
    c_chunk = txt[seq(from = (i-1)*n_lines+1, to = i*n_lines)]
  } else{
    c_chunk = txt[seq(from = (i-1)*n_lines+1, to = length(txt))]
  }
  data_chunk = lapply(c_chunk, fromJSON)
  
  # data frame for review data
  df_review_temp = data.frame(retrieve_r_info(cnames[1]), stringsAsFactors = F)
  for (j in 2:length(cnames)){
    information = retrieve_r_info(cnames[j])
    df_review_temp = data.frame(df_review_temp, information,
                                stringsAsFactors = F)
  }
  colnames(df_review_temp) = cnames
  df_review = rbind(df_review, df_review_temp)
  rm(list = c("df_review_temp", "information"))
  print(paste("chunk", i, "processing finished"))
}
df_review$date = ymd(df_review$date)

rm(list = c("c_chunk", "data_chunk", "i", "j"))
print("dataframe for review data created")
save(df_review, file = "rdata/review.Rdata")
print("dataframe for review data saved to an Rdata file")