# connect to sql database
library(RMySQL)
mydb = dbConnect(MySQL(), user='mssp', password='mssp2017', dbname='yelp_db', host='45.63.90.29')

# check out the review data
dbListTables(mydb)
dbListFields(mydb, 'review') 

# retrieve reviews on Chinese restaurants from the database and save them as dataframe in r
review.sql = dbSendQuery(mydb, "SELECT * FROM review WHERE text LIKE '%Chinese%'")  
review = fetch(review.sql, n = -1)
save(review, file = "review.chinese.Rdata")
