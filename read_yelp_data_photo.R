#######################
#### Read JSON File####
#######################

# clear memory
rm(list = ls())

# load packages
library(jsonlite)


# load the original data
setwd("~/Desktop/yelp data challenge/Yelp data")
photos_data_original = lapply(readLines("raw_data/photos.json"), fromJSON)
print("original data loaded")


##########################################
# create the dataframe
df_photos = sapply(photos_data_original, unlist)
df_photos = t(df_photos)
df_photos = data.frame(df_photos, stringsAsFactors = F)
df_photos$label = as.factor(df_photos$label)
print("dataframe created")

# save photos dataframe to an rdata file
save(df_photos, file = "rdata/photos.Rdata")
print("Rdata file saved")
