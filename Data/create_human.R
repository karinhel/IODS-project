
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

