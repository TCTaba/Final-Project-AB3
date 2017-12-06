library(plotly)

source('./scripts/api_keys.R')
source('./scripts/spd_data.R')
source('./scripts/zillow_data.R')
source('./scripts/neighborhoods.R')

PlotDataAddress <- function(df, address_street, address_CSZ) {
  house.data <- FindHouseData(address_street, address_CSZ)
  p <- df %>%
    plot_mapbox(lat = ~latitude, lon = ~longitude,
                split = ~summarized_offense_description,
                mode = 'scattermapbox', hoverinfo=~date_reported) %>%
    layout(font = list(color='white'),
           autosize=TRUE,
           plot_bgcolor = '#191A1A', paper_bgcolor = '#191A1A',
           mapbox = list(style = 'dark',
                         zoom = 15,
                         center = list(lat = house.data$lat,
                                       lon = house.data$long)),
           legend = list(orientation = 'v',
                         font = list(size = 8)),
           margin = list(l = 0, r = 0,
                         b = 0, t = 0,
                         pad = 0))
  return(p)
}

PlotDataNeighborhood <- function(df, neighborhood) {
  location <- parsed.regions %>% filter(Neighborhood == neighborhood)
  p <- df %>%
    plot_mapbox(lat = ~latitude, lon = ~longitude,
                split = ~summarized_offense_description,
                mode = 'scattermapbox', hoverinfo=~date_reported) %>%
    layout(font = list(color='white'),
           plot_bgcolor = '#191A1A', paper_bgcolor = '#191A1A',
           autosize = TRUE, 
           mapbox = list(style = 'dark',
                         zoom = 12,
                         center = list(lat = location$Latitude,
                                       lon = location$Longitude)),
           legend = list(orientation = 'v',
                         font = list(size = 8)),
           margin = list(l = 0, r = 0,
                         b = 0, t = 0,
                         pad = 0))
  return(p)
}
