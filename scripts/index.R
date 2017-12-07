library(plotly)

source('./scripts/api_keys.R')
source('./scripts/spd_data.R')
source('./scripts/zillow_data.R')
source('./scripts/neighborhoods.R')


PlotDataAddress <- function(df, address_street, address_CSZ) {
  house.data <- FindHouseData(address_street, address_CSZ)
  house.info <- sprintf("Address: %s", house.data$address[1])
  p <- plot_mapbox(mode = 'scattermapbox') %>%
    layout(font = list(color='white'), autosize = TRUE,
         plot_bgcolor = '#191A1A', paper_bgcolor = '#191A1A',
         mapbox = list(style = 'dark',
                       zoom = 15,
                       center = list(lat = house.data$lat,
                                     lon = house.data$long)),
         legend = list(orientation = 'v',
                       font = list(size = 10)),
         margin = list(l = 0, r = 0,
                       b = 0, t = 0,
                       pad = 0))%>%
    add_markers(data = df, x = ~longitude, y = ~latitude, text=~expanded,
                hoverinfo = "text", split=~summarized_offense_description) %>%
    add_markers(data = house.data, x = ~long, y = ~lat, text = ~paste(house.data$address, 
                                                                      paste("Zestimate (Zillow's Estimated Market Value):", house.data$price), 
                                                                      paste("Bed:", house.data$bed), 
                                                                      paste("Bath:", house.data$bath),
                                                                      paste("Year:", house.data$year), 
                                                                      paste("Square Feet:", house.data$sqFt), 
                                                                      sep = "<br />"), 
                hoverinfo = "text",
                symbol = I("star"),
                split = ~address,
                marker = list(size = 20)
                )
  
  return(p)
}

PlotDataNeighborhood <- function(df, neighborhood) {
  location <- parsed.regions %>% filter(Neighborhood == neighborhood)
  p <- df %>%
    plot_mapbox(lat = ~latitude, lon = ~longitude,
                split = ~summarized_offense_description,
                mode = 'scattermapbox', text=~expanded, hoverinfo = "text") %>%
    layout(font = list(color='white'),
           plot_bgcolor = '#191A1A', paper_bgcolor = '#191A1A',
           autosize = TRUE, 
           mapbox = list(style = 'dark',
                         zoom = 13.5,
                         center = list(lat = location$Latitude,
                                       lon = location$Longitude)),
           legend = list(orientation = 'v',
                         font = list(size = 10)),
           margin = list(l = 0, r = 0,
                         b = 0, t = 0,
                         pad = 0))

  return(p)
}

# Insights
most.common.fel <- fel.data %>% 
  count(summarized_offense_description) %>% 
  filter(n == max(n))
most.common.mis <- mis.data %>% 
  count(summarized_offense_description) %>% 
  filter(n == max(n))

neighborhoods.with.zindex <- parsed.regions %>% 
  filter(Zindex != 'NA')
most.expensive.neighborhood <- neighborhoods.with.zindex %>% 
  filter(Zindex == max(as.numeric(Zindex)))
least.expensive.neighborhood <- neighborhoods.with.zindex %>% 
  filter(Zindex == min(as.numeric(Zindex)))
mean.cost <- neighborhoods.with.zindex %>% 
  summarise(mean = round(mean(as.numeric(Zindex))))
median.cost <- neighborhoods.with.zindex %>% 
  summarise(median = median(as.numeric(Zindex)))


