# Introduction to Data Visualization in R with ggplot2
# This code builds from an earlier repository submission titled: Introduction to R.
# We are using the same health_data.xlsx and alumni_data.xlsx files from that submission.
# The goal is to learn how to create several common graphs in R using ggplot2.


# Installing and Loading Packages --------------------------------------------------------
# If you are following along from the Day 1 and Day 2 introductions, you should only need to
# install the "ggplot2" package. After installing a package once, comment the line out by
# placing a # in front of it so that it does not reinstall every time you run the script.

install.packages("ggplot2")

# The library() command tells R that you want to use the package in this script. We will use 
# three packages for this code. 

library(readxl)
library(dplyr)
library(ggplot2)

# Step 1 -- Importing the excel file into R. 
# ---------------------
# R uses the read_excel() command from the 'readxl' package to import data.
# The code below shows the manual import process.
#
# The text written to the left of the <- is the name we are assigning to the dataset.
# The text written inside read_excel() is the file path showing where the Excel file is stored.
#
# IMPORTANT: Update the file path below so that it matches the location where you saved
# the "health_data.xlsx" and "alumni_data.xlsx" files on your computer.

health_data <- read_excel("~/Dropbox/BU/Spring 2026/BS330 - Quant II - Sp26/health_data.xlsx")
alumni_data <- read_excel("~/Dropbox/BU/Spring 2026/BS330 - Quant II - Sp26/alumni_data.xlsx")


# Step 2 -- Creating a Scatter Plot 
# ---------------------
# A scatter plot is useful when we want to look at the relationship between two numeric variables.
# Here, we are going to look at the relationship between height and weight.

height_weight_plot <- ggplot(health_data, aes(x = Height_cm, y = Weight_kg)) +
  geom_point( ) +
  labs(
    title = "Height and Weight of Survey Respondents",
    x = "Height (cm)",
    y = "Weight (kg)"
  )

# In words:
# Each piece of the plotting code is described below: 
#   -- The ggplot() function tells R that we want to create a graph and specifies the dataset 
#      to use which, here, is the health_data dataset.
#   -- The aes() function tells R which variables should appear on the x-axis (height) and 
#      y-axis (weight). Note that the variable names must match exactly with those in the 
#      dataset, including spelling and capitalization.
#   -- The geom_point() function is what tells R to create a scatter plot. By default, the  
#      points will appear in black.
#   -- The labs() function adds a title and axis labels. Any text added to the plot must be  
#      placed inside quotation marks.
#   -- Finally, we assign a name to the plot (avoid spaces and use underscores). Here we've 
#      named it height_weight_plot.

# Running the lines above creates the plot object, but to display the plot, we must run a 
# line of code that simply lists the name of the plot:  

height_weight_plot

# Running the above code in line 66, allows the R user to see the plot in the lower right 
# hand corner in the **plots** tab. If, you get an error in the console that reads 
# "Error in plot.new() : figure margins too large"this means that your **plots** tab window 
# pane is too small to display the figure. Make that pane larger and re-run the code. 


# Scatter Plot Version 2 - Includes a color option for the points.  
# ---------------------
# To change the color of the points from the default, we need to use the col = "blue" command. 
# There are many color options available, to explore visit: 
#  https://www.nceas.ucsb.edu/sites/default/files/2020-04/colorPaletteCheatsheet.pdf

height_weight_plot_v2 <- ggplot(health_data, aes(x = Height_cm, y = Weight_kg)) +
  geom_point(col="blue") +
  labs(
    title = "Height and Weight of Survey Respondents",
    x = "Height (cm)",
    y = "Weight (kg)"
  )

height_weight_plot_v2



# Step 3 -- Creating a Line Graph 
# ---------------------
# A line graph is useful when the x-axis has a natural order or time trend, such as years. 
# Here, we will need to first use skills learned from Day 2 (e.g., summarizing data). We are 
# going to summarize the alumni data to find the average yearly income for graduates based on 
# their year of graduation. 

income_by_year <- alumni_data %>%
  group_by(Year_of_Graduation) %>%
  summarize(Average_Income = mean(Yearly_Income, na.rm = TRUE))

# The above code groups the data by the alums year of graduation and then calculates the average 
# of their yearly income. We will save this summarized data in a new dataframe called "income_by_year"
# and use this data to plot a line graph. 

income_line_graph <- ggplot(income_by_year, aes(x = Year_of_Graduation, y = Average_Income)) +
  geom_line() +
  labs(
    title = "Average Alumni Income by Graduation Year",
    x = "Year of Graduation",
    y = "Average Yearly Income"
  )

