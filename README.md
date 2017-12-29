# Predict Ratings for Chinese Restaurants using Sentiment Analysis 
<img width="347" alt="screen shot 2017-12-02 at 11 45 55 pm" src="https://user-images.githubusercontent.com/31863572/33522438-00df5aa8-d7bb-11e7-9888-eb558414f4b1.png">

## 1. Read Yelp Data :ramen:
<br>
JSON file reading script: <br />
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;read_yelp_data_business.R, read_yelp_data_checkin.R, read_yelp_data_photo.R, read_yelp_data_tip.R, &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;read_yelp_data_user.R                          
<br>
[coding credit]: https://github.com/dpliublog/yelp_data_challenge_R10<br />
<br>
SQL file reading script:<br />                          
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;yelp_review_Chinese.R

## 2. Load Data :rice:
<br>
[data files]: https://drive.google.com/drive/folders/1_4749ED32FJuprWEspjkIkFQJDiH1yAX?usp=sharing

## 3. Data Manipulation :stew:
<br>
R script: <br />
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;yelp.analysis.R<br />

## 4. Restaurants EDA :chart_with_upwards_trend:
- **How's the ratings on Chinese restaurants?**
![general ratings on chinese restaurants](https://user-images.githubusercontent.com/31863572/33521408-3bdab402-d79f-11e7-9253-05bcba9663dc.png)

- **Just out of curiousity, where do these restaurants located?**
plotly link below :point_down:<br />

[Restaurants Location Interactive Map]: https://plot.ly/~angelayuanyuan/1/<br />

## 5. Text Analysis :books:
- **What words are frequently used when reviewing a Chinese Restaurant?**
![word cloud 1](https://user-images.githubusercontent.com/31863572/33521555-0b68d03e-d7a3-11e7-889f-9fa7dcc56182.png)

**CHICKEN!!**:poultry_leg::poultry_leg::poultry_leg: Of course.... What else would we expect:joy::joy::joy::joy:

- **What else?**
![word cloud 2](https://user-images.githubusercontent.com/31863572/33521580-d4d77826-d7a3-11e7-94f2-64ab54ff7146.png)

Looks like dim sum and fried rice are popular dishes

## 6. Sentiment Analysis :yum::smiley::smile::expressionless::disappointed:
- **Does the rating of a restaurant related to the average sentiment score of a person's review?**
![average sentiment scores](https://user-images.githubusercontent.com/31863572/33521600-f4d35e82-d7a4-11e7-8179-6eabc9f13442.png)

**YASSSSSSS**:clap::clap::clap:

- **How does sentiment words related to ratings?**
![sentiment and rating](https://user-images.githubusercontent.com/31863572/33521635-ba01e944-d7a5-11e7-8262-1139b856d793.png)

Okay, we see something weird here, some words with negative sentiment scores actually indicate pretty decent ratings.<br />

How did that happened?
![score and rating](https://user-images.githubusercontent.com/31863572/33521653-56f327a4-d7a6-11e7-9e26-2a2db8c56918.png)

Negative words like "die","disappoint" don't necessarily means dissatisfaction, people say things like "the food is to die for!!", "the food really doesn't disappoint us..."

- **Are we putting sentiment words into context? Not yet!**

Just as we mentioned above, sentiment words might follow or followed by word that turn them into completely different meanings. 

So let's take a look at the contexts
![sentient all](https://user-images.githubusercontent.com/31863572/34447242-213dd270-ecb0-11e7-824c-270926bf480b.png)

We could see from the graph, although some bigrams contain sentiment words (gluten *free*, egg *drop* etc), they are not used to discribe restaurants quality related stuff.

Next, we take a step further to explore positive and negative sentiment words in their contexts seperately


**Positve** sentiments first :thumbsup::thumbsup::thumbsup:
![positive](https://user-images.githubusercontent.com/31863572/34447374-405b875a-ecb1-11e7-8c53-626bf097c5e1.png)

It seems that we interprete most of the postive sentiment words fine


How about **negative** sentiments :-1::-1::-1:?
![negative](https://user-images.githubusercontent.com/31863572/34447440-d31c1140-ecb1-11e7-894c-0106869400ba.png)

What's wrong with *hard boiled*, *earl grey*, *jerk chicken* and so on ??<br />
They are food names, but unfortunately contain negative sentinent words in their name !!:broken_heart:

Please keep in mind, these situations would definitely cause inaccuracy when we try to predict ratings using sentiment.

- **Can we predict ratings using sentiment score?**
![sentiment prediction](https://user-images.githubusercontent.com/31863572/33521712-ad5db0a4-d7a7-11e7-92be-c285f4d251f5.png)

Seems promising:sunglasses:

## 7. Users info EDA :bar_chart:
Before going into prediction, let's take a step back by looking at how the users' rating data looks like

- **How many reviews do users usually write**

![number of reviews per user](https://user-images.githubusercontent.com/31863572/33521729-45d9f540-d7a8-11e7-855a-914e448d780c.png)

Wow...we can't tell anything from it<br />
Try remove the outliers so we could actually see something

![number of reviews per user without outliers](https://user-images.githubusercontent.com/31863572/33521743-afa7d654-d7a8-11e7-8ac1-0f63db013c1a.png)

Most users don't give a lot of reviews

- **What's the average ratings by users**
![average ratings by users](https://user-images.githubusercontent.com/31863572/33521787-f27fa820-d7a9-11e7-906e-09a2a8260694.png)

Users don't tend to give really low ratings

## 8. Regression Analysis :bulb:
- **sentiment polarity model**<br />
Regression models and results in yelp.analysis.R script

In this model, we use [sentimentr]https://cran.r-project.org/web/packages/sentimentr/sentimentr.pdf package to assign sentiment scores for each review text

- *one more question: do ratings related to the text length of the review*

![text length and ratings](https://user-images.githubusercontent.com/31863572/33521836-4b624a82-d7ab-11e7-9e8a-bf8440b4c1e3.png)

It doesn't look like.<br />
Review length seems to be related to personal habits rather than restaurants' quality

- *before fitting any model, how are our response variable distributed*

<img width="577" alt="emoji 1" src="https://user-images.githubusercontent.com/31863572/33521991-7f68d41e-d7af-11e7-912e-161ce27368b6.png">

The ratings are not normally distributed, we might want to use logit or multinomial models<br />

- **logistic models** 

Try split the data into ratings higher than 3 stars and ratings lower than 3 stars<br />

<img width="478" alt="emoji 2" src="https://user-images.githubusercontent.com/31863572/33521993-8bb28968-d7af-11e7-86c1-886fdfa2ba55.png">

In our regression output, the log odds is extremely big, which means we didn't include sufficient information in our model building process or there are outliers in the data<br />


- **multinomial models** 

Using the predictors as above to fit multinomial models would cause the same problem, so we think about what other information can we add to our model. 

From the users' perspective, different users have different standard when giving ratings. Some users tend to have a strict requirements for dining, so the ratings they give on Yelp will be generally low. Some users might be more tolerating, even though the quality of restaurants are not that satisfying, they are still giving quite decent ratings. So the underlying standard of each users is a factor that influences the outcome. Therefore, we go back to the Users dataset, and calculate the average ratings per user and add that information in our regression models. 

From the business's perspective, their ratings are definitely related to their own quality. Since we only have data in a limited period of time, we might not be able to get a full picture of how the businesses perform over the years. However, wo do have their ratings on Yelp, which is a cumulated results over a longer period. So we go ahead and add that in too.

The plots below shows the relationship between users' average rating versus their rating for a particular restaurants and the relationship between restaurants Yelp ratings versus their ratings in reviews.

![users rating](https://user-images.githubusercontent.com/31863572/33800599-2980e782-dd11-11e7-8c4d-d230b7c12165.png)

![yelp rating](https://user-images.githubusercontent.com/31863572/33800701-b3f22b0e-dd13-11e7-8ab3-20b111df47ae.png)


- **multilevel models** 

Still, linear multilevel models don't suit our data<br />
Therefore we try fitting multilevel logit models 


- **multilevel logit models**

*1) model building*

In this model, we split the restaurants into two categories, those who have users' ratings lower than 3 stars, and those who have users' ratings equal or higher than three stars. 

Our main objective is to find out whether we can use the sentiment which users' have shown in thier reviews to predict the ratings they might give to a certain restaurant. Besides the sentiment score of reviews, our predictors also include: indicator for restaurants' price range, parking availability and users' average ratings(all the ratings they have given on YELP/ numbers of reviews they have posted on YELP). However, by looking at our outcome data or looking at our residual plots when running a linear regression, we could see seperate trends, since the data contains repeated measurement for restaurants. Therefore, restaurants' public ratings (the one rating which shows up at the business page of a certain restaurant on YELP) is our group level predictor, which cover the information of different restaurants' random effect to our model outcome.

*2) regression output*

After running the regression, we find two predictors that have relatively big influence on users' ratings, the sentiment score of the review and users' average rating on YELP. On the other hand, whether the restaurant has parking slot and the price range of the restaurant doesn't matter much in users' rating process. The results are quite intuitive, people who express positve emotions in their reviews tend to give higher ratings, and people who have the habit, although we don't know the exact reason why, of giving decent ratings tend to give higher ratings. Of course, among these two factors, sentiment score plays a more important role when predicting ratings.

*3) model checking*

How do our model perform when used to predict ratings?

To know that, we run predictive checkings. The results are shown below.

![predictive](https://user-images.githubusercontent.com/31863572/33808309-3f7f0a54-ddb2-11e7-8174-e7b8cd740053.png)

On the left side is the prediction value, on the right side is our original data. Honestly, the distributions are similar, but our model is definitely over estimate the difference between two categories.

Hence, we run a chi square test to see if the two distribution are really different.

Well, it's not! :dancer:

*4) discussion and implication*

Using sentiment score to predict ratings can be fun, but it is not that accurate. Well it can tell whether a restaurant has above average quality or below, it is difficult to predict mild difference in ratings. After all, different person has different language habit and rating habit. People tend to go write reviews when the service they receive is remarkably pleasant or remarkably unpleasant. Some people swear when they really hate something and some people swear when they really love something. Some do both. These are all information that might affect our model but we are not taking into account of right now. Not to mention the circumstances that we discussed before, where sentiment words are not adjectives but nouns. 





