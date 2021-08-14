## Loding Data

#Method 1
rm(list=ls())

library(datasets)
data("iris")

##Method 2

iris2 <- datasets::iris

## Method 3
?require


if(!require("RCurl"))install.packages('RCurl')

iris3 <- read.csv(text = getURL("https://raw.githubusercontent.com/dataprofessor/data/master/iris.csv"))
#---------------------------------------------------------------------------------------------------------

# VIEW DATA
View(iris3)
View(iris)
View(iris2)
#----------------------------------------

#    SUMMARY STATISTICS

head(iris,10)
tail(iris,10)


#summary
summary(iris)

summary(iris$Sepal.Length,iris$Sepal.Width)
summary(iris$Petal.Length,iris$Petal.Width)
summary(iris$Species)

#--------------------------------------------


#             MISSING DATA

sum(is.na(iris))

#---------------------------------------------

# skimr() - expands on summary() by providing larger set of statistics
#  install.packages("skimr")
# https://github.com/ropensci/skimr

library(skimr,dplyr)

skim(iris)

# Perform SKIM after group by Species

iris%>% 
  dplyr::group_by(Species) %>%
  skim()

#---------------------------------------------------------------------


#            DATA VISUALIZATION
dev.off()
plot(iris)

plot(iris, col ="red")
plot(iris, col ="green")

# SCatter Plot

plot(iris$Sepal.Width,iris$Sepal.Length,col="red")

plot(iris$Sepal.Width,iris$Sepal.Length,col="red",xlab="Sepal Width",ylab="Sepal Length")

# Histogram

hist(iris$Sepal.Length,col="cyan")



# Feature Plots
# https://www.machinelearningplus.com/machine-learning/caret-package/

list.of.packages <- c('caret', 'skimr', 'RANN', 'randomForest', 'fastAdaboost', 'gbm', 'xgboost', 'caretEnsemble', 'C50', 'earth')
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

if(length(new.packages))install.packages(new.packages)

library(caret)
dev.off()

featurePlot(x=iris[,1:4],
            y=iris$Species,
            plot="box",
            strip=strip.custom(par.strip.text=list(cex=.7)),
            scales=list(x=list(relation="free"),
                        y=list(relation="free"))
            )
dev.off()
rm(list = ls())

