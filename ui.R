library(shiny)
library(plotly)

source("./scripts/spd_data.R")
source("./scripts/api_keys.R")
source("./scripts/zillow_data.R")
source("./scripts/neighborhoods.R")

my.ui <- navbarPage(theme = "styles.css",
  
  # Application title
  "Seattle Housing and Crime",
  
   tabPanel("Summary Info",
     tags$p(id = "main-title", width = "100%", 'A' , strong('SAFER'), 'HOME'),
     tags$p(id = "main-descrip", width = "100%", 'This application provides an interactive tool that 
             maps homes for sale in the Seattle area, and all police report incidents 
             that have occurred in the city of Seattle in the last three months. 
             The purpose of this project is to create a visual representation of 
             police incidents in Seattle in relation to homes for sale that can aid 
             potential homebuyers in their decision to purchase a Seattle home. We 
             recognize that the police report incidents is not a comprehensive 
             representation of crime in an area, but we hope that this application 
             will help homebuyers gain a better understanding of the current safety 
             surrounding their future home.'),
     fluidRow(width = "100%",
       column(3, 
         wellPanel(
           tags$h1('INTENDED USE'),
             tags$p('While this application is useful to any Seattle resident who is curious to 
                     the crime rates surrounding their home, the intended audience is potential 
                     homebuyers who are interested in a Seattle home. We expect our audience to 
                     visit our site with prior knowledge of the specific address to a home for 
                     sale, or a specific neighborhood of Seattle that they are interested in purchasing 
                     a home in, in order to optimize their experience.')
         ) 
       ),
       column(3, 
         wellPanel(
           tags$h1('DATA'),
           tags$p('We are working with two datasets. The first dataset, collected by', a('the Seattle Police Department',href="https://data.seattle.gov/Public-Safety/Seattle-Police-Department-Police-Report-Incident/7ais-f98f"),
                 'contains data on reported Seattle police incidents, updated every 15 minutes. 
                 The second dataset, collected by', a('Zillow', href="https://www.zillow.com/howto/api/APIOverview.htm "), 
                 'contains property information for houses listed for sale, which is updated daily.')
         )
       ),
       column(3, 
         wellPanel(
           tags$h1('QUESTIONS TO EXPLORE'),
           tags$ol(
             tags$li('Is there a correlation between housing prices and reported crime in Seattle?'), 
             tags$li('How does reported crime vary in each of the 103 neighborhoods of Seattle?'),
             tags$li('Which neighborhoods have the highest and lowest housing prices?') )
         )
       ),
       column(3, 
         wellPanel(
           tags$h1('STRUCTURE'),
             tags$p('We have provided two different options of how the user chooses to view the data: 
                   searching by a home address, or searching by a neighborhood. In both of these options,
                   the user will be able to select and filter the kinds of police reports they wish to
                   see on the map (felonies, misdemeanors, or both).')
         )
       )
     )
  ),
  
  tabPanel("Neighborhoods",
       fillPage(
         tags$div(class = "controls",
            selectInput("neighborhood.var",
                        "Neighborhood",
                        choices = parsed.regions[1],
                        selected = "University District",
                        width = "250px"),
            selectInput("type.var",
                        "Type of Crime",
                        choices = list("Misdemeanor" = "mis",
                                       "Felony" = "fel",
                                       "Both" = "both"),
                        width = "250px")     
                  
                  
          ),
       plotlyOutput("neighborhoodPlot", height = "100%"), padding = 0
       )
  ),
  
  tabPanel("Address",
     fillPage(
       tags$div(class = "controls", 
          textInput("street.var",
                    h4("Street"),
                    value = "315 Howe St",
                    width = "250px"),
          textInput("csz.var",
                    h4("City, State, and Zip Code"),
                    value = "Seattle, WA 98109",
                    width = "250px"),
          actionButton("goButton", "Enter"),
          selectInput("check.var",
                      "Type of Crime",
                      choices = list("Misdemeanor" = "mis",
                                     "Felony" = "fel",
                                     "Both" = "both"),
                      width = "150px")   
        ), 
     plotlyOutput("addressPlot", height = "100%"), padding = 0
     )
   )
)

shinyUI(my.ui)
