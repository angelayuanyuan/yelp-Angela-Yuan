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
library(sentimentr)
library(VGAM)
library(wesanderson)
library(rstanarm)
library(ggraph)
library(igraph)
library(tibble)

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
  summarise(rating = mean(stars)) #average users' rating per restaurant

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

https://plot.ly/~angelayuanyuan/1/ # just in case you're interested in where are the restaurants we analysis on
#api_create(p,filename = "location-graph", sharing = "public")

###########################
###### Text Analysis ######
###########################

# REVIEW DATA

# add new customized stop word
my_stop_word <- data.frame(word=character(6))
my_stop_word$word <- c("chinese","food","restaurant","chinese food","chinese restaurant","chinese restaurants")

# tokenizing by one gram
review.Chinese.word <- review %>%
  group_by(id)%>%
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
  group_by(id)%>%
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


# TIP DATA

# tokenizing by one gram
tip.chinese$id <- c(1:length(tip.chinese$text))

tip.Chinese.word <- tip.chinese %>%
  group_by(id)%>%
  mutate(linenumber = row_number())%>%
  unnest_tokens(word, text)%>%
  anti_join(stop_words)%>%
  anti_join(my_stop_word)%>%
  filter(str_detect(word, "^[a-z']+$"))%>%
  ungroup()

tip.word.freq <- tip.Chinese.word%>%
  count(word,sort=TRUE)

# word cloud
tip.word.freq %>%
  with(wordcloud(word, n, max.words = 50,colors=brewer.pal(8, "Dark2"),random.order=FALSE,rot.per=0.35))

# tokenizing by bigram
tip.Chinese.bigrams <- tip.chinese %>%
  group_by(id)%>%
  mutate(linenumber = row_number())%>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)

tip.bigrams.freq <- tip.Chinese.bigrams%>%
  ungroup()%>%
  count(bigram, sort = TRUE)

tip.bigrams.seperated <- tip.bigrams.freq%>%
  separate(bigram, c("word1", "word2"), sep = " ")

tip.bigrams.filtered <- tip.bigrams.seperated %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word) %>%
  filter(!word1 %in% my_stop_word$word) %>%
  filter(!word2 %in% my_stop_word$word)%>%
  filter(str_detect(word1, "^[a-z']+$"))%>%
  filter(str_detect(word1, "^[a-z']+$"))

tip.bigrams.united <- tip.bigrams.filtered %>%
  unite(bigram, word1, word2, sep = " ")

# word cloud
tip.bigrams.united %>%
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

# check the 'abnormal' sentiment word with ratings
# 'disappoint'
review$disappoint <- ifelse(str_detect(review$text,"disappoint")==TRUE,review$text,NA)
review.disappoint <- na.omit(review,col="disappoint")

# 'die'
review$die <- ifelse(str_detect(review$text,"die")==TRUE,review$text,NA)
review.die <- na.omit(review,col="die")

# sentiment bigram network
# overall sentiment
bigrams.seperated <- bigrams.freq%>%
  separate(bigram, c("word1", "word2"), sep = " ")

sentiment.bigrams <- bigrams.seperated %>%
  filter(word1 %in% AFINN$word|word2 %in% AFINN$word) %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word) %>%
  filter(str_detect(word1, "^[a-z']+$"))%>%
  filter(str_detect(word1, "^[a-z']+$"))


bigram_graph <- sentiment.bigrams %>%
  filter(n >150) %>%
  graph_from_data_frame()

set.seed(2017)

ggraph(bigram_graph, layout = "nicely") +
  geom_edge_link(aes(edge_alpha = n),arrow = a) +
  geom_node_point(color = "lightblue",size=5) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)+
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)+
  theme_void()

# postive sentiment
AFFIN.pos <- AFINN%>%
  filter(score>0)

pos.sentiment.bigrams <- bigrams.seperated %>%
  filter(word1 %in% AFFIN.pos$word|word2 %in% AFFIN.pos$word) %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word) %>%
  filter(str_detect(word1, "^[a-z']+$"))%>%
  filter(str_detect(word1, "^[a-z']+$"))


pos.bigram_graph <- pos.sentiment.bigrams %>%
  filter(n >150) %>%
  graph_from_data_frame()

