# set working directory
setwd('H:/coursera_data_science/cleaning_data')


# Question 1
# load library
library(httr)
library(httpuv)

# github oauth settings
myapp <- oauth_app("github", 
                   key = "db788a449a03c57b5a2a",
                   secret = "c1365254615fe5ce709ad6e0a25ed4e76c083aa1")

# get oauth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# use api
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)

# convert unstructured json to structured json
library(jsonlite)
jsondata <- fromJSON(toJSON(content(req)))

# find out the created time of datasharing repo
subset(jsondata, name == "datasharing", select = c(created_at))


# Question 4
# read from html
q4 <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(q4, n = 100)

# find numbers of characters of line 10th, 20th, 30th, 100th
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])



# Question 5
# read fixed width format
q5 <- read.fwf(file = "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", 
               skip = 4, 
               widths = c(-1, 9,-5, 4, 4, -5, 4, 4,-5, 4, 4,-5, 4, 4))
# find the sum of forth column
sum(q5[, 4])
