rm(list = ls())

#Bring in packages
library(tidyverse)
library(tidycensus)

#set directory
setwd("D:/2025 Projects/Mergers and Acquisitions (Level 1)/Data/Moody's Orbis M&A/All Deals/R workshop")

#read in data
load("deident_allyears.RData")

##drop duplicate observations
unique_mas <- all_matched %>% distinct()

##drop observations with no county
unique_mas <- unique_mas %>% subset(match_indicator == "Match")

#look at types and statuses
levels(as.factor(unique_mas$status))
levels(as.factor(unique_mas$type))

#extract first part of type
unique_mas <- unique_mas %>%
              separate(type, c("type1", "type2"), " ") %>%
              mutate(type = paste(type1, type2, sep = " "))

#look at type again
levels(as.factor(unique_mas$type))

#add dummies for each type of observation
unique_mas <- unique_mas %>%
                        #first the status variables
                        mutate(rumor        = ifelse(grepl("Rumour", status), 1, 0),
                               completed    = ifelse(grepl("Completed", status), 1, 0),
                               pending      = ifelse(grepl("Pending", status), 1, 0),
                               announced    = ifelse(grepl("Announced", status), 1, 0),
                               postponed    = ifelse(grepl("Postponed", status), 1, 0),
                               withdrawn    = ifelse(grepl("Withdrawn", status), 1, 0),
                               completed_value = ifelse(grepl("Completed", status), value, 0),
                               
                               #then the type variables 
                               acquisition  = ifelse(grepl("Acquisition", type), 1, 0),
                               cap_increase = ifelse(grepl("Capital", type), 1, 0),
                               demerger     = ifelse(grepl("Demerger", type), 1, 0),
                               ipo          = ifelse(grepl("Initial", type), 1, 
                                              ifelse(grepl("IPO", type), 1, 0)),
                               buyout       = ifelse(grepl("buy-out", type), 1, 0),
                               buyin        = ifelse(grepl("buy-in", type), 1, 0),
                               min_stake    = ifelse(grepl("Minority", type), 1, 0),
                               merger       = ifelse(grepl("Merger", type), 1, 0),
                               buyback      = ifelse(grepl("buyback", type), 1, 0),
                               joint        = ifelse(grepl("venture", type), 1, 0),
                               
                               #get full fipscounty code for census merge
                               county_code = paste0(state_fips, county_fips))


#aggregate up to the county_fips level
county_data <- unique_mas %>% group_by(county_code, year) %>%
              #first the number of observations per county per year
               summarise(n                  = n(),
                         
              #then the number of types of mas by county by year
                         rumor_total        = sum(rumor),
                         completed_total    = sum(completed),
                         pending_total      = sum(pending),
                         announced_total    = sum(announced, na.rm = T),
                         postponed_total    = sum(postponed),
                         withdrawn_total    = sum(withdrawn),
                         acquisition_total  = sum(acquisition),
                         cap_increase_total = sum(cap_increase),
                         demerger_total     = sum(demerger),
                         ipo_total          = sum(ipo),
                         buyout_total       = sum(buyout),
                         buyin_total        = sum(buyin),
                         min_stake_total    = sum(min_stake),
                         merger_total       = sum(merger),
                         buyback_total      = sum(buyback),
                         joint_total        = sum(joint),
              
              #add a value variable for total amount of dollars involved in mas in a county and year
                         value_total        = sum(value, na.rm = TRUE),
                  
              #then whether or not a county had a particular type or status in a particular year       
                         rumor              = max(rumor),
                         completed          = max(completed),
                         pending            = max(pending),
                         announced          = max(announced),
                         postponed          = max(postponed),
                         withdrawn          = max(withdrawn),
                         acquisition        = max(acquisition),
                         cap_increase       = max(cap_increase),
                         demerger           = max(demerger),
                         ipo                = max(ipo),
                         buyout             = max(buyout),
                         buyin              = max(buyin),
                         min_stake          = max(min_stake),
                         merger             = max(merger),
                         buyback            = max(buyback),
                         joint              = max(joint))

#bring in census data to merge with MAs
#figure out which variables we want
v09 <- load_variables(2009, "acs5", cache = TRUE)

#pull in initial dataset for 2009
income <- get_acs(geography = "county", variables = c("B19013_001", "B19001_001"), year = 2009) %>%
          mutate(year = 2009)

#for loop to pull in rest of the data
for (i in 2010:2024){
    x <- get_acs(geography = "county", variables = c("B19013_001", "B19001_001"), year = i) %>%
         mutate(year = i)
    income <- rbind(income, x)
}

#reshape data to make it usable
income_reshape <- income %>% pivot_wider(names_from = variable, values_from = c(estimate, moe))
names(income_reshape)[4:7] <- c("avg_income", "median_income", "moe_avg_income", "moe_median_income")

#merge income variables to MA data
ma_income_merged <- merge(county_data, income_reshape, by.x = c("year", "county_code"), 
                          by.y = c("year", "GEOID"))

ma_income_merged_allc <- merge(county_data, income_reshape, by.x = c("year", "county_code"), 
                               by.y = c("year", "GEOID"), all.x = FALSE, all.y = TRUE)
ma_income_merged_allc[is.na(ma_income_merged_allc)] <- 0

#save the data
save(ma_income_merged, file = "ma_income_data.Rdata")
