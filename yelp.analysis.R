# load packages
library(stringr)
library(lubridate)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(tidyr)
library(tidytext)
library(ggraph)
library(widyr)
library(wordcloud)
library(RColorBrewer)
library(knitr)
library(stats)
library(arm)
library(tidyverse)
library(dplyr)
library(lme4)
library(plotly)

# load data
load("~/Desktop/yelp github/Yelp/rdata/info.chinese.Rdata")
load("~/Desktop/yelp github/Yelp/rdata/review.chinese.Rdata")
load("~/Desktop/yelp github/Yelp/rdata/tip.Rdata")
load("~/Desktop/yelp github/Yelp/rdata/user_info.Rdata")
load("~/Desktop/yelp github/Yelp/rdata/business_attributes.Rdata")

###########################
#### Data Manipulation ####
###########################

# retrieve business id in data info.chinese
business.id <- data.frame(unique(info.chinese$business_id))
colnames(business.id) <- "business_id"

# find reviews for these restaurants in data review
yelp.chinese <- left_join(business.id,review)
yelp.chinese <- na.omit(yelp.chinese)

tip <- df_tip%>%
  dplyr::select(-likes)

tip.chinese <- dplyr::left_join(business.id,tip)
tip.chinese <- na.omit(tip.chinese)

business.id <- data.frame(unique(yelp.chinese$business_id))
colnames(business.id) <- "business_id"

attr.chinese <- left_join(business.id,df_business_attributes,by="business_id")

# creat one single indicator for parking availability
attr.chinese$business.parking <- ifelse(attr.chinese$BusinessParking.garage==TRUE|attr.chinese$BusinessParking.street==TRUE|attr.chinese$BusinessParking.street==TRUE|attr.chinese$BusinessParking.validated==TRUE|attr.chinese$BusinessParking.lot==TRUE|attr.chinese$BusinessParking.valet==TRUE,1,0)

attr.chinese <- attr.chinese%>%
  select(business_id,RestaurantsPriceRange2,business.parking,BikeParking,NoiseLevel,RestaurantsGoodForGroups,RestaurantsDelivery,HasTV,WiFi,RestaurantsTakeOut,RestaurantsReservations,RestaurantsTableService)

# conbine restaurants' attributes with their ratings
rating.chinese <- yelp.chinese %>%
  group_by(business_id)%>%
  arrange(date)%>%
  summarise(rating = mean(stars))

rating.chinese <- merge(rating.chinese,attr.chinese,by="business_id")

###########################
##### EDA Restaurants #####
###########################

# plot general ratings on Chinese restaurants
quantile(rating.chinese$rating,.5)

ggplot(rating.chinese)+
  geom_density(aes(rating, fill = "tomato3", color ="salmon"))+
  geom_vline(xintercept = 3.5, linetype= 2, color = "white")+
  labs(title = "General Ratings on Chinese Restaurants")+
  theme(plot.title = element_text(hjust = 0.5), legend.position = "none")

# plot locations of Chinese restaurants

Sys.setenv("plotly_username"="angelayuanyuan")
Sys.setenv("plotly_api_key"="a3TiWCGjFyJ4PFKUC7iX")

Sys.setenv('MAPBOX_TOKEN' = 'pk.eyJ1IjoiYW5nZWxheXVhbnl1YW4iLCJhIjoiY2phaW94NHd3MjJiZjJ6cGxqMjRzbmV0cyJ9.FXxSxGIl4vysLYWzehQlPw')

p <- info.chinese %>%
  plot_mapbox(lat = ~latitude, lon = ~longitude,
              split = ~stars, size=5,
              mode = 'scattermapbox', hoverinfo='name') %>%
  layout(title = 'Location of Chinese Restaurants',
         font = list(color='black'),
         plot_bgcolor = '#191A1A', paper_bgcolor = 'white',
         mapbox = list(style = 'light'),
         legend = list(orientation = 'h',
                       font = list(size = 8)),
         margin = list(l = 25, r = 25,
                       b = 25, t = 25,
                       pad = 2))

