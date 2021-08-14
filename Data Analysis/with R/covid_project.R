rm(list = ls())

covid_df <- read.csv("C:/Users/Desktop/R/covid_dfdata/COVID19_line_list_data.csv")

library(Hmisc)
Hmisc::describe(covid_df)

# View(covid_df)
library(psych)

str(covid_df$death)
summary(covid_df$death)
covid_df$death_dummy <- as.integer(covid_df$death !=0)
library(dplyr)
dplyr::count(covid_df$death)

str(covid_df$death)
summary(covid_df$death)
dim(covid_df$death)
table(covid_df$death)
dim(subset(covid_df,death==0 | death==1))
table(covid_df$gender,useNA='always')
