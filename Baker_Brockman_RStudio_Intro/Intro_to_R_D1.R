# Introduction to R: Day One

# Key Things to pay attention to in R 
# -----------------------------------------------------
# 1. R reads every space, word, and symbol, unless they have been commented out
#    using the # symbol.  We have already demonstrated how this symbol works in
#    our very first line. 

# 2. It is case sensitive (e.g., Arrange vs arrange), so always check that.

# 3. To execute a line of code - for example, the code written in line 34 - you can 
#    use the "Run" command (upper right-hand corner of the script) - which will 
#    run a single command of code at a time. In certain circumstances, you'll 
#    need to tell R to run a multiple line command, which requires using 
#    additional symbols (more on this later). 

# 4. If you hit "Source" (upper right corner), it will run every line in the 
#    ENTIRE script. This approach should be used with caution. 

# 5. R is sensitive to spaces. Both at the beginning of a line of code AND
#    within the line of code.  Therefore, the command should be right after
#    the line number and the function () should not have a space. For example: 
#    the select function is appropriately written as "select(-15)" not "select (-15)". 

# 6. R cannot find dataframes or variables that don't exist in its environment. 
#    So be sure that the names of your variables and the names of your dataframes 
#    correspond to your code. 



## Writing Your First R Code
# -----------------------------------------------------

rm(list = ls()) 
# ^^ This is should be your first line of code in every script. It clears the **Global 
#     Environment** so that you can start fresh each time you work with code. Each 
#     piece of this code has a purpose: rm() is the remove function, list = ls() 
#     says to clear all values listed in our environment. 

### Basic Math Operations
# You can use R like a calculator in the **Console**:
2 + 3   # Addition
5 - 2   # Subtraction
4 * 3   # Multiplication
10 / 2  # Division
2^3     # Exponentiation (2 raised to the power of 3)
sqrt(16) # Square root

#Try typing these commands in the **Console** and press **Enter** to see the output.

### Assigning Variables
#In R, you can store values which become variables using `<-` (this arrow is the 'assignment operator'):
x <- 5
y <- 10
z <- x + y  # Adds x and y 
print(z)    # the print() function displays the value of z in the **Console**

#Alternatively, you can just type `z` into the **Console** and press **Enter** to see its value.

### Vectors: Storing Multiple Values
# A **vector** is a basic data structure in R:
numbers <- c(1, 2, 3, 4, 5)   # Creating a vector
print(numbers)
mean(numbers)  # the mean() function calculates the average
sum(numbers)   # the sum() function adds all values

### Data Frames: Mini-Tables in R
#A **dataframe** is like a spreadsheet in R. 
# The following code builds a dataframe manually that will have three variables and
# three values for each variable. The data.frame() command tells R to build the 
# dataframe, the value to the left of the = is what you're naming the variable. The 
# c() command tells R that this data should be entered into a column. And lastly, 
# if the values of the variables are text, they must be entered with quotes "". 
students <- data.frame(
  Name = c("Alice", "Bob", "Charlie"),
  Age = c(20, 21, 22),
  Grade = c("A", "B", "A")
)
print(students)


#To access a column:
students$Name  # Retrieves the 'Name' column from the 'students' dataframe. This is 
#              common syntax in R: data$variable. 

## Plotting Your First Graph:
#Let's create a simple scatter plot:
x <- c(1, 2, 3, 4, 5)
y <- c(2, 4, 6, 8, 10)
plot(x, y, main="Simple Scatter Plot", xlab="X Values", ylab="Y Values")
# ^^ plot() is the command that tells R to create a figure. The values of x, and y
# are the variables we want on the x and y axis, respectively.  The main, xlab, 
# and ylab are what you name the axis and the main figure. 



# In-Class Exercise or Homework. 
# ---------------------
#Try the following on your own:
#1. Create a variable `a` and assign it the value `10`.
#2. Create another variable `b` with value `5`.
#3. Compute `a * b` and store it in a new variable `c`.
#4. Print the value of `c`.
#5. Create a vector of five numbers and calculate its mean.
#6. Create a data frame with two columns: `City` (i.e., "New York", "Boston") and `Population` (i.e., 8500000, 700000).
# ---------------------


# Answer Key
a <- 10
b <- 5
c <- a * b
print(c)

vector <- c(3, 7, 10, 2, 8)
mean(vector)

city_data <- data.frame(
  City = c("New York", "Boston"),
  Population = c(8500000, 700000)
)

print(city_data)
