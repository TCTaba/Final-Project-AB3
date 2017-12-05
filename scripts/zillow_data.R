library(jsonlite)
library(httr)
library(XML)

source('api_keys.R')

url.full <- 'https://www.zillow.com/webservice/GetDeepSearchResults.htm'
query.params <- list('zws-id' = zillow.api.key, address = '315 Howe St', citystatezip = 'Seattle, WA 98109')
response <- GET(url.full, query = query.params)
body <- content(response, 'text')
results <- xmlToList(body)

house.data <- data.frame(address = paste0(results$response$results$result$address$street, " ",
                                         results$response$results$result$address$city, ", ",
                                           results$response$results$result$address$state, " ",
                                           results$response$results$result$address$zipcode),
                   price = paste0('$', results$response$results$result$zestimate$amount$text),
                   bed = results$response$results$result$bedrooms,
                   bath = results$response$results$result$bathrooms,
                   year = results$response$results$result$yearBuilt)

# url.full.2 <- 'http://www.zillow.com/webservice/GetDeepComps.htm'
# query.params.2 <- list('zws-id' = zillow.api.key, zpid = results$response$results$result$zpid, count = 25)
# response.2 <- GET(url.full, query = query.params)
# body.2 <- content(response, 'text')
# results.2 <- xmlToList(body)
