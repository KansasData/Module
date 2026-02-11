rm(list = ls())

#Bring in packages
library(dplyr)
library(readxl)
library(tidygeocoder)

#working directory
setwd("D:/2025 Projects/Mergers and Acquisitions (Level 1)/Data/Moody's Orbis M&A/All Deals/R workshop")

#read in data
filename <- "example_mas_file.xlsx"
data <- read_excel(filename, sheet = 2) %>% select(-...1) %>% as.data.frame()

#non-dplyr way of doing this
data <- read_excel(filename, sheet = 2)
data <- select(data, -...1)
data <- as.data.frame(data)

#change names of variables to usable ones
names(data) <- c("deal_number", "acquiror", "acquiror_country", "target", "target_country", 
                 "type", "status", "value", "target_postcode", "target_city", "target_address1", 
                 "target_address2", "target_address3", "target_sector", "target_desc", "target_sic_primary",
                 "target_sic_all", "target_naics")

#subset to only US companies, and create full address
data <- data %>% subset(target_country == "US") %>%
        mutate(year         = 2001,
               full_address = paste(target_address1, target_city, target_postcode, sep = ", "))


#addresses to lat/lon
#create vector of just addresses
addresses <- tibble(address = subset(data, subset = !is.na(target_address1)& !is.na(target_city) & !is.na(target_postcode))$full_address) %>% 
             distinct()


#send addresses to census API
all_lat_lon <- addresses %>% geocode(address = address, 
                                     method = "census", 
                                     full_results = TRUE, 
                                     api_options = list(census_return_type = 'geographies'),
                                     flatten = TRUE)

#pull out county fips
all_lat_lon$fips_county <- all_lat_lon[[12]][[1]]$GEOID

#keep only necessary variables
all_lat_lon <- all_lat_lon %>% select(c(address, lat, long, fips_county, addressComponents.state))
names(all_lat_lon)[5] <- "state"

#merge back onto original data frame
all_matched <- base::merge(data, all_lat_lon, by.x = "full_address", by.y = "address", all = FALSE)

#save data
save(all_matched, file = "./example_latlon.RData")
