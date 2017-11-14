#######################
#### Read JSON File####
#######################

# clear memory
rm(list = ls())

# load packages
library(jsonlite)
library(lubridate)

## SET YOUR WORKING DIRECTORY HERE WITH setwd() ##

# load the original data
tip_data_original = lapply(readLines("raw_data/tip.json"), fromJSON)
print("original data loaded")


######################################
# create the dataframe
df_tip = sapply(tip_data_original, unlist)
df_tip = t(df_tip)
df_tip = data.frame(df_tip, stringsAsFactors = F)
df_tip$date = ymd(df_tip$date)
df_tip$likes = as.numeric(df_tip$likes)
print("dataframe created")

# save tip dataframe to an rdata file
save(df_tip, file = "rdata/tip.Rdata")
print("Rdata file saved")