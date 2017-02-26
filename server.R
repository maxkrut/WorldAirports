#Server

function(input, output, session) {
     
     updateSelectizeInput(session, 'airports', 
                          choices = sort(airports_data$City),
                          server=TRUE)
    
     dataInput <- reactive({
     
     airports_data %>% 
               filter(City %in% input$airports, 
                      Altitude >= input$alt[1], 
                      Altitude <= input$alt[2])
     
     })
     output$table1 <- renderTable({
          
          if (input$checkBox == FALSE) dataInput() %>% 
               select(Name, City, Country, Latitude, Longitude, Altitude)
          else dataInput()
          
     })
     
     output$table2 <- renderTable({
          
          coords <- matrix(c(dataInput()$Longitude, dataInput()$Latitude), ncol=2)
          distance <- round(distm(coords, fun = distHaversine))/1000 #to km
          colnames(distance) <- rownames(distance) <- dataInput()$Name
          distance
          
          
     }, 
     include.rownames = TRUE)
     
     output$map <- renderLeaflet({
      
     leaflet() %>% 
          addProviderTiles(providers$CartoDB.DarkMatter) %>%
          addMarkers(lat = dataInput()$Latitude, 
                     lng = dataInput()$Longitude, 
                     popup = dataInput()$Name)
     })
}