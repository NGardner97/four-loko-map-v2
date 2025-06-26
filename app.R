library(shiny)
library(readr)
library(tidyverse)
library(leaflet)

df <- read_csv("https://raw.githubusercontent.com/NGardner97/four-loko-map-v2/refs/heads/main/four-loko-sightings.csv")

ui <- fluidPage(
  titlePanel("Four Loko UK Shop Map"),
  leafletOutput("map", height = 600)
)

# Server
server <- function(input, output) {
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
}

# Launch app
shinyApp(ui = ui, server = server)