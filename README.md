# Predict ratings for Chinese restaurants using sentiment analysis :fork_and_knife:
<br>

## 1. Read Yelp Data :ramen:
<br>
JSON file reading script: <br />
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;read_yelp_data_business.R, <br />
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;read_yelp_data_checkin.R, <br />
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;read_yelp_data_photo.R,<br />
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;read_yelp_data_tip.R,<br />
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;read_yelp_data_user.R<br />
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

## 4. Restaurants EDA :curry:
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

## 6. Sentiment Analysis
- **Does the rating of a restaurant related to the average sentiment score of a person's review?**
![average sentiment scores](https://user-images.githubusercontent.com/31863572/33521600-f4d35e82-d7a4-11e7-8179-6eabc9f13442.png)

**YASSSSSSS**:clap::clap::clap:

- **How does sentiment words related to ratings?**
![sentiment and rating](https://user-images.githubusercontent.com/31863572/33521635-ba01e944-d7a5-11e7-8262-1139b856d793.png)

Okay, we see something weird here, some words with negative sentiment scores actually indicate pretty decent ratings