set.seed(2017)

ggraph(pos.bigram_graph, layout = "nicely") +
  geom_edge_link(aes(edge_alpha = n),arrow = a) +
  geom_node_point(color = "lightblue",size=5) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)+
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)+
  theme_void()

# negative sentiment
AFFIN.neg <- AFINN%>%
  filter(score<0)

neg.sentiment.bigrams <- bigrams.seperated %>%
  filter(word1 %in% AFFIN.neg$word|word2 %in% AFFIN.neg$word) %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word) %>%
  filter(str_detect(word1, "^[a-z']+$"))%>%
  filter(str_detect(word1, "^[a-z']+$"))


neg.bigram_graph <- neg.sentiment.bigrams %>%
  filter(n >50) %>%
  graph_from_data_frame()

set.seed(2017)

ggraph(neg.bigram_graph, layout = "nicely") +
  geom_edge_link(aes(edge_alpha = n),arrow = a) +
  geom_node_point(color = "lightblue",size=5) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)+
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)+
  theme_void()

# tip sentiment analysis
tip.sentiment <- tip.Chinese.word %>%
  inner_join(AFINN, by = "word") %>%
  group_by(id,word) %>%
  summarize(sentiment = mean(score)) # we assume more positive sentiment in this data, since people tend to give tips or more tips when they get satisfied service

# tip sentiment distribution
quantile(tip.sentiment$sentiment,.5)

ggplot(tip.sentiment)+
  geom_bar(aes(sentiment),fill="salmon")+
  geom_vline(xintercept = 2,linetype=2,color="white")+
  labs(title = "Sentiment Score of Tips")+
  theme(plot.title = element_text(hjust = 0.5)) # as we expected...
  
  
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
sentences <- get_sentences(yelp.chinese$text)

polarity <- sentiment(sentences, polarity_dt = lexicon::hash_sentiment_jockers, valence_shifters_dt = lexicon::hash_valence_shifters, hyphen = " ") # get a sentiment score for each review (running this line might take a while...)

sentences.sentiment <- polarity%>%
  group_by(element_id)%>%
  mutate(sentiment=mean(sentiment), word.count=sum(word_count))%>%
  slice(1)%>%
  select(element_id,sentiment,word.count)

yelp.chinese$element_id <- c(1:length(sentences.sentiment$element_id))
yelp.chinese <- left_join(yelp.chinese,sentences.sentiment)
yelp.chinese$word.count[is.na(yelp.chinese$word.count)] <- 0

# are there relationship between the length of review and ratings
ggplot(yelp.chinese)+
  geom_histogram(aes(word.count,fill=as.factor(stars)))


ggplot(yelp.chinese)+
  geom_boxplot(aes(stars,word.count,group = stars,fill= "stars"))+
  theme(legend.position = "none") # doesn't look like. review length seems to be related to personal habit rather than restaurants' quality



# are there relationship between the ratings and the their sentiment score of reviews

ggplot(yelp.chinese)+
  geom_boxplot(aes(stars,sentiment,group = stars,fill= "stars"))+
  theme(legend.position = "none") # well, the trend is weak


# combine ratings with business attributes
yelp.chinese <- yelp.chinese%>%
  group_by(business_id)%>%
  mutate(average_stars = mean(stars))

yelp.chinese <- left_join(yelp.chinese,attr.chinese, by= "business_id")

yelp.chinese$business.parking[is.na(yelp.chinese$business.parking)] <- 0

# first, let's review how our data looks like
ggplot(yelp.chinese)+
  geom_bar(aes(stars))# definetly not normal
hist(yelp.chinese$sentiment)

# simple linear models
lm.1 <- lm(stars~sentiment, data = yelp.chinese)
summary(lm.1)
plot(lm.1, which = 1) 

lm.2 <- lm(stars~sentiment+RestaurantsPriceRange2+business.parking+NoiseLevel,data = yelp.chinese)
summary(lm.2)
plot(lm.2, which = 1) # clearly, this is not our model. there are seperated trends in the residual plot, we might want to add group level predictors later

# logistic models
# try split the data into ratings higher than 3 stars and ratings lower than 3 stars
yelp.chinese$better <- ifelse(yelp.chinese$stars>=3,1,0) # consider restaurants with 3 or more stars better restaurants

