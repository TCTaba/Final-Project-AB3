library(httr)
library(jsonlite)
library(dplyr)

source('./scripts/api_keys.R')

response <- GET("https://data.seattle.gov/resource/y7pv-r3kh.json?$limit=5000&$order=date_reported%20DESC", 
                add_headers("X-API-Key" = seattle.app.token))
body <- content(response, "text")
final.data <- fromJSON(body) %>% 
  select(date_reported, latitude, longitude, summarized_offense_description, offense_type)
full.data <- add_count(final.data, summarized_offense_description, sort = TRUE)
full.data$latitude <- as.numeric(as.character(final.data$latitude))
full.data$longitude <- as.numeric(as.character(final.data$longitude))

misdemeanors <- c("ANIMAL COMPLAINT", "ASSAULT", "BIKE THEFT", "CAR PROWL", "COUNTERFEIT", "DISORDERLY CONDUCT", "DISPUTE", 
                  "DUI", "FIREWORK", "INJURY", "OBSTRUCT", "OTHER PROPERTY", "PICKPOCKET", "PROPERTY DAMAGE", "PROSTITUTION",
                  "RECOVERED PROPERTY", "STOLEN PROPERTY", "THEFT OF SERVICE", "THREATS", "TRAFFIC", "TRESSPASS")

felonies <- c("BURGLARY", "BURGLARY-SECURE PARKING-RES", "ELUDING", "EMBEZZLE", "FORGERY", "FRAUD", "HOMICIDE", "MAIL THEFT",
              "NARCOTICS", "PORNOGRAPHY", "RECKLESS BURNING", "ROBERRY", "SHOPLIFTING", "STOLEN PROPERTY", "VEHICLE THEFT",
              "VIOLATION OF COURT ORDER", "WARRANT ARREST", "LOST PROPERTY")

offense.types <- unique(final.data$offense_type)
offense.names <- read.csv('scripts/offense_types.csv', stringsAsFactors = FALSE)

mis.data <- full.data %>%
  filter(summarized_offense_description %in% misdemeanors)

fel.data <- full.data %>%
  filter(summarized_offense_description %in% felonies)

mis.data$expanded<-offense.names[match(mis.data$offense_type, offense.names$offense_type),2]
fel.data$expanded<-offense.names[match(fel.data$offense_type, offense.names$offense_type),2]
full.data$expanded<-offense.names[match(full.data$offense_type, offense.names$offense_type),2]


