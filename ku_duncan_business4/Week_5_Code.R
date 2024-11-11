
#Week 5 Code
#PCA using mtcars
library(mlbench)
data("mtcars")
install.packages("gridExtra")
install.packages("devtools")
install_github("vqv/ggbiplot")
install.packages("pracma")
library(devtools)
library(ggbiplot)
library(gridExtra)
library(pracma)

mtcars.pca <- prcomp(mtcars[,c(1:7,10,11)], center = TRUE,scale. = TRUE)
summary(mtcars.pca)
str(mtcars.pca)

#standard dev and explained variance
mtcars.pca$sdev
mtcars.pca$sdev ^ 2 / sum(mtcars.pca$sdev ^ 2)

get_PVE = function(pca_out) {
  pca_out$sdev ^ 2 / sum(pca_out$sdev ^ 2)
}

pve = get_PVE(mtcars.pca)
pve

plot(
  pve,
  xlab = "Principal Component",
  ylab = "Proportion of Variance Explained",
  ylim = c(0, 1),
  type = 'b'
)

cumsum(pve)

plot(
  cumsum(pve),
  xlab = "Principal Component",
  ylab = "Cumulative Proportion of Variance Explained",
  ylim = c(0, 1),
  type = 'b'
)


#Another approach to calculating PVE
# compute variance of each variable
apply(mtcars, 2, var)

# create new data frame with centered variables
scaled_df <- apply(mtcars, 2, scale)
head(scaled_df)

# Calculate eigenvalues & eigenvectors
mtcars.cov <- cov(scaled_df)
mtcars.eigen <- eigen(mtcars.cov)
str(mtcars.eigen)

PVE <- mtcars.eigen$values / sum(mtcars.eigen$values)
round(PVE, 2)

# PVE (aka scree) plot
PVEplot <- qplot(c(1:11), PVE) + 
  geom_line() + 
  xlab("Principal Component") + 
  ylab("PVE") +
  ggtitle("Scree Plot") +
  ylim(0, 1)

# Cumulative PVE plot
cumPVE <- qplot(c(1:11), cumsum(PVE)) + 
  geom_line() + 
  xlab("Principal Component") + 
  ylab(NULL) + 
  ggtitle("Cumulative Scree Plot") +
  ylim(0,1)

grid.arrange(PVEplot, cumPVE, ncol = 2)

#PCA with Vectors
ggbiplot(mtcars.pca)
ggbiplot(mtcars.pca, choices = 2:3)
ggbiplot(mtcars.pca, labels=rownames(mtcars))

mtcars.country <- c(rep("Japan", 3), rep("US",4), rep("Europe", 7),rep("US",3), "Europe", rep("Japan", 3), rep("US",4), rep("Europe", 3), "US", rep("Europe", 3))

ggbiplot(mtcars.pca,ellipse=TRUE,  labels=rownames(mtcars), groups=mtcars.country)
ggbiplot(mtcars.pca,ellipse=TRUE,choices=c(3,4),   labels=rownames(mtcars), groups=mtcars.country)
ggbiplot(mtcars.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,  labels=rownames(mtcars), groups=mtcars.country)
ggbiplot(mtcars.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,var.axes=FALSE,   labels=rownames(mtcars), groups=mtcars.country)
ggbiplot(mtcars.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,  labels=rownames(mtcars), groups=mtcars.country) +
  scale_colour_manual(name="Origin", values= c("forest green", "red3", "dark blue"))+
  ggtitle("PCA of mtcars dataset")+
  theme_minimal()+
  theme(legend.position = "bottom")

#adding in a new observation
spacecar <- c(1000,60,50,500,0,0.5,2.5,0,1,0,0)

mtcarsplus <- rbind(mtcars, spacecar)
mtcars.countryplus <- c(mtcars.country, "Jupiter")

mtcarsplus.pca <- prcomp(mtcarsplus[,c(1:7,10,11)], center = TRUE,scale. = TRUE)

ggbiplot(mtcarsplus.pca, obs.scale = 1, var.scale = 1, ellipse = TRUE, circle = FALSE, var.axes=TRUE, labels=c(rownames(mtcars), "spacecar"), groups=mtcars.countryplus)+
  scale_colour_manual(name="Origin", values= c("forest green", "red3", "violet", "dark blue"))+
  ggtitle("PCA of mtcars dataset, with extra sample added")+
  theme_minimal()+
  theme(legend.position = "bottom")

s.sc <- scale(t(spacecar[c(1:7,10,11)]), center= mtcars.pca$center)
s.pred <- s.sc %*% mtcars.pca$rotation


mtcars.plusproj.pca <- mtcars.pca
mtcars.plusproj.pca$x <- rbind(mtcars.plusproj.pca$x, s.pred)


ggbiplot(mtcars.plusproj.pca, obs.scale = 1, var.scale = 1, ellipse = TRUE, circle = FALSE, var.axes=TRUE, labels=c(rownames(mtcars), "spacecar"), groups=mtcars.countryplus)+
  scale_colour_manual(name="Origin", values= c("forest green", "red3", "violet", "dark blue"))+
  ggtitle("PCA of mtcars dataset, with extra sample projected")+
  theme_minimal()+
  theme(legend.position = "bottom")


