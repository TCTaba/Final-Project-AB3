library(shiny)
library(dplyr)
library(tidyr)

source("./scripts/index.R")
source("./scripts/api_keys.R")
source("./scripts/zillow_data.R")

# Define server logic required to draw scatterplots for each tab
shinyServer(function(input, output) {
  output$neighborhoodPlot <- renderPlotly({
  
    # Plot data to the Neighborhood tab according to user crime data choice
    if(input$type.var == "mis") {
      PlotDataNeighborhood(mis.data, input$neighborhood.var)
    } else if (input$type.var == "fel") {
      PlotDataNeighborhood(fel.data, input$neighborhood.var)
    } else {
      PlotDataNeighborhood(full.data, input$neighborhood.var)
    }
  })
 
   output$addressPlot <- renderPlotly({
    
    # Plot data to the Address tab according to user crime data choice  
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