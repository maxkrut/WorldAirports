#UI
fluidPage(
     titlePanel("World Airports Database"), theme = shinytheme("flatly"),
     
          sidebarPanel(
               wellPanel(selectizeInput('airports', label = h4('Type city/place name'), choices = "Paris", multiple = TRUE),
               h6(helpText("You can select any number of names to display on the map"))),
               wellPanel(checkboxInput("checkBox", label = h6("Show extended information"), value = FALSE),
               h6(helpText("Check this box to display other information in addition to the coordinates and altitude"))),
               wellPanel(sliderInput("alt", label = h4("Select a range of altitude above sea level (in meters)"), 
                           min = min(airports_data$Altitude), 
                           max = max(airports_data$Altitude), 
                           value = c(0, 2000))),
               wellPanel(
                    h4('Map'),
                    leafletOutput('map'))
          ),
          
     mainPanel(
          
          fluidRow(
               column(10,
               wellPanel(
                    h4("Instruction"),
                    includeMarkdown("airports.Rmd")),
               wellPanel(
                    h4("Data Output"),
                    tableOutput('table1')),
               wellPanel(
                    h4("Distance matrix (in kilometers)"),
                    tableOutput('table2')))
                    
               )
          )     
     )


     



