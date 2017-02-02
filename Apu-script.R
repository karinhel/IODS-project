#LUONNOSPAPERI tehtäville


#viikko 2 ANALYSIS

read.csv(file= "learning2014.csv", header=T, sep=",", fill=T )

str(learning2014)

#Ei knittaa --> asennetaan rprojroot
devtools::install_github("krlmlr/rprojroot")
