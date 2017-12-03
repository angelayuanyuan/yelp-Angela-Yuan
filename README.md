# Predict ratings for Chinese restaurants using sentiment analysis :fork_and_knife:
<br>

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
[data files]: https://drive.google.com/drive/u/0/folders/1_4749ED32FJuprWEspjkIkFQJDiH1yAX

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
Regression models and results in yelp.analysis.R sript

In this model, we use [sentimentr]https://cran.r-project.org/web/packages/sentimentr/sentimentr.pdf package to assign sentiment scores for each review text

- *one more question: do ratings related to the text length of the review*

![text length and ratings](https://user-images.githubusercontent.com/31863572/33521836-4b624a82-d7ab-11e7-9e8a-bf8440b4c1e3.png)

It doesn't look like.<br />
Review length seems to be related to personal habits rather than restaurants' quality

- *before fitting any model, how are our response variable distributed*

<img width="577" alt="emoji 1" src="https://user-images.githubusercontent.com/31863572/33521991-7f68d41e-d7af-11e7-912e-161ce27368b6.png">

The ratings are not normally distributed, we might want to use logit or multinomial models<br />

- **logistic models** -

Try split the data into ratings higher than 3 stars and ratings lower than 3 stars<br />

<img width="478" alt="emoji 2" src="https://user-images.githubusercontent.com/31863572/33521993-8bb28968-d7af-11e7-86c1-886fdfa2ba55.png">


- **multinomial models** -

Using chi square test for testing the goodness of fit

- **multilevel models** -

Still, linear multilevel models don't suit our data<br />
Therefore we try fitting multilevel logit models and multilevel multinomial models

- **multilevel logit models** -

Random Effect: Users' avarage rating on Yelp<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Restaurants' rating on Yelp




