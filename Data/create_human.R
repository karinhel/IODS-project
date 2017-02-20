
# Data wranling
#     for datas "Human development" and "Gender inequality"
#     http://hdr.undp.org/en/content/human-development-index-hdi

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

# Worked :)




###################################################################################################
################################

#EXC 5
##  Data wrangling continues!  ##


human <- read.csv("human.csv")
str(human)

# Why do I have a variable X here? Let's remove it and also mutate the data so that 
# we transform the GNI variable to numeric.

human <- dplyr::select(human, -X)

colnames(human) #worked!

library(stringr)

as.numeric(human$GNI_Cap)

str(human)


## Next, excluding unneeded variables  ##

keep_columns <- c("Country", "Edu2_Ratio", "Lab_Ratio", "Exp_education_years", 
                  "Life_Expectancy", "GNI_Cap", "Mat.mor_Ratio", "Birth_Rate", "Parlament.rep_.")

human <- select(human, one_of(keep_columns))
#Checking..
str(human)  #Worked!


## Removing rows with missing values;   ##

# a completeness indicator
comp <- complete.cases(human)

# adding completeness indicator to the data as the last column
data.frame(human[-1], comp = complete.cases(human))

# filtering out all rows with NA values
human2 <- filter(human, comp==T)

human2


## Next, removing the "wrong" observations    ##

# We take a look at the Country variable to find other observations than countries
tail(human$Country, 10)

# We then define the last seven indices we want to keep
last <- nrow(human) - 7

# choose everything until the last 7 observations
human <- human[1:last,]


## adding countries as rownames   ##

rownames(human2) <- human2$Country

#Removing Country variable

human2 <- dplyr::select(human2, -Country)

str(human2)
# The data has now 155observations and 8 variables, because the Country variable
#                                           is no longer included in the dataset


##  Finally saving the data   ##

write.csv(human2, file="human.csv", row.names = T)






