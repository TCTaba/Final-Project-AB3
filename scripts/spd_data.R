library(httr)
library(jsonlite)
library(dplyr)
library(plotly)

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

full.data <- GetSPDData()

mis.data <- full.data %>%
  filter(summarized_offense_description %in% misdemeanors)

fel.data <- full.data %>%
  filter(summarized_offense_description %in% felonies)

PlotData <- function(df) {
  p <- df %>%
    plot_mapbox(lat = ~latitude, lon = ~longitude,
                split = ~summarized_offense_description,
                mode = 'scattermapbox', hoverinfo=~date_reported) %>%
    layout(font = list(color='white'),
           plot_bgcolor = '#191A1A', paper_bgcolor = '#191A1A',
           mapbox = list(style = 'dark',
                         zoom = 10.0,
                         center = list(lat = median(df$latitude),
                                       lon = median(df$longitude))),
           legend = list(orientation = 'v',
                         font = list(size = 8)),
           margin = list(l = 0, r = 0,
                         b = 0, t = 0,
                         pad = 0))
  
  return(p)
}




