

#Decision Tree Possible Homework
install.packages("ISLR")
install.packages("rpart")
install.packages("partykit")
library(ISLR)
library(rpart)
library(partykit)

dataset <- read_excel("~/Dropbox/Baker Classes/MBA542/Spring 2020/Week 3/social_network_ads.xlsx")

#Question 1
str(dataset)

map_gender <- function(x) {
  ifelse(x == "Male", 0,
         ifelse(x == "Female", 1, NA))
}

dataset$gender.num <- map_gender(dataset$Gender)

###### Alternatively
dataset$gender.num <- ifelse(dataset$Gender=="Male", 1,0)
dataset$gender.num %>% table()
#204 females
#196 males

#Question 2
dataset$purchased.factor <- as.factor(dataset$Purchased)
str(dataset)
dataset$purchased.factor %>% table()
#257 did not purchase
#143 did purchase

#Question 3
model <- tree(purchased.factor~Age+EstimatedSalary+gender.num, data=dataset)
summary(model)
#error rate 8 percent

#Question 4
plot(model)
text(model, pretty = 0)

#Question 5
set.seed(101)
train <- sample(1:nrow(dataset), 250)
model1 <- tree(purchased.factor~Age+EstimatedSalary+gender.num, dataset, subset = train)
tree.pred = predict(model1, dataset[-train,], type="class")
with(dataset[-train,], table(tree.pred, purchased.factor)) 


#Real Decision Tree Homework Questions
install.packages("titanic")
library(titanic)
data("titanic_train")

#Question 1



#SVM Possible Homework
#Code from here
#https://www.geeksforgeeks.org/classifying-data-using-support-vector-machinessvms-in-r/
#https://cran.r-project.org/web/packages/e1071/vignettes/svmdoc.pdf

install.packages('caTools') 
install.packages('e1071') 
install.packages("ElemStatLearn")
install.packages("tree")
install.packages("readxl")
library(caTools) 
library(e1071)
library(ElemStatLearn) 
library(tree)
library(readxl)

dataset <- read_excel("Dropbox/Baker Classes/MBA542/Week 3/social_network_ads.xlsx")
dataset = dataset[3:5] 

# Encoding the target feature as factor 
dataset$Purchased = factor(dataset$Purchased, levels = c(0, 1))

# Splitting the dataset into the Training set and Test set
index <- 1:nrow(dataset)
testindex <- sample(index, trunc(length(index)/3))
test_set <- dataset[testindex,]
training_set <- dataset[-testindex,]

# Feature Scaling 
training_set[-3] = scale(training_set[-3]) 
test_set[-3] = scale(test_set[-3])

# Fitting SVM to the Training set 
classifier <- svm(formula = Purchased ~ ., 
                 data = training_set, 
                 type = 'C-classification', 
                 kernel = 'linear')

classifier

# Predicting the Test set results 
y_pred = predict(classifier, newdata = test_set[-3]) 
y_pred

# Making the Confusion Matrix 
cm <- table(test_set[, 3], y_pred)

# Plotting the training data set results 
set = training_set 
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01) 
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01) 

grid_set = expand.grid(X1, X2) 
colnames(grid_set) = c('Age', 'EstimatedSalary') 
y_grid = predict(classifier, newdata = grid_set) 

plot(set[, -3], 
     main = 'SVM (Training set)', 
     xlab = 'Age', ylab = 'Estimated Salary', 
     xlim = range(X1), ylim = range(X2)) 

contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE) 

points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'coral1', 'aquamarine')) 

points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3')) 

# Plotting the test data set results 
set = test_set 
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01) 
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01) 

grid_set = expand.grid(X1, X2) 
colnames(grid_set) = c('Age', 'EstimatedSalary') 
y_grid = predict(classifier, newdata = grid_set) 

plot(set[, -3], main = 'SVM (Test set)', 
     xlab = 'Age', ylab = 'Estimated Salary', 
     xlim = range(X1), ylim = range(X2)) 

contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE) 

points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'coral1', 'aquamarine')) 

points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3')) 