p

api_create(p,filename = "location-graph", sharing = "public")

###########################
### Sentiment Analysis ####
###########################

# add new customized stop word
my_stop_word <- data.frame(word=character(6))
my_stop_word$word <- c("chinese","food","restaurant","chinese food","chinese restaurant","chinese restaurants")

# tokenizing by one gram
review.Chinese.word <- review %>%
  group_by(user_id)%>%
  mutate(linenumber = row_number())%>%
  unnest_tokens(word, text)%>%
  anti_join(stop_words)%>%
  anti_join(my_stop_word)%>%
  filter(str_detect(word, "^[a-z']+$"))%>%
  ungroup()

word.freq <- review.Chinese.word%>%
  count(word,sort=TRUE)

# word cloud
word.freq %>%
  with(wordcloud(word, n, max.words = 50,colors=brewer.pal(8, "Dark2"),random.order=FALSE,rot.per=0.35))

# tokenizing by bigram
review.Chinese.bigrams <- review %>%
  group_by(user_id)%>%
  mutate(linenumber = row_number())%>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)

bigrams.freq <- review.Chinese.bigrams%>%
  ungroup()%>%
  count(bigram, sort = TRUE)

bigrams.seperated <- bigrams.freq%>%
  separate(bigram, c("word1", "word2"), sep = " ")

bigrams.filtered <- bigrams.seperated %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word) %>%
  filter(!word1 %in% my_stop_word$word) %>%
  filter(!word2 %in% my_stop_word$word)%>%
  filter(str_detect(word1, "^[a-z']+$"))%>%
  filter(str_detect(word1, "^[a-z']+$"))

bigrams.united <- bigrams.filtered %>%
  unite(bigram, word1, word2, sep = " ")

# word cloud
bigrams.united %>%
  with(wordcloud(bigram, n, max.words = 50,colors=brewer.pal(8, "Dark2"),random.order=FALSE,rot.per=0.35))

# sentiment analysis
get_sentiments("afinn")

AFINN <- get_sentiments("afinn") %>%
  dplyr::select(word,score)

reviews.sentiment <- review.Chinese.word %>%
  inner_join(AFINN, by = "word") %>%
  group_by(id, stars) %>%
  summarize(sentiment = mean(score))

ggplot(reviews.sentiment, aes(stars, sentiment, group = stars, color= stars)) +
  geom_boxplot() +
  ylab("Average Sentiment Score")

review.word.counted <- review.Chinese.word %>%
  count(id, business_id, stars, word) %>%
  ungroup()

word.sum <- review.word.counted %>%
  dplyr::select(-n)
  
word.sum <- word.sum%>%
  group_by(word) %>%
  summarise(Chinese.Restaurants=n_distinct(business_id),
            reviews=n(),
            average_stars = mean(stars))%>%
  ungroup()

# postive words 
word.sum.filtered <- word.sum %>%
  filter(reviews >= 1000, Chinese.Restaurants >= 1000)%>%
  arrange(desc(average_stars))

# negative words
word.sum.filtered <- word.sum %>%
  filter(reviews >= 500, Chinese.Restaurants >= 500)%>%
  arrange(average_stars)

# visualization
ggplot(word.sum.filtered, aes(reviews, average_stars)) +
  geom_point() +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1, hjust = 1) +
  scale_x_log10() +
  geom_hline(yintercept = mean(word.sum.filtered$average_stars), color = "red", lty = 2) +
  xlab("Number of Reviews") +
  ylab("Average Stars")

# combine ratings with sentiment score
word.afinn <- word.sum.filtered %>%
  inner_join(AFINN)

ggplot(word.afinn, aes(score, average_stars, group = score)) +
  geom_boxplot() +
  xlab("Sentiment score of word") +
  ylab("Average stars of Reviews") ## okay, we see something weird in this plot

