library(shiny)
library(leaflet)
library(tidygeocoder)
library(readr)
library(readxl)
library(tidyverse)

df <- read_csv("https://raw.githubusercontent.com/NGardner97/four-loko-map-v2/refs/heads/main/four-loko-sightings.csv")

df <- df %>%
  mutate(full_address = paste(address, area, postcode, "UK", sep = ", "))

df_geo <- df %>%
  geocode(address = full_address, method = "osm", lat = latitude, long = longitude)


ui <- fluidPage(
  titlePanel("Four Loko UK Shop Map"),
  leafletOutput("map", height = 600)
)

# Server
server <- function(input, output) {
  output$map <- renderLeaflet({
    leaflet(df_geo) %>%
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