   <div id="readme" class="readme blob instapaper_body">
    <article class="markdown-body entry-content" itemprop="text"><h1><a href="#predict-ratings-for-chinese-restaurants-using-sentiment-analysis" aria-hidden="true" class="anchor" id="user-content-predict-ratings-for-chinese-restaurants-using-sentiment-analysis"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Predict Ratings for Chinese Restaurants using Sentiment Analysis</h1>
<br>
<h2><a href="#1-read-yelp-data-ramen" aria-hidden="true" class="anchor" id="user-content-1-read-yelp-data-ramen"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>1. Read Yelp Data <g-emoji alias="ramen" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f35c.png" ios-version="6.0">🍜</g-emoji></h2>
<br>
JSON file reading script: <br>
                                 read_yelp_data_business.R, read_yelp_data_checkin.R, read_yelp_data_photo.R, read_yelp_data_tip.R,        read_yelp_data_user.R                          
<br>
[coding credit]: <a href="https://github.com/dpliublog/yelp_data_challenge_R10">https://github.com/dpliublog/yelp_data_challenge_R10</a><br>
<br>
SQL file reading script:<br>                          
                                 yelp_review_Chinese.R
<h2><a href="#2-load-data-rice" aria-hidden="true" class="anchor" id="user-content-2-load-data-rice"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>2. Load Data <g-emoji alias="rice" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f35a.png" ios-version="6.0">🍚</g-emoji></h2>
<br>
[data files]: <a href="https://drive.google.com/drive/u/0/folders/1_4749ED32FJuprWEspjkIkFQJDiH1yAX">https://drive.google.com/drive/u/0/folders/1_4749ED32FJuprWEspjkIkFQJDiH1yAX</a>
<h2><a href="#3-data-manipulation-stew" aria-hidden="true" class="anchor" id="user-content-3-data-manipulation-stew"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>3. Data Manipulation <g-emoji alias="stew" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f372.png" ios-version="6.0">🍲</g-emoji></h2>
<br>
R script: <br>
                                 yelp.analysis.R<br>
