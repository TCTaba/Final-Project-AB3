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

source("./scripts/spd_data.R")
source("./scripts/api_keys.R")
source("./scripts/zillow_data.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$crimePlot <- renderPlotly({
    
    if(input$check.var == "mis") {
      PlotData(mis.data)
    } else if (input$check.var == "fel") {
      PlotData(fel.data)
    } else {
      PlotData(full.data)
    }
    
    
  })
})