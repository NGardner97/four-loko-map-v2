library(tidygeocoder)
library(tidyverse)

df <- read_csv("four-loko-sightings-raw.csv")

df <- df %>%
  mutate(full_address = paste(address, area, postcode, "UK", sep = ", "))

df_geo <- df %>%
  geocode(address = full_address, method = "osm", lat = latitude, long = longitude)

write_csv(df_geo, "four-loko-sightings.csv")