<h2><a href="#4-restaurants-eda-chart_with_upwards_trend" aria-hidden="true" class="anchor" id="user-content-4-restaurants-eda-chart_with_upwards_trend"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>4. Restaurants EDA <g-emoji alias="chart_with_upwards_trend" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f4c8.png" ios-version="6.0">📈</g-emoji></h2>
<ul>
<li>
<p><strong>How's the ratings on Chinese restaurants?</strong>
<a href="https://user-images.githubusercontent.com/31863572/33521408-3bdab402-d79f-11e7-9253-05bcba9663dc.png" target="_blank"><img src="https://user-images.githubusercontent.com/31863572/33521408-3bdab402-d79f-11e7-9253-05bcba9663dc.png" alt="general ratings on chinese restaurants" style="max-width:100%;"></a></p>
</li>
<li>
<p><strong>Just out of curiousity, where do these restaurants located?</strong>
plotly link below <g-emoji alias="point_down" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f447.png" ios-version="6.0">👇</g-emoji><br></p>
</li>
</ul>
<p>[Restaurants Location Interactive Map]: <a href="https://plot.ly/%7Eangelayuanyuan/1/" rel="nofollow">https://plot.ly/~angelayuanyuan/1/</a><br></p>
<h2><a href="#5-text-analysis-books" aria-hidden="true" class="anchor" id="user-content-5-text-analysis-books"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>5. Text Analysis <g-emoji alias="books" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f4da.png" ios-version="6.0">📚</g-emoji></h2>
<ul>
<li><strong>What words are frequently used when reviewing a Chinese Restaurant?</strong>
<a href="https://user-images.githubusercontent.com/31863572/33521555-0b68d03e-d7a3-11e7-889f-9fa7dcc56182.png" target="_blank"><img src="https://user-images.githubusercontent.com/31863572/33521555-0b68d03e-d7a3-11e7-889f-9fa7dcc56182.png" alt="word cloud 1" style="max-width:100%;"></a></li>
</ul>
<p><strong>CHICKEN!!</strong><g-emoji alias="poultry_leg" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f357.png" ios-version="6.0">🍗</g-emoji><g-emoji alias="poultry_leg" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f357.png" ios-version="6.0">🍗</g-emoji><g-emoji alias="poultry_leg" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f357.png" ios-version="6.0">🍗</g-emoji> Of course.... What else would we expect<g-emoji alias="joy" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f602.png" ios-version="6.0">😂</g-emoji><g-emoji alias="joy" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f602.png" ios-version="6.0">😂</g-emoji><g-emoji alias="joy" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f602.png" ios-version="6.0">😂</g-emoji><g-emoji alias="joy" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f602.png" ios-version="6.0">😂</g-emoji></p>
<ul>
<li><strong>What else?</strong>
<a href="https://user-images.githubusercontent.com/31863572/33521580-d4d77826-d7a3-11e7-94f2-64ab54ff7146.png" target="_blank"><img src="https://user-images.githubusercontent.com/31863572/33521580-d4d77826-d7a3-11e7-94f2-64ab54ff7146.png" alt="word cloud 2" style="max-width:100%;"></a></li>
</ul>
<p>Looks like dim sum and fried rice are popular dishes</p>
<h2><a href="#6-sentiment-analysis-yumsmileysmileexpressionlessdisappointed" aria-hidden="true" class="anchor" id="user-content-6-sentiment-analysis-yumsmileysmileexpressionlessdisappointed"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>6. Sentiment Analysis <g-emoji alias="yum" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f60b.png" ios-version="6.0">😋</g-emoji><g-emoji alias="smiley" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f603.png" ios-version="6.0">😃</g-emoji><g-emoji alias="smile" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f604.png" ios-version="6.0">😄</g-emoji><g-emoji alias="expressionless" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f611.png" ios-version="6.0">😑</g-emoji><g-emoji alias="disappointed" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f61e.png" ios-version="6.0">😞</g-emoji></h2>
<ul>
<li><strong>Does the rating of a restaurant related to the average sentiment score of a person's review?</strong>
<a href="https://user-images.githubusercontent.com/31863572/33521600-f4d35e82-d7a4-11e7-8179-6eabc9f13442.png" target="_blank"><img src="https://user-images.githubusercontent.com/31863572/33521600-f4d35e82-d7a4-11e7-8179-6eabc9f13442.png" alt="average sentiment scores" style="max-width:100%;"></a></li>
</ul>
<p><strong>YASSSSSSS</strong><g-emoji alias="clap" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f44f.png" ios-version="6.0">👏</g-emoji><g-emoji alias="clap" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f44f.png" ios-version="6.0">👏</g-emoji><g-emoji alias="clap" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f44f.png" ios-version="6.0">👏</g-emoji></p>
<ul>
<li><strong>How does sentiment words related to ratings?</strong>
<a href="https://user-images.githubusercontent.com/31863572/33521635-ba01e944-d7a5-11e7-8262-1139b856d793.png" target="_blank"><img src="https://user-images.githubusercontent.com/31863572/33521635-ba01e944-d7a5-11e7-8262-1139b856d793.png" alt="sentiment and rating" style="max-width:100%;"></a></li>
</ul>
<p>Okay, we see something weird here, some words with negative sentiment scores actually indicate pretty decent ratings.<br></p>
<p>How did that happened?
<a href="https://user-images.githubusercontent.com/31863572/33521653-56f327a4-d7a6-11e7-9e26-2a2db8c56918.png" target="_blank"><img src="https://user-images.githubusercontent.com/31863572/33521653-56f327a4-d7a6-11e7-9e26-2a2db8c56918.png" alt="score and rating" style="max-width:100%;"></a></p>
<p>Negative words like "die","disappoint" don't necessarily means dissatisfaction, people say things like "the food is to die for!!", "the food really doesn't disappoint us..."</p>
<ul>
<li><strong>Can we predict ratings using sentiment score?</strong>
<a href="https://user-images.githubusercontent.com/31863572/33521712-ad5db0a4-d7a7-11e7-92be-c285f4d251f5.png" target="_blank"><img src="https://user-images.githubusercontent.com/31863572/33521712-ad5db0a4-d7a7-11e7-92be-c285f4d251f5.png" alt="sentiment prediction" style="max-width:100%;"></a></li>
</ul>
<p>Seems promising<g-emoji alias="sunglasses" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f60e.png" ios-version="6.0">😎</g-emoji></p>
<h2><a href="#7-users-info-eda-bar_chart" aria-hidden="true" class="anchor" id="user-content-7-users-info-eda-bar_chart"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>7. Users info EDA <g-emoji alias="bar_chart" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f4ca.png" ios-version="6.0">📊</g-emoji></h2>
<p>Before going into prediction, let's take a step back by looking at how the users' rating data looks like</p>
<ul>
<li><strong>How many reviews do users usually write</strong></li>
</ul>
<p><a href="https://user-images.githubusercontent.com/31863572/33521729-45d9f540-d7a8-11e7-855a-914e448d780c.png" target="_blank"><img src="https://user-images.githubusercontent.com/31863572/33521729-45d9f540-d7a8-11e7-855a-914e448d780c.png" alt="number of reviews per user" style="max-width:100%;"></a></p>
<p>Wow...we can't tell anything from it<br>
Try remove the outliers so we could actually see something</p>
<p><a href="https://user-images.githubusercontent.com/31863572/33521743-afa7d654-d7a8-11e7-8ac1-0f63db013c1a.png" target="_blank"><img src="https://user-images.githubusercontent.com/31863572/33521743-afa7d654-d7a8-11e7-8ac1-0f63db013c1a.png" alt="number of reviews per user without outliers" style="max-width:100%;"></a></p>
<p>Most users don't give a lot of reviews</p>
<ul>
<li><strong>What's the average ratings by users</strong>
<a href="https://user-images.githubusercontent.com/31863572/33521787-f27fa820-d7a9-11e7-906e-09a2a8260694.png" target="_blank"><img src="https://user-images.githubusercontent.com/31863572/33521787-f27fa820-d7a9-11e7-906e-09a2a8260694.png" alt="average ratings by users" style="max-width:100%;"></a></li>
</ul>
<p>Users don't tend to give really low ratings</p>
<h2><a href="#8-regression-analysis-bulb" aria-hidden="true" class="anchor" id="user-content-8-regression-analysis-bulb"><svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>8. Regression Analysis <g-emoji alias="bulb" fallback-src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f4a1.png" ios-version="6.0">💡</g-emoji></h2>
<ul>
<li><strong>sentiment polarity model</strong><br>
Regression models and results in yelp.analysis.R script</li>
</ul>
<p>In this model, we use [sentimentr]<a href="https://cran.r-project.org/web/packages/sentimentr/sentimentr.pdf" rel="nofollow">https://cran.r-project.org/web/packages/sentimentr/sentimentr.pdf</a> package to assign sentiment scores for each review text</p>
<ul>
<li><em>one more question: do ratings related to the text length of the review</em></li>
</ul>
<p><a href="https://user-images.githubusercontent.com/31863572/33521836-4b624a82-d7ab-11e7-9e8a-bf8440b4c1e3.png" target="_blank"><img src="https://user-images.githubusercontent.com/31863572/33521836-4b624a82-d7ab-11e7-9e8a-bf8440b4c1e3.png" alt="text length and ratings" style="max-width:100%;"></a></p>
<p>It doesn't look like.<br>
Review length seems to be related to personal habits rather than restaurants' quality</p>
<ul>
<li><em>before fitting any model, how are our response variable distributed</em></li>
</ul>
<p><a href="https://user-images.githubusercontent.com/31863572/33521991-7f68d41e-d7af-11e7-912e-161ce27368b6.png" target="_blank"><img width="577" alt="emoji 1" src="https://user-images.githubusercontent.com/31863572/33521991-7f68d41e-d7af-11e7-912e-161ce27368b6.png" style="max-width:100%;"></a></p>
<p>The ratings are not normally distributed, we might want to use logit or multinomial models<br></p>
<ul>
<li><strong>logistic models</strong></li>
</ul>
<p>Try split the data into ratings higher than 3 stars and ratings lower than 3 stars<br></p>
<p><a href="https://user-images.githubusercontent.com/31863572/33521993-8bb28968-d7af-11e7-86c1-886fdfa2ba55.png" target="_blank"><img width="478" alt="emoji 2" src="https://user-images.githubusercontent.com/31863572/33521993-8bb28968-d7af-11e7-86c1-886fdfa2ba55.png" style="max-width:100%;"></a></p>
<ul>
<li><strong>multinomial models</strong></li>
</ul>
<p>Using chi square test for testing the goodness of fit</p>
<ul>
<li><strong>multilevel models</strong></li>
</ul>
<p>Still, linear multilevel models don't suit our data<br>
Therefore we try fitting multilevel logit models and multilevel multinomial models</p>
<ul>
<li><strong>multilevel logit models</strong></li>
</ul>
<p>Random Effect: Users' avarage rating on Yelp<br>
                           Restaurants' rating on Yelp</p>
