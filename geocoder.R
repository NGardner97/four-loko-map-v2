library(tidygeocoder)
library(tidyverse)

system("git pull origin main")

df <- read_csv("four-loko-sightings-raw.csv")

df <- df %>%
  mutate(full_address = paste(address, area, postcode, "UK", sep = ", "))

df_geo <- df %>%
  geocode(address = full_address, method = "osm", lat = latitude, long = longitude)

write_csv(df_geo, "four-loko-sightings.csv")

system("git add four-loko-sightings.csv")
system("git commit -m 'Automated update from R'")
system("git push origin main")