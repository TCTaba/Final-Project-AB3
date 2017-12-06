library(dplyr)
library(httr)
library(XML)
source('./scripts/api_keys.R')

options(warn=-1)

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
  region.df <- data.frame(as.character(single.region$name), as.character(single.region$latitude),
                          as.character(single.region$longitude), as.character(single.region$url), as.character(zindex))
  colnames(region.df) <- c("Neighborhood", "Latitude", "Longitude", "URL", "Zindex")
  return(region.df)
}

parsed.regions <- SeparateRegions(regions[2]$region) 
colnames(parsed.regions) <- c("Neighborhood", "Latitude", "Longitude", "URL", "Zindex")
total.neighborhoods <- length(regions)

for(i in 3:(total.neighborhoods)) {
  parsed.regions <- union(SeparateRegions(regions[i]$region), parsed.regions)
}

# Alphabetize data
parsed.regions <- arrange(parsed.regions, Neighborhood)