</article>
  </div>

  </div>

  <button type="button" data-facebox="#jump-to-line" data-facebox-class="linejump" data-hotkey="l" class="d-none">Jump to Line</button>
  <div id="jump-to-line" style="display:none">
    <!-- '"` --><!-- </textarea></xmp> --></option></form><form accept-charset="UTF-8" action="" class="js-jump-to-line-form" method="get"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
      <input class="form-control linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" aria-label="Jump to line" autofocus>
      <button type="submit" class="btn">Go</button>
</form>  </div>

  </div>
  <div class="modal-backdrop js-touch-events"></div>
</div>

    </div>
  </div>

  </div>

      
<div class="footer container-lg px-3" role="contentinfo">
  <div class="position-relative d-flex flex-justify-between py-6 mt-6 f6 text-gray border-top border-gray-light ">
    <ul class="list-style-none d-flex flex-wrap ">
      <li class="mr-3">&copy; 2017 <span title="0.15613s from unicorn-3709793961-2n97j">GitHub</span>, Inc.</li>
        <li class="mr-3"><a href="https://github.com/site/terms" data-ga-click="Footer, go to terms, text:terms">Terms</a></li>
        <li class="mr-3"><a href="https://github.com/site/privacy" data-ga-click="Footer, go to privacy, text:privacy">Privacy</a></li>
        <li class="mr-3"><a href="https://github.com/security" data-ga-click="Footer, go to security, text:security">Security</a></li>
        <li class="mr-3"><a href="https://status.github.com/" data-ga-click="Footer, go to status, text:status">Status</a></li>
        <li><a href="https://help.github.com" data-ga-click="Footer, go to help, text:help">Help</a></li>
    </ul>

    <a href="https://github.com" aria-label="Homepage" class="footer-octicon" title="GitHub">
      <svg aria-hidden="true" class="octicon octicon-mark-github" height="24" version="1.1" viewBox="0 0 16 16" width="24"><path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0 0 16 8c0-4.42-3.58-8-8-8z"/></svg>
