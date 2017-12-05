library(dplyr)
library(httr)
library(XML)
api.key <- 'X1-ZWz18wrwx5uvpn_38l6u'

url.full <- 'http://www.zillow.com/webservice/GetRegionChildren.htm'
query.params <- list('zws-id' = api.key, state = 'Washington', county = 'King', city = 'Seattle', childtype = 'neighborhood')
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
  colnames(region.df) <- c("Region Name", "Latitude", "Longitude", "URL", "Zindex")
  return(region.df)
}

parsed.regions <- SeparateRegions(regions[2]$region) 
colnames(parsed.regions) <- c("Region Name", "Latitude", "Longitude", "URL", "Zindex")

for(i in 3:103) {
  parsed.regions <- bind_rows(parsed.regions, SeparateRegions(regions[i]$region))
}
