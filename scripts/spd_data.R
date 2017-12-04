library(httr)
library(jsonlite)
library(dplyr)

setwd('/Users/nsundaresan/Google Drive/College/Autumn 2017/INFO 201/Final-Project-AB3')
source('scripts/api_keys.R')

GetSPDData <- function() {
  response <- GET("https://data.seattle.gov/resource/y7pv-r3kh.json?$limit=5000&$order=date_reported%20DESC", add_headers("X-API-Key" = seattle.app.token))
  body <- content(response, "text")
  data <- fromJSON(body)
  final.data <- data %>% 
    select(date_reported, latitude, longitude, summarized_offense_description)
  return(final.data)
}

thing2 <- GetSPDData()