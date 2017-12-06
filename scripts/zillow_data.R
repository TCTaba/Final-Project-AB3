library(jsonlite)
library(httr)
library(XML)

source('./scripts/api_keys.R')

# Find data for specific house, need the address, city, state, and zipcode to search API
FindHouseData <- function(my.address, my.citystatezip){
  # Access Zillow DeepSearchResults API
  url.full <- 'https://www.zillow.com/webservice/GetDeepSearchResults.htm'
  query.params <- list('zws-id' = zillow.api.key, address = my.address, citystatezip = my.citystatezip)
  response <- GET(url.full, query = query.params)
  body <- content(response, 'text')
  # Results are in XML instead of JSON, and xmlToDataFrame doesn't display data correctly
  results <- xmlToList(body)
  
  house.data <- data.frame(address = paste(results$request$address,
                                           results$request$citystatezip),
                           price = paste0('$', results$response$results$result$zestimate$amount$text),
                           bed = results$response$results$result$bedrooms,
                           bath = results$response$results$result$bathrooms,
                           year = results$response$results$result$yearBuilt,
                           sqFt = results$response$results$result$finishedSqFt,
                           lat = results$response$results$result$address$latitude,
                           long = results$response$results$result$address$longitude)
  return(house.data)
}
