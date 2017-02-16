#LUONNOSPAPERI tehtäville


#viikko 2 ANALYSIS

read.csv(file= "learning2014.csv", header=T, sep=",", fill=T )

str(learning2014)

#Ei knittaa --> asennetaan rprojroot
devtools::install_github("krlmlr/rprojroot")



par(mfrow = c(2,2))
plot(the_model, which=c(1, 2, 5), col=("violetred") )

#Analysis exercises (Max 15 points)

#Create a new RMarkdown file and save it as an empty file named 'chapter4.Rmd'. Then include the file as a child file in your 'index.Rmd' file. Perform the following analysis in the file you created.
#Load the Boston data from the MASS package. Explore the structure and the dimensions of the data and describe the dataset briefly, assuming the reader has no previous knowledge of it. Details about the Boston dataset can be seen for example here. (1 point)
#Show a graphical overview of the data and show summaries of the variables in the data. Describe and interpret the outputs, commenting on the distributions of the variables and the relationships between them. (2 points)
#Standardize the dataset and print out summaries of the scaled data. How did the variables change? Create a categorical variable of the crime rate in the Boston dataset (from the scaled crime rate). Use the quantiles as the break points in the categorical variable. Drop the old crime rate variable from the dataset. Divide the dataset to train and test sets, so that 80% of the data belongs to the train set. (2 points)
#Fit the linear discriminant analysis on the train set. Use the categorical crime rate as the target variable and all the other variables in the dataset as predictor variables. Draw the LDA (bi)plot. (3 points)
#Save the crime categories from the test set and then remove the categorical crime variable from the test dataset. Then predict the classes with the LDA model on the test data. Cross tabulate the results with the crime categories from the test set. Comment on the results. (3 points)
##Reload the Boston dataset and standardize the dataset (we did not do this in the Datacamp exercises, but you should scale the variables to get comparable distances). Calculate the distances between the observations. Run k-means algorithm on the dataset. Investigate what is the optimal number of clusters and run the algorithm again. Visualize the clusters (for example with the pairs() or ggpairs() functions, where the clusters are separated with colors) and interpret the results. (4 points)