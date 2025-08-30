library(tidygeocoder)
library(tidyverse)

system("git pull origin main")

df <- read_csv("four-loko-sightings.csv")

df <- df %>%
  mutate(full_address = paste(address, area, postcode, "UK", sep = ", "))

df_done <- df %>% filter(!is.na(latitude) & !is.na(longitude))
df_todo <- df %>% filter(is.na(latitude) | is.na(longitude))

df_todo_geo <- df_todo %>%
  select(-latitude, -longitude) %>%
  geocode(address = full_address, method = "osm",
          lat = latitude, long = longitude)

df_geo <- bind_rows(df_done, df_todo_geo)

write_csv(df_geo, "four-loko-sightings.csv")

system("git add four-loko-sightings.csv")
system("git commit -m 'Automated update from R'")
system("git push origin main")