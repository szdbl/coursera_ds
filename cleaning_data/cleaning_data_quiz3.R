# set working directory
setwd('H:/coursera_data_science/cleaning_data')


# Question 1
# download file from server
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", 
              destfile = "q1.csv")
# read csv file
q1 <- read.csv("q1.csv", header = TRUE)
# load library
library(plyr)
library(dplyr)
# create a logical vector
q1 <- mutate(q1, agricultureLogical=factor((ACR == 3 & AGS == 6), levels = c(TRUE, FALSE)))
# show the first 3 row names which the logical value are TRUE
head(row.names(q1[which(q1$agricultureLogical == TRUE),]), 3)


# Question 2
# download jpeg file from server
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", 
              destfile = "q2.jpg")
# load library
library(jpeg)
# read jpeg file
q2 <- readJPEG(source = "q2.jpg", 
               native = TRUE)
# show the 30th and 80th quantiles
quantile(q2, c(0.3, 0.8))


# Question 3
# download file from server
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
              destfile = "q3_1.csv")
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", 
              destfile = "q3_2.csv")

# load the datasets
q3_1 <- read.csv("q3_1.csv", header = TRUE, skip = 3, sep = ",")
q3_2 <- read.csv("q3_2.csv", header = TRUE)

# reshaping data
q3_1 <- q3_1[2:191, c(1,2,4,5)]
rownames(q3_1) <- NULL
q3_1 <- rename(q3_1, CountryCode = X)

# merge two datasets
q3_merge <- join(q3_1, q3_2)

# show the number of matches
sum(!is.na(unique(q3_merge$Ranking)))

# convert the data type of Ranking
q3_merge$Ranking <- as.numeric(as.character(q3_merge$Ranking))

# show the 13th country after sort decending
q3_merge <- arrange(q3_merge, desc(Ranking))
q3_merge[13,3]


# Question 4
# Group q3_merge by Income.Group
income_group <- group_by(q3_merge, Income.Group)
summarise(income_group, avg = mean(Ranking, na.rm = TRUE))


# Question 5
# cut Ranking into 5 quantile groups
q3_merge$RankingGroup <- cut(q3_merge$Ranking, breaks = 5)

# make a table vs Income.Group
table(q3_merge$RankingGroup, q3_merge$Income.Group)

