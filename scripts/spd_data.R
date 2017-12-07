library(httr)
library(jsonlite)
library(dplyr)

source('./scripts/api_keys.R')

GetSPDData <- function() {
  response <- GET("https://data.seattle.gov/resource/y7pv-r3kh.json?$limit=5000&$order=date_reported%20DESC", 
                  add_headers("X-API-Key" = seattle.app.token))
  body <- content(response, "text")
  data <- fromJSON(body)
  final.data <- data %>% 
    select(date_reported, latitude, longitude, summarized_offense_description, offense_type)
  final.data$latitude <- as.numeric(as.character(final.data$latitude))
  final.data$longitude <- as.numeric(as.character(final.data$longitude))
  return(final.data)
}

misdemeanors <- c("ANIMAL COMPLAINT", "ASSAULT", "BIKE THEFT", "CAR PROWL", "COUNTERFEIT", "DISORDERLY CONDUCT", "DISPUTE", 
                  "DUI", "FIREWORK", "INJURY", "OBSTRUCT", "OTHER PROPERTY", "PICKPOCKET", "PROPERTY DAMAGE", "PROSTITUTION",
                  "RECOVERED PROPERTY", "STOLEN PROPERTY", "THEFT OF SERVICE", "THREATS", "TRAFFIC", "TRESSPASS")

felonies <- c("BURGLARY", "BURGLARY-SECURE PARKING-RES", "ELUDING", "EMBEZZLE", "FORGERY", "FRAUD", "HOMICIDE", "MAIL THEFT",
              "NARCOTICS", "PORNOGRAPHY", "RECKLESS BURNING", "ROBERRY", "SHOPLIFTING", "STOLEN PROPERTY", "VEHICLE THEFT",
              "VIOLATION OF COURT ORDER", "WARRANT ARREST", "LOST PROPERTY")

offense.types <- unique(full.data$offense_type)

full.data <- GetSPDData()

mis.data <- full.data %>%
  filter(summarized_offense_description %in% misdemeanors)

fel.data <- full.data %>%
  filter(summarized_offense_description %in% felonies)