# using sentiment score to predict rating
mod <- lm(average_stars~score,data = word.afinn)
display(mod)

ggplot(word.afinn, aes(score, average_stars, group = score)) +
  geom_point(aes(size=reviews)) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5, hjust = 1,nudge_x = 0.1,nudge_y = 0.1) +
  xlab("Sentiment score of word") +
  ylab("Average stars of Reviews")+
  geom_abline(slope = coef(mod)[2],intercept = coef(mod)[1]) 

ggplot(word.afinn, aes(reviews, average_stars)) +
  geom_point(aes(color=score)) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1, hjust = 1) +
  scale_x_log10() +
  geom_hline(yintercept = mean(word.sum.filtered$average_stars), color = "red", lty = 2) +
  xlab("Number of Reviews") +
  ylab("Average Stars")

###########################
######## EDA Users ########
###########################

# retrieve user id in data review
user <- data.frame(unique(review$user_id))
colnames(user) <- "user_id"

# match their info with user related data
user <- left_join(user,df_user_info)
user <- user%>%
  dplyr::select(user_id,review_count,average_stars,fans,n_friends)

# number of reviews
quantile(user$review_count,0.5)

ggplot(user)+
  geom_density(aes(review_count,fill = "tomato3", color ="salmon"))+
  labs(title = "Number of Reviews per User")+
  geom_vline(xintercept = 23, linetype= 2, color = "white")+
  theme(plot.title = element_text(hjust = 0.5), legend.position = "none")

ggplot(user)+
  geom_boxplot(aes(x="review_count", y=review_count,fill = "tomato3", color ="salmon"))+
  theme(legend.position = "none")

summary(user$review_count)

# let out the outliers
user.ch <- subset(user,user$review_count<=80)

ggplot(user.ch)+
  geom_density(aes(review_count,fill = "tomato3", color ="salmon"))+
  labs(title = "Number of Reviews per User")+
  geom_vline(xintercept = 23, linetype= 2, color = "white")+
  theme(plot.title = element_text(hjust = 0.5), legend.position = "none")

ggplot(user.ch)+
  geom_histogram(aes(review_count,fill = "tomato3", color ="salmon"))+
  labs(title = "Number of Reviews per User")+
  geom_vline(xintercept = 23, linetype= 2, color = "white")+
  theme(plot.title = element_text(hjust = 0.5), legend.position = "none")

# users' average rating
quantile(user$average_stars,0.5)

ggplot(user)+
  geom_density(aes(average_stars,fill = "tomato3", color ="salmon"))+
  labs(title = "Average Ratings by Users")+
  geom_vline(xintercept = 3.75, linetype= 2, color = "white")+
  theme(plot.title = element_text(hjust = 0.5), legend.position = "none")

ggplot(user)+
  geom_histogram(aes(average_stars,fill = "tomato3", color ="salmon"))+
  labs(title = "Average Ratings by Users")+
  geom_vline(xintercept = 3.75, linetype= 2, color = "white")+
  theme(plot.title = element_text(hjust = 0.5), legend.position = "none")


###########################
### Regression Analysis ###
###########################

# sentiment polarity model
polarity <- counts.polarity(sent_detect(yelp.chinese$text), polarity.frame=REVIEWS_DICT, constrain=T)

# linear regression

# combine ratings with business attributes
yelp.chinese <- left_join(yelp.chinese,attr.chinese)

mod.1 <- lm(stars~RestaurantsPriceRange2+business.parking+BikeParking+NoiseLevel+RestaurantsGoodForGroups+RestaurantsDelivery+HasTV+WiFi+RestaurantsTakeOut+RestaurantsReservations+RestaurantsTableService ,data = yelp.chinese) 
summary(mod.1)
  
mllm <- lmer(stars ~ (1|average_stars),data = yelp.chinese)
display(mllm)
