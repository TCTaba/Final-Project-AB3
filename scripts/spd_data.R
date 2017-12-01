library(httr)
library(jsonlite)
library(dplyr)

source("api_keys.R")

response <- GET(paste("https://data.seattle.gov/resource/y7pv-r3kh.json?%24%24app_token=", seattle_app_token, "&$order=:id", sep=""))
body <- content(response, "text")
parsed.data <- fromJSON(body)