# then how does the data look like
yelp.chinese$better <- as.factor(yelp.chinese$better)
ggplot(yelp.chinese)+
  geom_bar(aes(better,fill = better))
p.binom <- table(yelp.chinese$better)
p.binom # approximately 1:4

glm.1 <- glm(better~sentiment,family = binomial(link = "logit"),data = yelp.chinese)
summary(glm.1)
plot(glm.1,which = 1)
y.glm.1 <- data.frame(fitted(glm.1))
y.glm.1$better <- as.factor(ifelse(y.glm.1$fitted.glm.1.>0.5,1,0))

ggplot(y.glm.1)+
  geom_bar(aes(better,fill = better)) # we overestimate the difference of numbers between restaurants with above 3 stars and below 3 stars

summary(yelp.chinese$sentiment)
glm.2 <- glm(better~sentiment+RestaurantsPriceRange2+business.parking+NoiseLevel,family = binomial(link = "logit"),data = yelp.chinese)
summary(glm.2) # perfect seperation

# try diagnose the model by letting out one predictor each time and see which one causes perfect seperation
# omit the whole diagnose process here, the problem comes down to NoiseLevel and business.parking

ggplot(yelp.chinese)+
  geom_violin(aes(x=NoiseLevel,y=stars,group=NoiseLevel,fill=NoiseLevel))+
  scale_fill_brewer(palette = "Reds")

yelp.chinese$business.parking <- as.factor(yelp.chinese$business.parking)
ggplot(yelp.chinese)+
  geom_violin(aes(x=business.parking,y=stars,group=business.parking,fill=business.parking))+
  scale_fill_brewer(palette = "Reds")

glm.3 <- glm(better~sentiment+RestaurantsPriceRange2+business.parking,family = binomial(link = "logit"),data = yelp.chinese)
summary(glm.3)
y.glm.3 <- data.frame(fitted(glm.3))
y.glm.3$better <- as.factor(ifelse(y.glm.3$fitted.glm.3.>0.5,1,0))

ggplot(y.glm.3)+
  geom_bar(aes(better,fill = better))

glm.4 <- glm(better~sentiment+RestaurantsPriceRange2+NoiseLevel,family = binomial(link = "logit"),data = yelp.chinese)
summary(glm.4)

y.glm.4 <- data.frame(fitted(glm.4))
y.glm.4$better <- as.factor(ifelse(y.glm.4$fitted.glm.4.>0.5,1,0))

ggplot(y.glm.4)+
  geom_bar(aes(better,fill = better))

# multinomial models
yelp.chinese$stars <- as.factor(yelp.chinese$stars)
levels(yelp.chinese$stars)
stars.freq <- table(yelp.chinese$stars)
stars.freq

yelp.chinese$stars <- as.numeric(yelp.chinese$stars)
vglm.1 <- polr(ordered(stars)~sentiment, data = subset(yelp.chinese,yelp.chinese$sentiment<=0.3))
summary(vglm.1) 
y.hat <- data.frame(predict(vglm.1,type="prob"))


vglm.2 <- polr(ordered(stars)~sentiment+RestaurantsPriceRange2+NoiseLevel, data = subset(yelp.chinese,yelp.chinese$sentiment<=0.3))
summary(vglm.2)
y.hat2 <- data.frame(predict(vglm.2,type="prob"))



# multilevel models 
# combine users info
colnames(user)[3] <- "avg.star.user"
yelp.chinese <- left_join(yelp.chinese,user,by="user_id")

yelp.chinese$stars <- as.numeric(yelp.chinese$stars)
ggplot(yelp.chinese)+
  geom_jitter(aes(avg.star.user,stars,color=stars))

# add restaurants' public rating as random effect
colnames(info.chinese)[10] <- "yelp.rating"

yelp.rating <- info.chinese%>%
  select(business_id,yelp.rating)

yelp.chinese <- left_join(yelp.chinese,yelp.rating)
ggplot(yelp.chinese)+
  geom_jitter(aes(yelp.rating,stars,color=stars))



# multilevel logit models

