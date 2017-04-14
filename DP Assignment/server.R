#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(dplyr)
dataset <-   read_csv(file="data.zip")
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$mymap <- renderLeaflet({
    color <- colorFactor(topo.colors(23), dataset$Category)
    
    # generate bins based on input$bins from ui.R
    cats <- c()
    if (input$ASSAULT == TRUE){
      cats <- c(cats,"ASSAULT")
    }
    if (input$ROBBERY == TRUE){
      cats <- c(cats,"ROBBERY")
    }
    if (input$LARCENY == TRUE){
      cats <- c(cats,"LARCENY/THEFT")
    }
    if (input$VEHICLE == TRUE){
      cats <- c(cats,"VEHICLE THEFT")
    }
    dataset %>%filter(Year == input$year, Category %in% cats) %>%leaflet() %>%
      setView(lng = -122.4194 ,lat = 37.76, zoom = 12) %>%
      addProviderTiles("CartoDB.Positron", options = providerTileOptions(noWrap = TRUE)) %>%
      addCircleMarkers(
        lng=~X,
        lat=~Y,
        radius = 2,
        stroke=FALSE,
        fillOpacity=.5,
        color=~color(Category))%>%
      addLegend(
        "bottomleft", # Legend position
        pal=color, # color palette
        values=~Category, # legend values
        opacity = 1,
        title="Type of Crime Committed"
      )
    
    
  })
  
})
