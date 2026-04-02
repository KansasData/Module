# Introduction to R: Day Two (Importing data and working with it)
# Most real-world data is stored in external files like CSVs or excel files. Let’s import a dataset.

# Installing and Loading Packages --------------------------------------------------------
#  R comes with some built in functions, commands, and capabilities. However, 
#  many of the things we need R to do requires us to install new packages or add-ons.

#  Think of packages like things you buy at the store. You only have to "buy" the item once
#  but you have to get it out every time you want to use it.  For example, 
#  you buy a large blender that you store in your pantry. You only had to buy the 
#  blender once, but each time you use it, you must go get it out of your pantry. 

#  R packages are treated the same way. Once you've installed the package, you don't
#  ever have to install it again, BUT you do have tell R each time you want to use that 
#  package. 

#  To install the packages we need (there are three here), you use the following code: 
install.packages("readxl")
install.packages("tidyr")
install.packages("dplyr")

# ^^ be careful to comment these lines out once you've installed them. Why? Because
# you only ever have to install a package once! 

# The library() command is what tells R that you want to USE the package. In my comparison above
# this is the "getting the blender out of the pantry to use it". You must have these library
# commands at the beginning of your code if you are planning to use these libraries. 
library(readxl) 
library(tidyr)
library(dplyr)


# Step 1 -- Importing the excel file into R. 
# ---------------------
# R uses the command read_excel() from the 'readxl' library to import data. 
# The code below shows the manual import process. 
# The text written to the left of the <- is what we have named the data file that 
# we are importing. The text written inside the the read_excel() function is the 
# path for the excel file that we are importing "health_data_xlsx".

data <- read_excel("~/Dropbox/BU/Spring 2025/BS330 - Quant II - Sp25/health_data.xlsx")

# The head() function let's us view the first few rows of data to make sure it imported well
head(data)


#An alternative to import data is to use the "Import Dataset" function in the **environment** tab (upper right)

# Step 2 -- Data Wrangling with the dplyr package
# ---------------------
# We often need to filter, transform, and summarize data. The dplyr package makes this easy using 
# what is called the 'pipe operator' which is %>%.  We will talk through some common data 
# manipulations. 

# Select specific columns
# ---------------------
data_selected <- data %>% select(BMI, Job)

# In words, the above code says:  take my original data file (i.e., data) and select only 
# two columns to keep (i.e., BMI and Job), and then name the new file that has only those two columns
# 'data_selected'.  This leaves the original data file alone while creating a new one data file
# that meets your selection criteria. 

# Filter rows based on a condition
# ---------------------
#  <= is less than or equal to
#  >= is greater than or equal to
#  < or > are your standard less than and greater than symbols
#  = is equal to
#  != is not equal to

filtered_data <- data %>% filter(BMI > 26)
# The above code says:  take my original data file (i.e., data) and filter it 
# to keep entries in which the BMI value is greater than 26. Name the new file that 
# has only those observations 'filtered_data'.

# Summarize data
# ---------------------
summary_stats <- data %>% summarise(MeanValue = mean(BMI, na.rm = TRUE))
# This line calculates the average BMI from the dataset.
# The summarise() function reduces the dataset down to just the mean value of the BMI column.
# The na.rm = TRUE part makes sure that any missing values (NAs) are ignored in the calculation.

# Create a new variable want height in inches instead... 
# ---------------------
data_transformed <- data %>% mutate(Height_inches = Height_cm * 0.393701)
# This adds a new column called Height_inches to the dataset.
# It converts the Height_cm variable to inches by multiplying by the conversion factor.

data_transformed2 <- data_transformed %>% select(-Height_cm)
# This line of code says, take the new data file that we just created in  
# line 86 (i.e., data_transformed) and remove the original Height_cm column 
# since we now have height in inches. The select() function with the minus sign 
# drops that specific column from the dataset.


## Notice that everything we have done so far has been written as one line of code
#   creating a new dataset/dataframe each time. What if we didn't want 4 different dataframe, 
#   say we wanted just one new datframe that does several steps at once. 
# ---------------------
edited_data <- data %>% 
  select(BMI, Job) %>%
  filter(BMI > 26) %>%
  summarise(MeanValue = mean(BMI, na.rm = TRUE)) 
# This pipeline combines three steps: 
# (1) select the BMI and Job columns,
# (2) filter to keep only observations in which BMI is greater than 26,
# (3) calculate the mean BMI of the filtered data.
# The result is a single summary statistic called "MeanValue", and it avoids creating extra datasets along the way.

# What if we just want to look at the data differently. 
# ---------------------
sorted_data <- data_selected %>% 
  arrange(Job)
# The arrange() function sorts the data by a specific column.
# In this case, we're sorting the data by the Job column in alphabetical order.


#Or create a pivot table
# ---------------------
pivot <- data_selected %>%
  group_by(Job) %>%
  summarize(BMI_Mean = mean(BMI, na.rm = TRUE))
# This is similar to making a pivot table in Excel.
# It groups the data by job type and then calculates the average BMI for each group.
# Grouped summaries like this are great for comparing across categories.


# In-Class Exercise or Homework. 
# ---------------------
#1.	Import the alumni_data Excel file into R.
#2.	Remove the column that contains information about the number of siblings.

#Part One:
#3.	Filter the dataset to include only graduates from the year 2016 and later.
#4.	Calculate the average yearly income for graduates from 2016 onward.

#Part Two: 
#5. Create a pivot_table that shows the average yearly income for each major
# ---------------------

# Answer Key
edit_alumni <- alumni_data %>% 
  select(-Number_of_Siblings) %>%
  filter(Year_of_Graduation >= 2016)

summary_stat <- edit_alumni %>% summarise(Mean_Salary = mean(Yearly_Income, na.rm = TRUE)) 

pivot <- edit_alumni %>%
  group_by(Major) %>%
  summarize(Mean_Salary = mean(Yearly_Income, na.rm = TRUE))
