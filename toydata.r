toydata <- read.csv(file = "C:/Users/Lenovo/Documents/toydata.csv", header = TRUE)
install.package("ggplot2")
library(ggplot2)
View(toydata)
install.packages("scatterplot3d", dependencies = TRUE)
library(scatterplot3d)
library(rgl)
myColorRamp <- function(colors, values) {
  v <- (values - min(values))/diff(range(values))
  m <- colorRamp(colors)(v)
  rgb(m[,1], m[,2], m[,3], maxColorValue = 255)
}
s = toydata$s
x1 = toydata$x1
x2 = toydata$x2
cols <- myColorRamp(c("red", "blue"), y)
plot3d(y = s, x = x1, z = x2, col = cols)
scatterplot3d(y = s, x = x1, z = x2, color = cols)
# PCA
library(dplyr)
library(psych)

glimpse(toydata)

toydata1 <- select(toydata, -X, -s)


describe(toydata1)

cor(toydata1)

toydata1.pca <- prcomp(toydata1, scale = TRUE)

x3 <- toydata1.pca$x[,1]
v1 <- toydata1.pca$rotation[,1]
v1
x3

head(x3)

summary(toydata1.pca)
cor(toydata1, x3)
plot(toydata1.pca)
biplot(toydata1.pca)
library(car)
scatterplot(y=y, x=x3)

print(cor(toydata1))

cor.test(toydata1$x1,toydata1$x2)

library(knitr)


head(toydata1.pca$x)

head(toydata1.pca$rotation)

pc1 <- toydata1.pca$x[,1]
pc1
s <- toydata$s
plot(y=s, x=pc1, col = cols, ylab = names(s), xlab = names(pc1), main = "onedementional data")

summary(toydata1.pca)

plot(toydata1.pca, ylab(label = "Histogram"))

? plot

exp_percent <- summary(toydata1.pca)$importance[2, ]
qplot(y = exp_percent, x = names(exp_percent)) + 
  geom_bar(stat = 'identity') +
  labs(x = "Principal components",
       y = "Variances"   )
