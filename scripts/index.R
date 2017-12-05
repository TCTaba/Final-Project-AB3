library(httr)
library(jsonlite)
library(dplyr)
library(plotly)
library(RColorBrewer)

source('./scripts/api_keys.R')

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