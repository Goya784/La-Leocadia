---
#' title:Bioinformatics Class 5
#' author= MD
#Plots
     html_document:
         code_folding: hide
---
#
#-----
x <- rnorm(1000,0)


summary(x)

#lets see this data as a graph
boxplot(x)

#Good old histograms
hist(x)

## Section 1 from lab sheet
read.table("bggn213_05_rstats/weight_chart.txt")
baby <- read.table("bggn213_05_rstats/weight_chart.txt", header = TRUE)
View(baby)
plot(baby, type = "b", pch = 14, cex = 4, ylim=c(0,12), lwd=5, lty=2)
baby

#Section 1B
feat <- read.table("bggn213_05_rstats/feature_counts.txt", sep="\t", 
                   header = TRUE)
View(feat)
par(mar=c(5,11,4,2))
barplot(feat$Count, names.arg=feat$Feature, horiz = TRUE, las = 2)
rnorm
hist(rnorm(1000), rnorm(1000+4))

# Section 2
#read.table("bggn213_05_rstats/male_female_counts.txt", sep="\t", header = TRUE)

mfcount <- read.delim("bggn213_05_rstats/male_female_counts.txt", 
          sep="\t", header = TRUE)

barplot(mfcount$Count, col = rainbow(nrow(mfcount)))
nrow(mfcount)
rainbow(10)

udexpression <- read.delim("bggn213_05_rstats/up_down_expression.txt", header= TRUE)
plot(udexpression$Condition1,udexpression$Condition2, col= udexpression$State)
palette()
nrow(udexpression)
table(udexpression$State)     
