#######################
#### Read JSON File####
#######################

# clear memory
rm(list = ls())

# load packages
library(jsonlite)

## create business dataframe

setwd("~/Desktop/yelp data challenge/Yelp data")
business_data_original = lapply(readLines("raw_data/business.json"), fromJSON)
print("original data loaded")

#######################

# create dataframe related to business hours
# business id

business_id = sapply(business_data_original, function(x){x$business_id})

# extract business hour information
day_f = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday","Saturday", "Sunday")

fill_df_business_hours = function(row_business){
  row = rep(NA, times = 7)
  for (i in 1:7){
    if (!is.null(row_business$hours[[day_f[i]]])){
      row[i] = row_business$hours[[day_f[i]]]
    }
  }
  return(row)
}

# create a temporary matrix to store the business hours
hours_temp = sapply(business_data_original, fill_df_business_hours)
hours_temp = t(hours_temp)

# function to split opening and closing time of each day
split_open_close = function(daily_hours_temp){
  if (is.na(daily_hours_temp)){
    daily_open_close = c(NA, NA)
  } else{
    daily_open_close = strsplit(daily_hours_temp, split = "-")
  }
return(daily_open_close)
}

# create a matrix with opening and closing time of each day
vector_temp = unlist(sapply(hours_temp[, 1], split_open_close))
open_close = matrix(vector_temp, ncol = 2, byrow = T)
for (i in 2:7){
  vector_temp = unlist(sapply(hours_temp[, i], split_open_close))
  open_close = cbind(open_close, matrix(vector_temp, ncol = 2, byrow = T))
}

# create col names for the dataframe regarding business hours
# M = Monday, T = Tuesday, W = Wednesday, TH = Thursday
# F = Friday, S = Saturday, SU = Sunday
# O = Opening, C = Closing
day = c("M_", "T_", "W_", "TH_", "F_", "S_", "SU_")
cname_business_hours = c("business_id", as.vector(sapply(day, paste0, c("O", "C"))))

# create the dataframe regarding business hours
df_business_hours = data.frame(business_id, open_close, stringsAsFactors = F)
colnames(df_business_hours) = cname_business_hours
print("dataframe for business hours created")

# save the dataframe regarding business hours in an Rdata file
save(df_business_hours, file = "rdata/business_hours.Rdata")
print("dataframe for business hours saved to an Rdata file")

# remove temporary variables
rm(list = c("hours_temp", "open_close", "cname_business_hours",
            "day", "day_f", "i", "vector_temp"))

# create dataframe related to business hours
# business id
business_id = sapply(business_data_original, function(x){x$business_id})

# function to extract business hour information
day_f = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday","Saturday", "Sunday")

fill_df_business_hours = function(row_business){
  row = rep(NA, times = 7)
  for (i in 1:7){
    if (!is.null(row_business$hours[[day_f[i]]])){
      row[i] = row_business$hours[[day_f[i]]]
    }
  }
  return(row)
}

# create a temporary matrix to store the business hours
hours_temp = sapply(business_data_original, fill_df_business_hours)
hours_temp = t(hours_temp)

# function to split opening and closing time of each day
split_open_close = function(daily_hours_temp){
  if (is.na(daily_hours_temp)){
    daily_open_close = c(NA, NA)
  } else{
    daily_open_close = strsplit(daily_hours_temp, split = "-")
  }
  return(daily_open_close)
}

# create a matrix with opening and closing time of each day
vector_temp = unlist(sapply(hours_temp[, 1], split_open_close))
open_close = matrix(vector_temp, ncol = 2, byrow = T)
for (i in 2:7){
  vector_temp = unlist(sapply(hours_temp[, i], split_open_close))
  open_close = cbind(open_close, matrix(vector_temp, ncol = 2, byrow = T))
}

# create col names for the dataframe regarding business hours
# M = Monday, T = Tuesday, W = Wednesday, TH = Thursday
# F = Friday, S = Saturday, SU = Sunday
# O = Opening, C = Closing
day = c("M_", "T_", "W_", "TH_", "F_", "S_", "SU_")
cname_business_hours = c("business_id", as.vector(sapply(day, paste0, c("O", "C"))))

