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
  
  tabPanel("Summary Info",
           tags$h1('Project Overview'),
           tags$p('This application provides an interactive tool that maps homes for 
                  sale in the Seattle area, and all police report incidents that have 
                  occurred in the city of Seattle in the last three months. 
                  The purpose of this project is to create a visual representation of 
                  police incidents in Seattle in relation to homes for sale that can aid 
                  potential homebuyers in their decision to purchase a Seattle home. We 
                  recognize that the police report incidents is not a comprehensive 
                  representation of crime in an area, but we hope that this application 
                  will help homebuyers gain a better understanding of the current safety surrounding 
                  their future home.'),
           tags$h1('Audience/Intended Use'),
           tags$p('While this application is useful to any Seattle resident who is curious to 
                  the crime rates surrounding their home, the intended audience is potential 
                  homebuyers who are interested in a Seattle home. We expect our audience to 
                  visit our site with prior knowledge of the specific address to a home for 
                  sale, or a specific neighborhood of Seattle that they are interested in purchasing 
                  a home in, in order to optimize their experience.'),
           tags$h1('Data'),
           tags$p('We are working with two datasets. The first dataset, collected by', a('the Seattle Police Department',href="https://data.seattle.gov/Public-Safety/Seattle-Police-Department-Police-Report-Incident/7ais-f98f"),
                  'contains data on reported Seattle police incidents, updated every 15 minutes. 
                  The second dataset, collected by', a('Zillow', href="https://www.zillow.com/howto/api/APIOverview.htm "), 
                  'contains property information for houses listed for sale, which is updated daily.'),
           tags$h1('Questions To Be Explored'),
           tags$ul(tags$li('Is there a correlation between housing prices and reported crime in Seattle?'), 
                   tags$li('How does reported crime vary in each of the 103 neighborhoods of Seattle?'),
                   tags$li('Which neighborhoods have the highest and lowest housing prices?') ),
           tags$h1('Structure'),
           tags$p('We have provided two different options of how the user chooses to view the data: 
                  searching by a home address, or searching by a neighborhood. In both of these options,
                  the user will be able to select and filter the kinds of police reports they wish to
                  see on the map (felonies, misdemeanors, or both).'),
           tags$h1('Project Creators'),
           tags$ul(tags$li('Rebecca Liu'),
                   tags$li('Tim Perng'),
                   tags$li('Ty Tabadero'),
                   tags$li('Nanda Sundaresan'))
           ),
  
  
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
               plotlyOutput("neighborhoodPlot", width = "100%", height = "100%")
             )
           )
  ),
  
  tabPanel("Address",
           sidebarLayout(
             sidebarPanel(
               textInput("street.var",
                           h4("Street"),
                           value = "315 Howe St"),
               textInput("csz.var",
                           h4("City, State, and Zip Code"),
                           value = "Seattle, WA 98109"),
               actionButton("goButton", "Enter"),
               selectInput("check.var",
                           "Type of Crime",
                           choices = list("Misdemeanor" = "mis",
                                          "Felony" = "fel",
                                          "Both" = "both"))
             ),
             
             # Show a plot of the generated distribution
             mainPanel(
               plotlyOutput("addressPlot", width = "100%", height = "100%")
             )
           )
  )
)
# Define UI for application that draws a histogram
shinyUI(my.ui)