#An alternative approach to get the vector plots
# Extract the loadings
(phi <- mtcars.eigen$vectors[,1:2])
phi <- -phi
row.names(phi) <- c("mpg", "cyl", "disp", "hp", 
                    "drat", "wt", "qsec", "vs", 
                    "am", "gear", "carb")
colnames(phi) <- c("PC1", "PC2")
phi

# Calculate Principal Components scores
PC1 <- as.matrix(scaled_df) %*% phi[,1]
PC2 <- as.matrix(scaled_df) %*% phi[,2]

# Create data frame with Principal Components scores
PC <- data.frame(State = row.names(mtcars), PC1, PC2)
head(PC)

ggplot(PC, aes(PC1, PC2)) + 
  modelr::geom_ref_line(h = 0) +
  modelr::geom_ref_line(v = 0) +
  geom_text(aes(label = State), size = 3) +
  xlab("First Principal Component") + 
  ylab("Second Principal Component") + 
  ggtitle("First Two Principal Components of USArrests Data")

pca_result <- prcomp(mtcars, scale = TRUE)
names(pca_result)

# means
pca_result$center
# standard deviations
pca_result$scale

pca_result$rotation

pca_result$rotation <- -pca_result$rotation
pca_result$rotation

pca_result$x <- - pca_result$x
head(pca_result$x)

biplot(pca_result, scale = 0)

pca_result$sdev

(VE <- pca_result$sdev^2)

PVE <- VE / sum(VE)
round(PVE, 2)

#PCA Using USArrests
install.packages("gridExtra")
library(tidyverse)  # data manipulation and visualization
library(gridExtra)  # plot arrangement
library(pracma) 
library(ggbiplot)

data("USArrests")
head(USArrests, 10)

#Question 1 Using the prcomp command, obtain the proportion of variance 
#explained (PVE) by each component and provide them accompanied by a plot 
#of the PVE by component in your submission.

usarrests.pca <- prcomp(USArrests, center = TRUE, scale. = TRUE)
summary(usarrests.pca)

usarrests.pca$sdev
get_PVE = function(pca_out) {
  pca_out$sdev ^ 2 / sum(pca_out$sdev ^ 2)
}

pve = get_PVE(usarrests.pca)
pve

plot(
  pve,
  xlab = "Principal Component",
  ylab = "Proportion of Variance Explained",
  ylim = c(0, 1),
  type = 'b'
)

#Question 2 Using the prcomp command, obtain the cumulative sum of the PVE 
#by each component and provide them accompanied by a plot of the cumulative 
#sum of the PVE in your submission.

cumsum(pve)

plot(
  cumsum(pve),
  xlab = "Principal Component",
  ylab = "Cumulative Proportion of Variance Explained",
  ylim = c(0, 1),
  type = 'b'
)

#Question 3 Use the eigenvalues to calculate the PVE and include the 
#combined plot of a graph with PVE by component and a graph with the 
#cumulative sum of the PVE.

scaled_df <- apply(USArrests, 2, scale)
head(scaled_df)
arrests.cov <- cov(scaled_df)
arrests.eigen <- eigen(arrests.cov)
vectors <- arrests.eigen$vectors
vectors <- data.frame(vectors)
dot(vectors$X1, vectors$X2)

PVE <- arrests.eigen$values / sum(arrests.eigen$values)
round(PVE, 2)

PVEplot <- qplot(c(1:4), PVE) +
  geom_line() +
  xlab("Principal Component") +
  ylab("PVE") +
  ggtitle("Scree Plot") +
  ylim(0, 1)
# Cumulative PVE plot
cumPVE <- qplot(c(1:4), cumsum(PVE)) +
  geom_line() +
  xlab("Principal Component") +
  ylab(NULL) +
  ggtitle("Cumulative Scree Plot") +
  ylim(0,1)

grid.arrange(PVEplot, cumPVE, ncol = 2)


#Question 4 Obtain a PCA plot with the two most important principal components. 
#Compare this with a PCA plot of the third and fourth most important 
#principal components.

ggbiplot(usarrests.pca)
ggbiplot(usarrests.pca, choices = 3:4)

#Questtion 5 Divide Urban Population into a binary outcome (remember you 
#will need to find a splitting rule for urban population into high and low). 
#Create the PCA plot with the two most important principal components
#grouping by the binary urban population outcome.

hist(USArrests$UrbanPop)
USArrests$urbanpop.binary <- ifelse(USArrests$UrbanPop>=65, 1,0)
USArrests$urbanpop.binary <- as.factor(USArrests$urbanpop.binary)
ggbiplot(usarrests.pca, groups = USArrests$urbanpop.binary)

#Question 6 Repeat question five using the second and third most important 
#principal components.

ggbiplot(usarrests.pca,choices = 2:3, groups = USArrests$urbanpop.binary)


