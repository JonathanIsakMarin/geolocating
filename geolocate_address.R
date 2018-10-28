library(tidyverse)
library(ggmap)
library(dplyr)
library(leaflet)
library(leaflet.extras)

# Register google key and credentials (api key can be obtained from google's developer sites)
register_google(key = "your_api_key", account_type = "premium", day_limit = 100000)
ggmap_credentials()

# Change danish letters to english equivalents (improves the geocoding). dummy_data=your dataset
dummy_data = dummy_data %>% 
  mutate(address = (str_replace_all(address, "å", "aa")))

dummy_data = dummy_data %>% 
  mutate(address = (str_replace_all(address, "Å", "Aa")))

dummy_data = dummy_data %>% 
  mutate(address = (str_replace_all(address, "ø", "oe")))

dummy_data = dummy_data %>% 
  mutate(address = (str_replace_all(address, "Ø", "Oe")))

dummy_data = dummy_data %>% 
  mutate(address = (str_replace_all(address, "Æ", "Ae")))

dummy_data = dummy_data %>% 
  mutate(address = (str_replace_all(address, "æ", "ae")))

# Geolocate addresses
address.vector = dummy_data$address

df1 = data.frame(
  address = address.vector,
  stringsAsFactors = FALSE)

geolocate2 = df1 %>% 
  mutate_geocode(address)

# Name adresses and geolocations
colnames(geolocate2)[1] = "address"
colnames(geolocate2)[2] = "longitude"
colnames(geolocate2)[3] = "lattitude"

# Save file as
write.csv(geolocate2, file = "")

# Use your geodata to make a nice interactive heatmap! 
#Set intensity, size and "https://bhaskarvk.github.io/leaflet.extras/reference/heatmap.html"
v = leaflet(data) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addWebGLHeatmap(lng=~LON, lat=~LAT,size=20,units='px', intensity=0.4)
v

