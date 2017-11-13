#######################
#### Read JSON File####
#######################

## This file will create one sample dataframe for review data

# clear memory
rm(list = ls())

# load packages
library(jsonlite)
library(lubridate)
library(dplyr)
library(tidyr)
library(tidytext)
library(stringr)
library(ggplot2)
library(ggraph)
library(widyr)

# load the original data
setwd("~/Desktop/yelp data challenge/Yelp data")
txt = readLines("raw_data/review.json")
print("original review data loaded")

# number of chunks for initial processing
n_chunk = 50

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
# initial text analysis

# filter out Chinese restaurants
review_chinese_restaurants <- df_review%>%
  filter(str_detect(text, "Chinese"))

# tidy text
review_Chinese_word <- review_chinese_restaurants%>%
  group_by(user_id)%>%
  mutate(linenumber = row_number())%>%
  unnest_tokens(word, text)%>%
  anti_join(stop_words)

# delete unused columns
review_Chinese_word <- review_Chinese_word%>%
  ungroup()%>%
  select(user_id,linenumber,word,stars)
  
# tokenizing by one gram
overall_word_freq <- review_Chinese_word%>%
  count(word,sort=TRUE)

overall_word_freq%>%
  filter(n >300)%>%
  mutate(word = reorder(word, n))%>%
  ggplot(aes(word, n, fill=(desc(n))))+
  geom_col() +
  xlab(NULL) +
  labs(title="Overall Word Frequency")+
  theme(plot.title = element_text(hjust = 0.5))+
  coord_flip()

# Tokenizing by n-gram
review_Chinese_bigrams <- review_chinese_restaurants %>%
  group_by(user_id)%>%
  mutate(linenumber = row_number())%>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)

# delete unused columns
review_Chinese_bigrams <- review_Chinese_bigrams%>%
  ungroup()%>%
  select(user_id,linenumber,bigram,stars)


  