income_line_graph

# Similar to our previous plot, the ggplot() function lets R know that we are going to create
# a plot. The key distinction between the two is now we let R know this should be a line
# graph using the geom_line() function. Below, are two alternative ways of creating the line
# graph: 

# Line Graph Version 2 - include points at each year to see the values easier. 
# ---------------------
income_line_graph_v2 <- ggplot(income_by_year, aes(x = Year_of_Graduation, y = Average_Income)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Average Alumni Income by Graduation Year",
    x = "Year of Graduation",
    y = "Average Yearly Income"
  )

income_line_graph_v2


# Line Graph Version 3 - Add other colors
# ---------------------
income_line_graph_v3 <- ggplot(income_by_year, aes(x = Year_of_Graduation, y = Average_Income)) +
  geom_line(col="purple") +
  geom_point(col="darkblue") +
  labs(
    title = "Average Alumni Income by Graduation Year",
    x = "Year of Graduation",
    y = "Average Yearly Income"
  )

income_line_graph_v3


# Step 4 -- Creating a Bar Chart
# ---------------------
# A bar chart is useful for comparing categories. Again for this bar chart, we will use skills
# learned from Day 2. We are going to summarize the health data to compare the average BMI across
# different job categories. The code below follows a similar set of steps as those for our line
# graph: (1) Prepare the data, (2) plot it -- here using geom_col() for a bar chart, (3) show it 
# the plot tab/plot viewer pane. 

bmi_by_job <- health_data %>%
  group_by(Job) %>%
  summarize(Average_BMI = mean(BMI, na.rm = TRUE))

bmi_bar_chart <- ggplot(bmi_by_job, aes(x = Job, y = Average_BMI)) +
  geom_col() +
  labs(
    title = "Average BMI by Job Category",
    x = "Job Category",
    y = "Average BMI"
  )

bmi_bar_chart

## *** Alternatively, sometimes it can be difficult to see the full labels on the
##     x-axis or they may overlap. To resolve this, we can turn the x-axis labels 
##     so that they are shown at an angle. We will call this version two (v2). 

bmi_bar_chart_v2 <- ggplot(bmi_by_job, aes(x = Job, y = Average_BMI)) +
  geom_col(fill="darkgreen") +
  labs(
    title = "Average BMI by Job Category",
    x = "Job Category",
    y = "Average BMI"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

bmi_bar_chart_v2

## ^^ the key differences for this bar chart. (1) we added color to the bars using the "fill" command
## and (2) using the theme() function we told R to put the x-axis text at a 45 degree angle and 
## to right-align the text using hjust. There are 3 different hjust (horizontal justification) options:
##    hjust = 0  is left aligned
##    hjust = 0.5 is centered
##    hjust = 1 is right aligned




# In-Class Exercise or Homework ---------------------------------------------------------
# Try the following on your own:
# 1. Create a scatter plot with Age on the x-axis and BMI on the y-axis. Make the
#    scatter plot points brown.  

# 2. Create a line graph showing the average GPA by Year_of_Graduation. Let the line be
#    blue and the points be black. 

# 3. Create a bar chart showing the average yearly income by major. Optional: set the 
#    x-axis labels at a 45 degree angle and right-aligned. 

# Answer Key ----------------------------------------------------------------------------

# 1. Scatter plot: Age and BMI
age_bmi_plot <- ggplot(health_data, aes(x = Age, y = BMI)) +
  geom_point(col="brown") +
  labs(
    title = "Age and BMI of Survey Respondents",
    x = "Age",
    y = "BMI"
  )

age_bmi_plot

# 2. Line graph: Average GPA by graduation year
gpa_by_year <- alumni_data %>%
  group_by(Year_of_Graduation) %>%
  summarize(Average_GPA = mean(GPA, na.rm = TRUE))

gpa_line_graph <- ggplot(gpa_by_year, aes(x = Year_of_Graduation, y = Average_GPA)) +
  geom_line(col="blue") +
  geom_point() +
  labs(
    title = "Average GPA by Graduation Year",
    x = "Year of Graduation",
    y = "Average GPA"
  )

gpa_line_graph

# 3. Bar chart: Average income by major
income_by_major <- alumni_data %>%
  group_by(Major) %>%
  summarize(Average_Income = mean(Yearly_Income, na.rm = TRUE))

income_major_bar <- ggplot(income_by_major, aes(x = Major, y = Average_Income)) +
  geom_col() +
  labs(
    title = "Average Alumni Income by Major",
    x = "Major",
    y = "Average Yearly Income"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

income_major_bar