# but let's start simple
glm.5 <- glm(better~sentiment+RestaurantsPriceRange2+business.parking+NoiseLevel+yelp.rating+avg.star.user,family = binomial(link = "logit"),data = yelp.chinese)
summary(glm.5)

y.glm.5 <- data.frame(fitted(glm.5))
y.glm.5$better <- as.factor(ifelse(y.glm.5$fitted.glm.5.>0.5,1,0))

ggplot(y.glm.5)+
  geom_bar(aes(better,fill = better))

mllm.1 <- glmer(better ~ sentiment+(1|avg.star.user)+(1|yelp.rating),family=binomial(link="logit"),data = yelp.chinese)
summary(mllm.1)
binnedplot(fitted(mllm.1),residuals(mllm.1,type="response")) # well the residual plot looks awful...


mllm.2 <- glmer(better ~ sentiment+RestaurantsPriceRange2+business.parking+(1|avg.star.user)+(1|yelp.rating),family=binomial(link="logit"),data = yelp.chinese)
summary(mllm.2)
binnedplot(fitted(mllm.2),residuals(mllm.2,type="response")) # not so much better

mllm.3 <- glmer(better ~ sentiment+RestaurantsPriceRange2+business.parking+(1|yelp.rating),family=binomial(link="logit"),data = yelp.chinese)
summary(mllm.3)
binnedplot(fitted(mllm.3),residuals(mllm.3,type="response"))

mllm.4 <- glmer(better ~ sentiment+RestaurantsPriceRange2+business.parking+yelp.rating+(1+yelp.rating|avg.star.user),family=binomial(link="logit"),data = yelp.chinese)
summary(mllm.4)
binnedplot(fitted(mllm.4),residuals(mllm.4,type="response"))

mllm.5 <- glmer(better ~ sentiment+RestaurantsPriceRange2+business.parking+avg.star.user+(1|yelp.rating),family=binomial(link="logit"),data = yelp.chinese)
summary(mllm.5)
binnedplot(fitted(mllm.5),residuals(mllm.5,type="response"))

# maybe we should try bayesian? add prior info for prediction?

# FAIL...takes forever to run 
# stan.1 <- stan_glmer(better ~ sentiment+sentiment+RestaurantsPriceRange2+business.parking+(1|avg.star.user),family=binomial(link="logit"),data = yelp.chinese)

# try to predict with our model
# 2
pred.2 <- data.frame(predict(mllm.2,type="response"))
colnames(pred.2) <- "prob"
pred.2$Predict <- as.factor(ifelse(pred.2$prob>0.5,1,0))

gridExtra::grid.arrange (
  ggplot(pred.2)+
    geom_bar(aes(Predict,fill=Predict)),
  ggplot(yelp.chinese)+
    geom_bar(aes(better,fill = better)),
  ncol=2
)


# 3
pred.3 <- data.frame(predict(mllm.3,type="response"))
colnames(pred.3) <- "prob"
pred.3$Predict <- as.factor(ifelse(pred.3$prob>0.5,1,0))

gridExtra::grid.arrange (
  ggplot(pred.3)+
    geom_bar(aes(Predict,fill=Predict)),
  ggplot(yelp.chinese)+
    geom_bar(aes(better,fill = better)),
  ncol=2
)


# 4
pred.4 <- data.frame(predict(mllm.4,type="response"))
colnames(pred.4) <- "prob"
pred.4$Predict <- as.factor(ifelse(pred.4$prob>0.5,1,0))

gridExtra::grid.arrange (
ggplot(pred.4)+
  geom_bar(aes(Predict,fill=Predict)),
ggplot(yelp.chinese)+
  geom_bar(aes(better,fill = better)),
ncol=2
)

# 5
pred.5 <- data.frame(predict(mllm.5,type="response"))
colnames(pred.5) <- "prob"
pred.5$Predict <- as.factor(ifelse(pred.5$prob>0.5,1,0))

gridExtra::grid.arrange (
  ggplot(pred.5)+
    geom_bar(aes(Predict,fill=Predict)),
  ggplot(yelp.chinese)+
    geom_bar(aes(better,fill = better)),
  ncol=2
)

pred <- as.vector(summary(pred.5$Predict))
obs <- as.vector(p.binom)

chisq.test(p.binom,pred)

