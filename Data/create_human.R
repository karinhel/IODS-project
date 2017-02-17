
# Data wranling
#     for datas "Human development" and "Gender inequality" 

#NAME: Karin Helander
#DATE: 16.02.17


#######################################################################################################
###################################

#opening datas

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv",
               stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv",
                stringsAsFactors = F, na.strings = "..")

#exploring the datas
dim(hd)
dim(gii)
str(hd)
str(gii)

#the human development data has 195 observations of 8 variables and the ohter data that is about
#   gender inequality has also 195 obs of 10 variables.

# Some summaries to see before wrangling with the datas
summary(hd)
summary(gii)

# Renaming the variables at the datasets

hd_new <- c("HDI_Rank", "Country", "HDI_Cap", "Life_Expectancy", "Exp_education_years", "Mean_education_years",
            "GNI_Cap", "GNI.HDI_Rank")
gii_new <- c("GII_Rank", "Country", "GII", "Mat.mor_Ratio", "Birth_Rate", "Parlament.rep_%", "Second.Edu_F",
             "Second.Edu_M", "Labour.Part_F", "Labour.Part_M")

colnames(hd) <- hd_new
# See that it worked;
colnames(hd)

colnames(gii) <- gii_new
colnames(gii)


#Lets then mutate the "Gender inequality" data by creating two new variables.
library(dplyr)

#First variable: Edu2_Ratio
#   --> the ratio of Female and Male populations with secondary education in each country.

gii <- mutate(gii, Edu2_Ratio= Second.Edu_F / Second.Edu_M)

# Second variable:
#   --> the ratio of labour force participation of females and males in each country.

gii <- mutate(gii, Lab_Ratio = Labour.Part_F / Labour.Part_M)

# Aand we have the new variables;
str(gii)


# Joining the data sets! Let's use the variable "country" as an identifier

human <- inner_join(hd, gii, by = "Country", suffix=c(".hd",".gii"))

colnames(human)
glimpse(human)

# Worked yey!

#Finally saving the new data!

write.csv(human, file="human.csv")

read.csv("human")

# Worked so wrangling finished :)



