#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

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
    
    if(input$type.var == "mis") {
      PlotDataAddress(mis.data, input$street.var, input$csz.var)
    } else if (input$type.var == "fel") {
      PlotDataAddress(fel.data, input$street.var, input$csz.var)
    } else {
      PlotDataAddress(full.data, input$street.var, input$csz.var)
    }
    
    
  })
})