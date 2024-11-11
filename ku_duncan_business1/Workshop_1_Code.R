
library(tidyr)
library(ggplot2)
library(datasets)
library(mlbench)
library(magrittr)
library(dplyr)
data("BostonHousing")
#Question 1. Find the mean crime rate by Charles Rivers number. 
#Report these two numbers in your homework.

BostonHousing %>%
  group_by(chas) %>%
  summarise(mean.Crim = mean(crim))

#Question 2. List the 5 tax observations if you arrange the 
#Boston Housing data in descending order by the tax variable.

BostonHousing %>% tbl_df %>%
  arrange(desc(tax)) %>%
  head(5)


#Question 3. Plot the pupil teacher ratio against the proportion of 
#non-retail business acres per town. Do you see a pattern? 
#Include your plot in your homework submission.

ggplot(data = BostonHousing, aes(x = ptratio, y = indus))+
  geom_point()

#Question 4. Obtain an age distribution histogram. Does this seem 
#like a representative sample? Include your plot in your homework 
#submission.

hist(BostonHousing$age)

#Question 5. Create a plot using different shapes for the rad variable. 
#Put the average number of rooms on the x-axis and the median home 
#value in thousands on the y-axis. Use only four shapes. 
#Include your plot in your homework submission.

shape_map <- c("1"=1,"2"=1,"3"=2,"4"=2,"5"=3,"6"=3,"7"=4,"8"=4)
shape_map1 <- c("1"="1","2"="1","3"="2","4"="2","5"="3","6"="3","7"="4","8"="4")

BostonHousing %$% plot(rm ~ medv, pch =
                shape_map[rad])

BostonHousing %$% plot(rm ~ medv, pch =
                shape_map1[rad])

#Question 6. Create a scatterplot with ggplot. Put the average 
#number of rooms on the x-axis and the median home value in thousands 
#on the y-axis. Use age for color. What do you notice in this plot 
#that is different from the plots in the worksheet? Include your plot
#in your homework submission.

ggplot(data = BostonHousing, aes(x = rm, y = medv, color = age))+
  geom_point()

#Question 7. Create a scatter-plot with ggplot and facet on the rad variable. Put the 
#average number of rooms on the x-axis and the median home value on the y-axis. 
#Include your plot in your homework submission.

ggplot(data = BostonHousing)+
  geom_point(aes(x=rm, y=medv))+
  facet_grid(rad~.)

#Question 8. Create a plot of your choice and explain why it 
#creates insight into the Boston Housing dataset. Include your 
#plot in your homework submission.
