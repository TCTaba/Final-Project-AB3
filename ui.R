library(shiny)

my.ui <- navbarPage(
  
  # Application title
  "Test Shiny",
  textInput(inputId, label, value = "", width = NULL, placeholder = NULL),
  
  # Sidebar with a slider input for number of bins 
  tabPanel("Overview",
           sidebarLayout(
             sidebarPanel(
             ),
             
             # Show a plot of the generated distribution
             mainPanel(
              # plotlyOutput("distPlot")
             )
           )
  ),
  tabPanel("Histogram",
           sidebarLayout(
             sidebarPanel(
               selectInput(
               )
               )
             ),
             
             # Show a plot of the generated distribution
             mainPanel(
               plotlyOutput("histPlot")
             )
           )
  )
)

shinyUI(my.ui)
