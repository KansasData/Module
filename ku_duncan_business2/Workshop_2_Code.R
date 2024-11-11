

library(mlbench)
library(dplyr)
library(readxl)
lasagna <- read_excel("~/Dropbox/Baker Classes/MBA542/Spring 2020/Week 2/Lasagna Triers.xlsx")
#Linear Regression Homework

map_wagetype <- function(x) {
  ifelse(x == "Hourly", 0,
         ifelse(x == "Salaried", 1,
                NA))
}

mapped <- lasagna$PayType %>% map_wagetype()
lasagna$pt_num <- map_wagetype(lasagna$PayType)

mapped %>% table

dict <- c("Apt" = "1", "Condo" = "2", "Home" = "3")
map_dwell <- function(x) dict[as.character(x)]
mapped <- lasagna$DwellType %>% map_dwell
mapped %>% table

###########
map_dwell_ifelse <- function(x) {
  ifelse(x == "Apt", 1,
         ifelse(x == "Condo", 2,
                ifelse(x == "Home", 3,
                NA)))
}
##########

lasagna$dwell.num <- map_dwell(lasagna$DwellType)
lasagna$pay.num <- map_wagetype(lasagna$PayType)
model <- lm(Income ~ dwell.num+pay.num+Age+CCDebt+CarValue, data = lasagna)
model

model1 <- lm(Income ~ CarValue, data = lasagna)
model2 <- lm(CarValue ~ Income, data = lasagna)

#Logistic Regression Homework


##########
map_class <- function(x) {
  ifelse(x == "No", 0,
         ifelse(x == "Yes", 1,
                NA))
}

mapped <- lasagna$HaveTried %>% map_class()
mapped %>% table

lasagna$outcome <- map_class(lasagna$HaveTried)
##########
library(ggplot2)
lasagna %>% ggplot(aes(x = Age, y=outcome))+
  geom_jitter(height = 0.05, width = 0.3, alpha = 0.4)

lasagna %>% ggplot(aes(x = Weight, y=outcome))+
  geom_jitter(height = 0.05, width = 0.3, alpha = 0.4)

lasagna %>% ggplot(aes(x = Income, y=outcome))+
  geom_jitter(height = 0.05, width = 0.3, alpha = 0.4)

lasagna %>% ggplot(aes(x = CarValue, y=outcome))+
  geom_jitter(height = 0.05, width = 0.3, alpha = 0.4)

lasagna %>% ggplot(aes(x = CCDebt, y=outcome))+
  geom_jitter(height = 0.05, width = 0.3, alpha = 0.4)

lasagna %>% ggplot(aes(x = MallTrips, y=outcome))+
  geom_jitter(height = 0.05, width = 0.3, alpha = 0.4)


###########

lasagna %>% 
  ggplot(aes(x = Age, y = outcome))+
  geom_jitter(height = 0.05, width = 0.3, alpha = 0.4)+
  geom_smooth(method = "glm", method.args = list(family = "binomial"))

lasagna %>% 
  ggplot(aes(x = Weight, y = outcome))+
  geom_jitter(height = 0.05, width = 0.3, alpha = 0.4)+
  geom_smooth(method = "glm", method.args = list(family = "binomial"))

lasagna %>% 
  ggplot(aes(x = Income, y = outcome))+
  geom_jitter(height = 0.05, width = 0.3, alpha = 0.4)+
  geom_smooth(method = "glm", method.args = list(family = "binomial"))

lasagna %>% 
  ggplot(aes(x = CarValue, y = outcome))+
  geom_jitter(height = 0.05, width = 0.3, alpha = 0.4)+
  geom_smooth(method = "glm", method.args = list(family = "binomial"))

lasagna %>% 
  ggplot(aes(x = CCDebt, y = outcome))+
  geom_jitter(height = 0.05, width = 0.3, alpha = 0.4)+
  geom_smooth(method = "glm", method.args = list(family = "binomial"))

lasagna %>% 
  ggplot(aes(x = MallTrips, y = outcome))+
  geom_jitter(height = 0.05, width = 0.3, alpha = 0.4)+
  geom_smooth(method = "glm", method.args = list(family = "binomial"))

##########
lasagna %>% 
  glm(outcome ~ CCDebt, 
      family = "binomial", 
      data = .)

lasagna %>% 
  glm(outcome ~ MallTrips, 
      family = "binomial", 
      data = .)

lasagna %>% 
  glm(outcome ~ CarValue, 
      family = "binomial", 
      data = .)

lasagna %>% 
  glm(outcome ~ Weight, 
      family = "binomial", 
      data = .)

lasagna %>% 
  glm(outcome ~ Age, 
      family = "binomial", 
      data = .)

lasagna %>% 
  glm(outcome ~ Income, 
      family = "binomial", 
      data = .)

#full model
lasagna %>% 
  glm(outcome ~ CCDebt+CarValue+MallTrips+Income+Age+Weight, 
      family = "binomial", 
      data = .)

