#######################
#### Read JSON File####
#######################

## use sample review data to conduct initial text analysis

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
library(wordcloud)

# load the original data
setwd("~/Desktop/yelp github/Yelp")
txt = readLines("raw_data/review.json")
print("original review data loaded")

# number of chunks for initial processing
n_chunk = 30

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

# add new customized stop word
my_stop_word <- data.frame(word=character(5))
my_stop_word$word <- c("chinese","food","restaurant","chinese food","chinese restaurant")

# tokenizing by one gram
review_Chinese_word <- review_chinese_restaurants%>%
  group_by(user_id)%>%
  mutate(linenumber = row_number())%>%
  unnest_tokens(word, text)%>%
  anti_join(stop_words)

# delete unused columns
review_Chinese_word <- review_Chinese_word%>%
  ungroup()%>%
  select(user_id,linenumber,word,stars)
  
# visualization
overall_word_freq <- review_Chinese_word%>%
  count(word,sort=TRUE)

overall_word_freq%>%
  anti_join(my_stop_word)%>%
  filter(n >500)%>%
  mutate(word = reorder(word, n))%>%
  ggplot(aes(word, n, fill=(desc(n))))+
  geom_col() +
  xlab(NULL) +
  labs(title="Overall Word Frequency")+
  theme(plot.title = element_text(hjust = 0.5))+
  coord_flip()

# word cloud
overall_word_freq %>%
  anti_join(my_stop_word)%>%
  with(wordcloud(word, n, max.words = 100,colors=n))

# Tokenizing by n-gram
review_Chinese_bigrams <- review_chinese_restaurants %>%
  group_by(user_id)%>%
  mutate(linenumber = row_number())%>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)

# delete unused columns
review_Chinese_bigrams <- review_Chinese_bigrams%>%
  ungroup()%>%
  select(user_id,linenumber,bigram,stars)

# bigrams frequency
review_Chinese_bigrams <- review_Chinese_bigrams%>%
  count(bigram, sort = TRUE)

bigrams_seperated <- review_Chinese_bigrams%>%
  separate(bigram, c("word1", "word2"), sep = " ")
 
bigrams_filtered <- bigrams_seperated %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word)

bigrams_united <- bigrams_filtered %>%
  unite(bigram, word1, word2, sep = " ")

# visualization
my_stop_bigram <- my_stop_word
colnames(my_stop_bigram) <- "bigram"

bigrams_united%>%
  anti_join(my_stop_bigram)%>%
  filter(n>60)%>%
  mutate(bigram = reorder(bigram, n))%>%
  ggplot(aes(bigram, n, fill=(desc(n))))+
  geom_col() +
  xlab(NULL) +
  labs(title="Overall Bigram Frequency")+
  theme(plot.title = element_text(hjust = 0.5))+
  coord_flip()

# word cloud
bigrams_united %>%
  anti_join(my_stop_bigram)%>%
  with(wordcloud(bigram, n, max.words = 50,colors=n))
  