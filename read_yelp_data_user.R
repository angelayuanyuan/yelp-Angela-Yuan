#######################
#### Read JSON File####
#######################

## This file will create and save 3 dataframes
## dataframe 1: basic information including # of elite years & # of friends
## dataframe 2: detailed information about friends
## dataframe 3: detailed information about elite years

# clear memory
rm(list = ls())

# load packages
library(jsonlite)
library(lubridate)

# load the original data
setwd("~/Desktop/yelp data challenge/Yelp data")
txt = readLines("raw_data/user.json")
print("original user data loaded")

# number of chunks for initial processing
n_chunk = 1000

# number of lines to read per chunk except the last one
n_lines = round(length(txt)/n_chunk)

# current chunk of data
c_chunk = txt[1:n_lines]


################################################
# process the first chunk of data
data_chunk = lapply(c_chunk, fromJSON)

## functions to extract information about friends
# find number of friends
find_n_friends = function(row_user){
  return(length(row_user$friends)) 
}

# find id of friends
find_id_friends = function(row_user){
  return(paste(row_user$friends, collapse = " * "))
}

n_friends = sapply(data_chunk, find_n_friends)
friends_id = sapply(data_chunk, find_id_friends)

## function sto extract information about elite status
# find number of years of elite status
find_n_elite = function(row_user){
  return(length(row_user$elite))
}

# find the earlist year of elite status
find_min_elite = function(row_user){
  if (length(row_user$elite) > 0){
    return(min(row_user$elite))
  } else{
    return(NA)
  }
}

# find the latest year of elite status
find_max_elite = function(row_user){
  if (length(row_user$elite) > 0){
    return(max(row_user$elite))
  } else{
    return(NA)
  }
}

# find all elite years
find_elite_years = function(row_user){
  if (length(row_user$elite) > 0){
    return(paste(row_user$elite, collapse = ", "))
  } else{
    return(NA)
  }
} 

n_elite = sapply(data_chunk, find_n_elite)
min_elite = sapply(data_chunk, find_min_elite)
max_elite = sapply(data_chunk, find_max_elite)
elite_years = sapply(data_chunk, find_elite_years)

# a function to retrieve basic user information
cnames = names(data_chunk[[1]])[-c(5, 10)]
retrieve_u_info = function(cname){
  ru = function(row_user){
    if(is.null(row_user[[cname]])) {
      NA
    } else row_user[[cname]]
  }
  return(sapply(data_chunk, ru))
}

# create the dataframe related to basic business information
df_user_info = data.frame(retrieve_u_info(cnames[1]), stringsAsFactors = F)
for (i in 2:length(cnames)){
  information = retrieve_u_info(cnames[i])
  df_user_info = data.frame(df_user_info, information,
                            stringsAsFactors = F)
}
colnames(df_user_info) = cnames
df_user_info = data.frame(df_user_info, n_friends, n_elite,
                          stringsAsFactors = F)
rm("information")
print("Chunk 1 processing finished")


################################################
## process the rest of the data
for (i in 2:n_chunk){
  
  # load data
  if (i < n_chunk){
    c_chunk = txt[seq(from = (i-1)*n_lines+1, to = i*n_lines)]
  } else{
    c_chunk = txt[seq(from = (i-1)*n_lines+1, to = length(txt))]
  }
  data_chunk = lapply(c_chunk, fromJSON)
  
  # information about friends
  n_friends = sapply(data_chunk, find_n_friends)
  friends_id_temp = sapply(data_chunk, find_id_friends)
  friends_id = c(friends_id, friends_id_temp)
  rm("friends_id_temp")
  
  # information about elite status
  n_elite = sapply(data_chunk, find_n_elite)
  min_elite_temp = sapply(data_chunk, find_min_elite)
  min_elite = c(min_elite, min_elite_temp)
  max_elite_temp = sapply(data_chunk, find_max_elite)
  max_elite = c(max_elite, max_elite_temp)
  elite_years_temp = sapply(data_chunk, find_elite_years)
  elite_years = c(elite_years, elite_years_temp)
  rm(list = c("min_elite_temp", "max_elite_temp", "elite_years_temp"))
  
  # dataframe related to basic business information
  df_user_info_temp = data.frame(retrieve_u_info(cnames[1]), stringsAsFactors = F)
  for (j in 2:length(cnames)){
    information = retrieve_u_info(cnames[j])
    df_user_info_temp = data.frame(df_user_info_temp, information,
                                   stringsAsFactors = F)
  }
  colnames(df_user_info_temp) = cnames
  df_user_info_temp = data.frame(df_user_info_temp, n_friends, n_elite,
                                 stringsAsFactors = F)
  df_user_info = rbind(df_user_info, df_user_info_temp)
  rm(list = c("df_user_info_temp", "information"))
  print(paste("chunk", i, "processing finished"))
}
df_user_info$yelping_since = ymd(df_user_info$yelping_since)

rm(list = c("c_chunk", "data_chunk", "i", "j"))
print("dataframe for basic user information created")
save(df_user_info, file = "rdata/user_info.Rdata")
print("dataframe for basic user information saved to an Rdata file")


################################################
# create a dataframe regarding friends information
df_user_friends = data.frame(df_user_info$user_id, df_user_info$n_friends, friends_id,
                             stringsAsFactors = F)
colnames(df_user_friends) = c("user_id", "n_friends", "friends_id")
print("dataframe for friends information created")
save(df_user_friends, file = "rdata/user_friends.Rdata")
print("dataframe for friends information saved to an Rdata file")


################################################
# create a dataframe regarding elite status
year_earlist = min(min_elite, na.rm = T)
year_latest = max(max_elite, na.rm = T)
cname_elite = paste0("Y", year_earlist:year_latest)

# create a function to show elite status of each user for each year
find_elite_status = function(year){
  es = function(row_user){
    if(grepl(pattern = year, row_user)){
      return("yes")
    } else return("no")
  }
  return(sapply(elite_years, es))
}

df_user_elite = data.frame(df_user_info$user_id, stringsAsFactors = F)
for (i in year_earlist:year_latest){
  elite_status = find_elite_status(i)
  elite_status = as.factor(elite_status)
  df_user_elite = data.frame(df_user_elite, elite_status, stringsAsFactors = F)
}
colnames(df_user_elite) = c("user_id", cname_elite)
print("dataframe for elite status created")
save(df_user_elite, file = "rdata/user_elite.Rdata")
print("dataframe for elite information saved to an Rdata file")
