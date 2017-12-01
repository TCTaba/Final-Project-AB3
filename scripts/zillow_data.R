url.full <- 'http://www.zillow.com/webservice/GetRegionChildren.htm'
query.params <- list('zws-id' = api.key, state = 'Washington', childtype = 'neighborhood')
response <- GET(url.full, query = query.params)
body <- content(response, 'text')
results <- xmlToList(body)

test <- toJSON(results)
