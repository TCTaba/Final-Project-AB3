library(jsonlite)
library(dplyr)
library(httr)
library(XML)
api.key <- 'X1-ZWz18wrwx5uvpn_38l6u'

url.full <- 'http://www.zillow.com/webservice/GetRegionChildren.htm'
query.params <- list('zws-id' = api.key, state = 'Washington', childtype = 'neighborhood')
response <- GET(url.full, query = query.params)
body <- content(response, 'text')
results <- xmlToList(body)
regions <- results$response$list
count <- 1
# 106 regions
print(regions[3])
#write.csv(results, "xmldata.csv", row.names = FALSE)

#regions <- results$response