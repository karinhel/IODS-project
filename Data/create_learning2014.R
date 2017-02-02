################################################################################################

# NAME: KARIN HELANDER
# DATE: 31.01.17
# This is the data wrangling file for IODS-project!

################################################################################################

#(1)
#Open data in r
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#(2)
#dimensions
dim(lrn14)
#We see that there are 183 observation of 60 variables
#(can also be seen at the data environment)
str(lrn14)
#There is many interval-scaled variables and gender, which is a two leveled factor variable.

#(3)#

install.packages("dplyr")
library(dplyr)

#First, let's create some new variables;
# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D07","D14","D22","D30")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# selecting the columns related to :
#deep learning // creating column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

#surface learning
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

#strategic learning
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)


#now we can create new analysis dataset with the following variables
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

learning2014 <- select(lrn14, one_of(keep_columns))
str(learning2014)
#we have the right dataset!

#excluding observations with points </=0
learning2014 <- filter(learning2014, Points > 0)

summary(learning2014)
#did work!


#(4)#

?write.csv()

#saving
write.csv(learning2014, file="learning2014.csv")
#yes it did work;
read.csv("learning2014.csv", row.names=1)













