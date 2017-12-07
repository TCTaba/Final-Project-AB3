library(shiny)
library(plotly)

source("./scripts/spd_data.R")
source("./scripts/api_keys.R")
source("./scripts/zillow_data.R")
source("./scripts/neighborhoods.R")

my.ui <- navbarPage(theme = "styles.css",
  
  # Application title
  "Seattle Housing and Crime",
  
   tabPanel("About",
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
                 The second dataset, collected by', a('Zillow', href="https://www.zillow.com/howto/api/APIOverview.htm"), 
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
   ),
  
  tabPanel("Learn More",
    tags$div(id="learn-more",
       tags$p('Here you will find a comprehensive list of the types of crimes that are listed in the map.'),
       tags$br(),
       tags$h3('Misdemeanors'),
       tags$p('Misdemeanors usually defined as a crime which is punishable by up to a year in jail time.'),
       tags$ul(
         tags$li('Animal Complaint'),
         tags$li('Assault'),
         tags$li('Bike Theft'),
         tags$li('Car Prowl'),
         tags$li('Counterfeit'),
         tags$li('Disorderly Conduct'),
         tags$li('Dispute'),
         tags$li('DUI (Driving Under the Influence)'),
         tags$li('Firework'),
         tags$li('Injury'),
         tags$li('Obstruct'),
         tags$li('Other Property'),
         tags$li('Pickpocket'),
         tags$li('Property Damage'),
         tags$li('Prostitution'),
         tags$li('Recovered Property'),
         tags$li('Stolen Property'),
         tags$li('Theft of Service'),
         tags$li('Threats'),
         tags$li('Traffic'),
         tags$li('Trespass')
       ),
       
       tags$br(),
       tags$h3('Felonies:'),
       tags$p('Felonies are the most serious types of crimes. They are usually defined by the fact 
              that they are punishable by prison sentences of greater than one year. Felonies are 
              usually crimes that are viewed severely by society, and include crimes such as murder, 
              rape, burglary, kidnapping, or arson.'),
       tags$ul(
         tags$li('Burglary'),
         tags$li('Burglary (Secure Parking Residence)'),
         tags$li('Eluding'),
         tags$li('Embezzle'),
         tags$li('Forgery'),
         tags$li('Fraud'),
         tags$li('Homicide'),
         tags$li('Mail Theft'),
         tags$li('Narcotics'),
         tags$li('Pornography'),
         tags$li('Reckless Burning'),
         tags$li('Robbery'),
         tags$li('Shoplifting'),
         tags$li('Stolen Property (more valuable items)'),
         tags$li('Vehicle Theft'),
         tags$li('Violation of Court Order'),
         tags$li('Warrant Arrest'),
         tags$li('Lost Property')
       ),
       tags$p('Information on felony and misdemeanors is from', 
              a('FindLaw', href="http://criminal.findlaw.com/criminal-law-basics/what-distinguishes-a-misdemeanor-from-a-felony.html"),
              'for more information on each offense, visit the ',
              a('Seattle PD Website', href = 'https://www.seattle.gov/police-manual'))     
    )
  ),
  
  tabPanel("Questions?",
    tags$p('For information about each type of crime, visit the "Learn More" tab.'),
    tags$br(),
    tags$br(),
    tags$h3('Neighborhood Tab'),
    tags$p('This tab is indended for users who would like to see incidence information for a general area of Seattle.
           If you would like to look into a particular address, please check out the "Address" tab'),
    tags$p('For looking at information about a particular neighborhood in Seattle, follow these steps:'),
    tags$ol(
      tags$li('Select neighborhood from options on the top left side'),
      tags$li('Select whether you would like to view just misdemeanors, just felonies, or both for the selected neighborhood'),
      tags$li('From here the map should display the selected neighborhood with the selected type of data you want. You can zoom
              in and out however you like from here.')
    ),
    tags$br(),
    tags$h3('Address Tab'),
    tags$p('This tab is intended for users who would like to see incidence information around a particular address in Seattle.
           If you would like to look for neighborhood level information, just zoom out or click to the "Neighborhood" tab.'),
    tags$p('Please note that this will only work for', em('residences for sale'), 'in Seattle.'),
    tags$p('For looking at information about a particular residence for sale in Seattle, follow these steps:'),
    tags$ol(
      tags$li('Type in the street your residence of interest is on inside the "Street" text box'),
      tags$li('Type in the city, state, and zipcode your residence of interest is in inside the "City, State, and Zip Code" text box'),
      tags$li('Click "Enter" to change the map to focus on your residence of interest'), 
      tags$li('You can also specify whether you would like to see just misdemeanors, felonies, or both in the drop down menu'),
      tags$li('From here the map should display the selected house, with the type of data you want to see. You can zoom in and out however you want from here.')
    )
  )
)

shinyUI(my.ui)
