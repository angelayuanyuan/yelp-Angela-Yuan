#######################
#### Read JSON File####
#######################

# clear memory
rm(list = ls())
setwd("~/Desktop/yelp data challenge/Yelp data")

# load packages
library(jsonlite)

# load the original data
checkin_data_original = lapply(readLines("raw_data/checkin.json"), fromJSON)
print("original data loaded")

###########################################
# function used to fill the dataframe
day_f = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
hour_f = rep(NA, times = 24)

for (h in 1:24){
  hour_f[h] = paste0(h-1, ":00")
}

fill_df_checkin = function(row_checkin){
  row = rep(NA, times = length(cnames_checkin))
  row[1] = row_checkin$business_id
  for (i in 1:7){
    for (j in 1:24){
      if (!is.null(row_checkin$time[[day_f[i]]][[hour_f[j]]])){
        row[(i-1)*24 + j + 1] = row_checkin$time[[day_f[i]]][[hour_f[j]]]
      }
    }
  }
  return(row)
}

# create col names for the dataframe
# M = Monday, T = Tuesday, W = Wednesday, TH = Thursday
# F = Friday, S = Saturday, SU = Sunday
day = c("M_", "T_", "W_", "TH_", "F_", "S_", "SU_")
dayhour = as.vector(sapply(day, paste0, 0:23))
cnames_checkin = c("business_id", dayhour)

# create the dataframe
df_checkin = sapply(checkin_data_original, fill_df_checkin)
df_checkin = t(df_checkin)
df_checkin = data.frame(df_checkin, stringsAsFactors = F)
for (i in 2:ncol(df_checkin)){
  df_checkin[, i] = as.numeric(df_checkin[, i])
}
colnames(df_checkin) = cnames_checkin
print("check in dataframe prepared")

# save the dataframe to an rdata file
save(df_checkin, file = "rdata/checkin.Rdata")
print("file saved")


