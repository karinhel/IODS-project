#LUONNOSPAPERI tehtäville


#viikko 2 ANALYSIS

read.csv(file= "learning2014.csv", header=T, sep=",", fill=T )

str(learning2014)

#Ei knittaa --> asennetaan rprojroot
devtools::install_github("krlmlr/rprojroot")



par(mfrow = c(2,2))
plot(the_model, which=c(1, 2, 5), col=("violetred") )