# create the dataframe regarding business hours
df_business_hours = data.frame(business_id, open_close, stringsAsFactors = F)
colnames(df_business_hours) = cname_business_hours
print("dataframe for business hours created")

# save the dataframe regarding business hours in an Rdata file
save(df_business_hours, file = "rdata/business_hours.Rdata")
print("dataframe for business hours saved to an Rdata file")

# remove temporary variables
rm(list = c("hours_temp", "open_close", "cname_business_hours",
            "day", "day_f", "i", "vector_temp"))


############################################
# create a dataframe related to business attributes
# create a list of all possible attributes
all_attributes = names(unlist(business_data_original[[1]]$attributes))
for (i in 2:length(business_data_original)){
  attributes_temp = names(unlist(business_data_original[[i]]$attributes))
  all_attributes = union(all_attributes, attributes_temp)
}
rm("attributes_temp")

# a function to find nested attributes
is.nested = function(att){
  return(grepl(att, pattern = "\\."))
}

# a function to retrieve information
retrieve_att = function(att){
  if (is.nested(att)){
    name1 = strsplit(att, "\\.")[[1]][1]
    name2 = strsplit(att, "\\.")[[1]][2]
    ra1 = function(row_business){
      if(is.null(row_business$attributes[[name1]][[name2]])) {
        NA
      } else row_business$attributes[[name1]][[name2]]
    }
    return(sapply(business_data_original, ra1))
  } else{
    ra2 = function(row_business){
      if(is.null(row_business$attributes[[att]])) {
        NA
      } else row_business$attributes[[att]]
    }
    return(sapply(business_data_original, ra2))
  }
}

# create the dataframe related to business attributes
df_business_attributes = data.frame(retrieve_att(all_attributes[1]))
for (i in 2:length(all_attributes)){
  attribute = retrieve_att(all_attributes[i])
  df_business_attributes = data.frame(df_business_attributes, attribute)
  print(i)
}
df_business_attributes = data.frame(business_id, df_business_attributes,
                                    stringsAsFactors = F)
colnames(df_business_attributes) = c("business_id", all_attributes)
rm(list = c("attribute", "i", "all_attributes"))
print("dataframe for business attributes created")

# save the dataframe to an Rdata file
save(df_business_attributes, file = "rdata/business_attributes.Rdata")
print("dataframe for business attributes saved to an Rdata file")


###########################################
# create a dataframe related to basic business information
# create a list of all columns containing basic information
b_info = names(business_data_original[[1]])
for (i in 1:length(business_data_original)){
  b_info_temp = names(business_data_original[[i]])
  b_info = union(b_info, b_info_temp)
}
rm(list = c("b_info_temp", "i"))
b_info = b_info[-grep(b_info, pattern = "hours|attributes" )]
b_info = b_info[c(-1, -13)]

# converting category information into a string
collect_category = function(row_business){
  if (length(row_business$categories) > 0){
    return(paste(row_business$categories, collapse = " * "))
  } else {
    return(NA)
  }
}
categories = sapply(business_data_original, collect_category)

# a function to retrieve basic information
retrieve_b_info = function(binfo){
  rb = function(row_business){
    if(is.null(row_business[[binfo]])) {
      NA
    } else row_business[[binfo]]
  }
  return(sapply(business_data_original, rb))
}

# create the dataframe related to basic business information
df_business_info = data.frame(retrieve_b_info(b_info[1]), stringsAsFactors = F)
for (i in 2:length(b_info)){
  information = retrieve_b_info(b_info[i])
  df_business_info = data.frame(df_business_info, information, 
                                stringsAsFactors = F)
}
colnames(df_business_info) = b_info
df_business_info = data.frame(business_id, df_business_info, categories,
                              stringsAsFactors = F)
df_business_info$state = as.factor(df_business_info$state)
df_business_info$is_open = as.logical(df_business_info$is_open)
rm(list = c("b_info", "i", "information", "categories"))
print("dataframe for basic business information created")

# save the dataframe for basic information to an Rdata file
save(df_business_info, file = "rdata/business_info.Rdata")
print("dataframe for basic information saved to Rdata file")


  