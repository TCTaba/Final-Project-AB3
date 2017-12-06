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
source("./scripts/neighborhoods.R")

my.ui <- navbarPage(
  
  # Application title
  "Crime vs House Prices",
  
  tabPanel("Neighborhoods",
           sidebarLayout(
             sidebarPanel(
               selectInput("neighborhood.var",
                           "Neighborhood",
                           choices = parsed.regions[1],
                           selected = "University District"),
               selectInput("type.var",
                           "Type of Crime",
                           choices = list("Misdemeanor" = "mis",
                                          "Felony" = "fel",
                                          "Both" = "both"))
               ),
             
  
             
             # Show a plot of the generated distribution
             mainPanel(
               plotlyOutput("neighborhoodPlot")
             )
           )
  ),
  
  tabPanel("Address",
           sidebarLayout(
             sidebarPanel(
               textInput("street.var",
                           h3("Street"),
                           placeholder = "Ex. 315 Howe St"),
               textInput("csz.var",
                           h3("City, State, and Zip Code"),
                           placeholder = "Ex. Seattle, WA 98109"),
               selectInput("type.var",
                           "Type of Crime",
                           choices = list("Misdemeanor" = "mis",
                                          "Felony" = "fel",
                                          "Both" = "both"))
             ),
             
             
             
             # Show a plot of the generated distribution
             mainPanel(
               plotlyOutput("addressPlot")
             )
           )
  )
  
)
# Define UI for application that draws a histogram
shinyUI(my.ui)
