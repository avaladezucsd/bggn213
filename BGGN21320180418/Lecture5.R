#' ---
#' title: "Bioinformatics Lecture 5"
#' author: "Andrew Valadez"
#' date: "April 18th, 2018"
#' ---

# Bioinformatics Lecture 5 
# Plots

x <- rnorm(1000,0)

summary(x)

# lets see this data as a graph
boxplot(x)

# good old histogram
hist(x)






# Section 1 from lab sheet
baby <- read.table("bggn213_05_rstats/weight_chart.txt", header=TRUE)
plot(baby, pch=15, type="l", cex= 1, lwd=25, ylim=c(0,20))


# Section 1b

feat <- read.table("bggn213_05_rstats/feature_counts.txt", sep="\t", header=TRUE)


par(mar=c(5,11,4,2))
barplot(feat$Count, names.arg=feat$Feature, horiz = TRUE, las=2)

## Section 2


mfcount <- read.delim("bggn213_05_rstats/male_female_counts.txt")
rainy <- rainbow(nrow(mfcount))
barplot(mfcount$Count, col = rainy )
barplot(mfcount$Count, col=c("blue","red"))
barplot(mfcount$Count, col=c("blue","red","green"))
barplot(mfcount$Count, col=c("blue","red","red","green"))



## Section 2b

updown <- read.delim("bggn213_05_rstats/up_down_expression.txt")
palette()
levels(updown$State)
palette(c("green","yellow","blue"))
## this one tells you how many genes went up and down in each column
table(updown$State)
plot(updown$Condition1, updown$Condition2, col=updown$State)


