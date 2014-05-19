## Week 3 Quiz ##

#############################################################################################
# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file()
# from here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
# and load the data into R. 
# 
# The code book, describing the variable names is here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
#
# Create a logical vector that identifies the households on greater than 10 acres who sold 
# more than $10,000 worth of agriculture products. 
# Assign that logical vector to the variable agricultureLogical. 
# Apply the which() function like this to identify the rows of the data frame where the 
# logical vector is TRUE. 
#   which(agricultureLogical) 
# What are the first 3 values that result?
#############################################################################################
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/housingIdaho.csv", method = "curl")
housingIdaho <- read.csv("./data/housingIdaho.csv")

agricultureLogical <- housingIdaho$ACR == 3 & housingIdaho$AGS == 6
which(agricultureLogical)

#############################################################################################
# Using the jpeg package read in the following picture of your instructor into R 
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 
# 
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data?
#############################################################################################
library(jpeg)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
localFileName <- "./data/jeff.jpg"
download.file(fileUrl, destfile = localFileName, method = "curl")

jpegData <- readJPEG(localFileName, native = TRUE)
quantile(jpegData,probs=c(0.3,0.8))

#############################################################################################
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:     
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# 
# Load the educational data from this data set:   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
#
# Match the data based on the country shortcode. 
# How many of the IDs match? 
# Sort the data frame in descending order by GDP rank. 
# What is the 13th country in the resulting data frame? 
#
# Original data sources: 
#   http://data.worldbank.org/data-catalog/GDP-ranking-table 
#   http://data.worldbank.org/data-catalog/ed-stats
#############################################################################################
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
localFileName <- "./data/GDP.csv"
download.file(fileUrl, destfile = localFileName, method = "curl")
GDPData <- read.csv(localFileName, colClasses = "character")
GDPData$Rank <- as.numeric(GDPData$Gross.domestic.product.2012)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
localFileName <- "./data/EDSTATS_Country.csv"
download.file(fileUrl, destfile = localFileName, method = "curl")
EducationalData <- read.csv(localFileName)

mergedData <- merge(GDPData,EducationalData,by.x="X",by.y="CountryCode",all=FALSE)

library(plyr)
head(arrange(mergedData,desc(Rank)),13)
mergedData <- arrange(mergedData,desc(Rank))

#############################################################################################
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
#############################################################################################

finalTable <- mergedData[!is.na(mergedData$Rank),]
finalTable

prueba <- finalTable[is.na(finalTable$Rank),]
tapply(finalTable$Rank,finalTable$Income.Group,mean)

#############################################################################################
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
# How many countries are Lower middle income but among the 38 nations with highest GDP?
#############################################################################################
library(Hmisc)
finalTable$RankGroup = cut2(finalTable$Rank,g=5)
table(finalTable$RankGroup)

table(finalTable$RankGroup, finalTable$Income.Group)




