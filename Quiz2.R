## Week 2 Quiz ##

#############################################################################################
# Register an application with the Github API here https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories
# (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 
# Use this data to find the time that the datasharing repo was created. 
# What time was it created? This tutorial may be useful 
# (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
# You may also need to run the code in the base R package and not R studio.
#############################################################################################
library(httr)
library(httpuv)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications
#    Insert your values below - if secret is omitted, it will look it up in
#    the GITHUB_CONSUMER_SECRET environmental variable.
#
#    Use http://localhost:1410 as the callback url
myapp <- oauth_app("TestingGitHubAPI", "5405f6d506a62a1fbdc9","6fecea8af78cf96bcf639863b71b5f52c0a1d39d")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
content(req)

library(jsonlite)
json1 = content(req)
json2 = jsonlite::fromJSON(toJSON(json1))
repo <- json2[4,]
names(repo)
repo$created_at

#############################################################################################
# The sqldf package allows for execution of SQL commands on R data frames. 
# We will use the sqldf package to practice the queries we might send with the dbSendQuery 
# command in RMySQL. 
# Download the American Community Survey data and load it into an R object called acs
#
# Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
# sqldf("select * from acs where AGEP < 50")
# sqldf("select pwgtp1 from acs where AGEP < 50")
# sqldf("select * from acs")
# sqldf("select * from acs where AGEP < 50 and pwgtp1")
############################################################################################
library(sqldf)
acs <- read.csv("./data/ss06pid.csv")

sqldf("select * from acs where AGEP < 50")
sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select * from acs")
sqldf("select * from acs where AGEP < 50 and pwgtp1")

#############################################################################################
# Using the same data frame you created in the previous problem, what is the equivalent 
# function to unique(acs$AGEP)
#
# sqldf("select distinct pwgtp1 from acs")
# sqldf("select distinct AGEP from acs")
# sqldf("select AGEP where unique from acs")
# sqldf("select unique AGEP from acs")
#############################################################################################

unique(acs$AGEP)

sqldf("select distinct pwgtp1 from acs")
sqldf("select distinct AGEP from acs")
sqldf("select AGEP where unique from acs")
sqldf("select unique AGEP from acs")


#############################################################################################
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: 
# http://biostat.jhsph.edu/~jleek/contact.html 
#############################################################################################
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
nchar(htmlCode[c(10,20,30,100)])


#############################################################################################
# Read this data set into R and report the sum of the numbers in the fourth column. 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 
#
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 
#############################################################################################
data <- read.fwf("./data/getdata-wksst8110.for", c(10,9,4,9,4,9,4,9,4), header = FALSE)

sum(data$V4)










