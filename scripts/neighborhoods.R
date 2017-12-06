library(dplyr)
library(httr)
library(XML)
source('./scripts/api_keys.R')

url.full <- 'http://www.zillow.com/webservice/GetRegionChildren.htm'
query.params <- list('zws-id' = zillow.api.key, state = 'Washington', county = 'King', city = 'Seattle', childtype = 'neighborhood')
response <- GET(url.full, query = query.params)
body <- content(response, 'text')
results <- xmlToList(body)
regions <- results$response$list

SeparateRegions <- function(single.region) {
  zindex <- single.region$zindex$text
  if(is.null(zindex)){
    zindex <- 'NA'
  } 
  region.df <- data.frame(single.region$name, single.region$latitude,
                          single.region$longitude, single.region$url, zindex)
  colnames(region.df) <- c("Neighborhood", "Latitude", "Longitude", "URL", "Zindex")
  return(region.df)
}

parsed.regions <- SeparateRegions(regions[2]$region) 
colnames(parsed.regions) <- c("Neighborhood", "Latitude", "Longitude", "URL", "Zindex")
total.neighborhoods <- as.numeric(regions$count)

for(i in 3:(total.neighborhoods + 1)) {
  parsed.regions <- bind_rows(parsed.regions, SeparateRegions(regions[i]$region))
}
# Alphabetize data
parsed.regions <- arrange(parsed.regions, Neighborhood)
