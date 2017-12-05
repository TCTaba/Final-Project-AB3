#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

source("./scripts/spd_data.R")
source("./scripts/api_keys.R")
source("./scripts/zillow_data.R")

my.ui <- navbarPage(
  
  # Application title
  "Crime vs House Prices",
  
  tabPanel("Scatterplot",
           sidebarLayout(
             sidebarPanel(
               selectInput("check.var",
                           "Type of Crime",
                           choices = list("Misdemeanor" = "mis",
                                          "Felony" = "fel",
                                          "Both" = "both"))),
             
             # Show a plot of the generated distribution
             mainPanel(
               plotlyOutput("crimePlot")
             )
           )
  )
)
# Define UI for application that draws a histogram
shinyUI(my.ui)
