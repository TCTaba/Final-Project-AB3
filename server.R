library(shiny)
library(dplyr)
library(tidyr)

source("./scripts/index.R")
source("./scripts/api_keys.R")
source("./scripts/zillow_data.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$neighborhoodPlot <- renderPlotly({
    
    if(input$type.var == "mis") {
      PlotDataNeighborhood(mis.data, input$neighborhood.var)
    } else if (input$type.var == "fel") {
      PlotDataNeighborhood(fel.data, input$neighborhood.var)
    } else {
      PlotDataNeighborhood(full.data, input$neighborhood.var)
    }
  })
 
   output$addressPlot <- renderPlotly({
     
    input$goButton
    if(input$check.var == "mis") {
      PlotDataAddress(mis.data, isolate(input$street.var), isolate(input$csz.var))
    } else if (input$check.var == "fel") {
      PlotDataAddress(fel.data, isolate(input$street.var), isolate(input$csz.var))
    } else {
      PlotDataAddress(full.data, isolate(input$street.var), isolate(input$csz.var))
    }
  })
})