</a>
    <ul class="list-style-none d-flex flex-wrap ">
        <li class="mr-3"><a href="https://github.com/contact" data-ga-click="Footer, go to contact, text:contact">Contact GitHub</a></li>
      <li class="mr-3"><a href="https://developer.github.com" data-ga-click="Footer, go to api, text:api">API</a></li>
      <li class="mr-3"><a href="https://training.github.com" data-ga-click="Footer, go to training, text:training">Training</a></li>
      <li class="mr-3"><a href="https://shop.github.com" data-ga-click="Footer, go to shop, text:shop">Shop</a></li>
        <li class="mr-3"><a href="https://github.com/blog" data-ga-click="Footer, go to blog, text:blog">Blog</a></li>
        <li><a href="https://github.com/about" data-ga-click="Footer, go to about, text:about">About</a></li>

    </ul>
  </div>
</div>



  <div id="ajax-error-message" class="ajax-error-message flash flash-error">
    <svg aria-hidden="true" class="octicon octicon-alert" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M8.865 1.52c-.18-.31-.51-.5-.87-.5s-.69.19-.87.5L.275 13.5c-.18.31-.18.69 0 1 .19.31.52.5.87.5h13.7c.36 0 .69-.19.86-.5.17-.31.18-.69.01-1L8.865 1.52zM8.995 13h-2v-2h2v2zm0-3h-2V6h2v4z"/></svg>
    <button type="button" class="flash-close js-ajax-error-dismiss" aria-label="Dismiss error">
      <svg aria-hidden="true" class="octicon octicon-x" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M7.48 8l3.75 3.75-1.48 1.48L6 9.48l-3.75 3.75-1.48-1.48L4.52 8 .77 4.25l1.48-1.48L6 6.52l3.75-3.75 1.48 1.48z"/></svg>
    </button>
    You can't perform that action at this time.
  </div>


    
    <script crossorigin="anonymous" integrity="sha256-R7c3eUp64zkx0aUKgHD8RyBMQTxCRYqXgUMLHeA4450=" src="https://assets-cdn.github.com/assets/frameworks-47b737794a7ae33931d1a50a8070fc47204c413c42458a9781430b1de038e39d.js"></script>
    
    <script async="async" crossorigin="anonymous" integrity="sha256-Qkc87DGR10XKre61lV2syUoYE2acFhpZ4zg4WtwcvJA=" src="https://assets-cdn.github.com/assets/github-42473cec3191d745caadeeb5955dacc94a1813669c161a59e338385adc1cbc90.js"></script>
    
    
    
    
  <div class="js-stale-session-flash stale-session-flash flash flash-warn flash-banner d-none">
    <svg aria-hidden="true" class="octicon octicon-alert" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M8.865 1.52c-.18-.31-.51-.5-.87-.5s-.69.19-.87.5L.275 13.5c-.18.31-.18.69 0 1 .19.31.52.5.87.5h13.7c.36 0 .69-.19.86-.5.17-.31.18-.69.01-1L8.865 1.52zM8.995 13h-2v-2h2v2zm0-3h-2V6h2v4z"/></svg>
    <span class="signed-in-tab-flash">You signed in with another tab or window. <a href="">Reload</a> to refresh your session.</span>
    <span class="signed-out-tab-flash">You signed out in another tab or window. <a href="">Reload</a> to refresh your session.</span>
  </div>
  <div class="facebox" id="facebox" style="display:none;">
  <div class="facebox-popup">
    <div class="facebox-content" role="dialog" aria-labelledby="facebox-header" aria-describedby="facebox-description">
    </div>
    <button type="button" class="facebox-close js-facebox-close" aria-label="Close modal">
      <svg aria-hidden="true" class="octicon octicon-x" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M7.48 8l3.75 3.75-1.48 1.48L6 9.48l-3.75 3.75-1.48-1.48L4.52 8 .77 4.25l1.48-1.48L6 6.52l3.75-3.75 1.48 1.48z"/></svg>
    </button>
  </div>
</div>


  </body>
</html>
=======
# Predict Ratings for Chinese Restaurants using Sentiment Analysis 
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


- **multinomial models** 

Using chi square test for testing the goodness of fit

- **multilevel models** 

Still, linear multilevel models don't suit our data<br />
Therefore we try fitting multilevel logit models and multilevel multinomial models

- **multilevel logit models** 

Random Effect: Users' avarage rating on Yelp<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Restaurants' rating on Yelp






