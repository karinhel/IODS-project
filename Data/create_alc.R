
#NAME: Karin Helander
#DATE: 06.02.17

#This is the data wrangling script for putting together the alc-datas. Let's have a look!

#Data from: https://archive.ics.uci.edu/ml/datasets/STUDENT+ALCOHOL+CONSUMPTION


#############################################################################################
##############################


# (3) We open both datas before merging them into one file

math <- read.table("student-mat.csv", sep = ";" , header=TRUE)
por <- read.table("student-por.csv", sep = ";", header=T)

#Take a look at the structure;
str(math)
str(por)
# And dimensions;
dim(math)
dim(por)
# We see that the two datas are equal in variables. They both have 33 variables, but 
#             the por-data has nearly two times more observations than the math-data.


# (4) Join the datas!
# Access the dplyr so that we can use the inner_join prosedure.
library(dplyr)

# Common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob",
             "reason","nursery","internet")

# Join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix=c(".math",".por"))

# Let's then look at the structure;
str(math_por)
dim(math_por)
colnames(math_por)

#Math_por data now seems to have 382 observations of 53 variables.
#    That is not quite what we wanted, because the original datasets had
#    both 33 variables. Allthough the first 11 variables are merged from the original datas,
#    the rest of the variables are doubled in our new dataset.
#    This is, because our datas had the same variables with possibly differing answers
#    and only our indentifiers where notifies ones.
#    So let's merge the other variables into just one.


# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- select(two_columns, 1)[[1]]
  }
}

# Take a glimpse at the new combined data
glimpse(alc)

#We managed to (with the best help of Datacamp) merge our dataset into a form with 33
#     variables only. From numeric variables we have the rounded average and from
#     nominal variables we have the first answer of two same-named column vectors.

# Finally saving the data
write.csv(alc, file="alc.csv")




