## Week 4 Quiz ##

################################################################################
# The American Community Survey distributes downloadable data about United 
# States communities. Download the 2006 microdata survey about housing for the 
# state of Idaho using download.file() from here: 
#
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
#
# and load the data into R. The code book, describing the variable names is 
# here: 
#  
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
#
# Apply strsplit() to split all the names of the data frame on the characters 
# "wgtp". 
# What is the value of the 123 element of the resulting list?
################################################################################

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/housingIdaho.csv", method = "curl")
housingIdaho <- read.csv("./data/housingIdaho.csv")

result <- strsplit(names(housingIdaho), "wgtp")
result[[123]]

################################################################################
# Load the Gross Domestic Product data for the 190 ranked countries in this data
# set: 
#
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
#
# Remove the commas from the GDP numbers in millions of dollars and average 
# them. What is the average? 
#
# Original data sources: 
#   http://data.worldbank.org/data-catalog/GDP-ranking-table
################################################################################

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
localFileName <- "./data/GDP.csv"
download.file(fileUrl, destfile = localFileName, method = "curl")
GDPData <- read.csv(localFileName, colClasses = "character")
GDPData <- GDPData[5:194,]
GDPData$X.3 <- as.numeric(gsub(",","",GDPData$X.3))
mean(GDPData$X.3)

################################################################################
# In the data set from Question 2 what is a regular expression that would allow 
# you to count the number of countries whose name begins with "United"? 
# Assume that the variable with the country names in it is named countryNames. 
# How many countries begin with United?
################################################################################
countryNames <- GDPData$X.2

grep("*United",countryNames), 2
grep("^United",countryNames), 3
grep("^United",countryNames), 4
grep("United$",countryNames), 3

################################################################################
# Load the Gross Domestic Product data for the 190 ranked countries in this data 
# set: 
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# 
# Load the educational data from this data set: 
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
# 
# Match the data based on the country shortcode. Of the countries for which the 
# end of the fiscal year is available, how many end in June? 
# 
# Original data sources: 
#   http://data.worldbank.org/data-catalog/GDP-ranking-table 
#   http://data.worldbank.org/data-catalog/ed-stats
################################################################################
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
localFileName <- "./data/GDP.csv"
download.file(fileUrl, destfile = localFileName, method = "curl")
GDPData <- read.csv(localFileName, colClasses = "character")
GDPData$Rank <- as.numeric(GDPData$Gross.domestic.product.2012)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
localFileName <- "./data/EDSTATS_Country.csv"
download.file(fileUrl, destfile = localFileName, method = "curl")
EducationalData <- read.csv(localFileName)

mergedData <- merge(GDPData,EducationalData,by.x="X",by.y="CountryCode",
                    all=FALSE)

grep("Fiscal year end: June",mergedData$Special.Notes)

################################################################################
# You can use the quantmod (http://www.quantmod.com/) package to get historical 
# stock prices for publicly traded companies on the NASDAQ and NYSE. 
# Use the following code to download data on Amazon's stock price and get the 
# times the data was sampled.
#   library(quantmod)
#   amzn = getSymbols("AMZN",auto.assign=FALSE)
#   sampleTimes = index(amzn) 
# How many values were collected in 2012? 
# How many values were collected on Mondays in 2012?
################################################################################
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

## Formatting dates
# %d = day as number (0-31), 
# %a = abbreviated weekday,
# %A = unabbreviated weekday, 
# %m = month (00-12), 
# %b = abbreviated month, 
# %B = unabbrevidated month, 
# %y = 2 digit year, 
# %Y = four digit year

byyear <- sampleTimes[format(sampleTimes,"%Y") == "2012"]
length(byyear)

monday2012 <- byyear[format(byyear, "%A") == "Monday"]
length(monday2012)