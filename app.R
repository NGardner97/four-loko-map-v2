library(shiny)
library(readr)
library(tidyverse)
library(leaflet)

ui <- fluidPage(
  titlePanel("Four Loko UK Shop Map"),
  leafletOutput("map", height = 600)
)

# Server
server <- function(input, output) {
  
  df <- read_csv("https://raw.githubusercontent.com/NGardner97/four-loko-map-v2/main/four-loko-sightings.csv")
  
  output$map <- renderLeaflet({
    leaflet(df) %>%
      addTiles() %>%
      addMarkers(
        lng = ~longitude,
        lat = ~latitude,
        popup = ~paste0("<b>", name, "</b><br>", full_address, "<br>", description)
      ) %>%
      addProviderTiles("CartoDB.Positron")
  })
  output$timestamp <- renderText({
    paste("Data last loaded at", Sys.time())
  })
}

# Launch app
shinyApp(ui = ui, server = server)