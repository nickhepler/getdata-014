# quiz_3.R
# Week 3 Quiz

# Question 1 :: Create a logical vector that identifies the households on
# greater than 10 acres who sold more than $10,000 worth of agriculture
# products. Assign that logical vector to the variable agricultureLogical.
# Apply the which() function like this to identify the rows of the data frame
# where the logical vector is TRUE. which(agricultureLogical) What are the first
# 3 values that result?
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
  "./data/ss06hid.csv",
  method = "curl")

acs <- read.csv("./data/ss06hid.csv")
unlink("./data/ss06hid.csv")
head(acs)
agricultureLogical <- acs$ACR == 3 & acs$AGS == 6
which(agricultureLogical)

# Answer: 125, 238, 262
rm(acs, agricultureLogical)

# Question 2 :: Use the parameter native=TRUE. What are the 30th and 80th
# quantiles of the resulting data? (some Linux systems may produce an answer 638
# different for the 30th quantile)
require(jpeg)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
  "./data/jeff.jpg",
  method = "auto") # Unable to install jpeg package, had to complete in Windows.

pic <- readJPEG("./data/jeff.jpg", native = TRUE)
quantile(pic, probs = c(0.3, 0.8))

# Answer: -16776939 -10092545
rm(pic)
unlink("./data/jeff.jpg")
detach("package:jpeg", unload=TRUE)

# Question 3 :: Match the data based on the country shortcode. How many of the
# IDs match? Sort the data frame in descending order by GDP rank (so United
# States is last). What is the 13th country in the resulting data frame? (dplyr)
require("dplyr")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              "./data/GDP.csv",
              method = "curl")

gdp <- read.csv("./data/GDP.csv", skip = 4, nrows = 215)
head(gdp, 2)
tail(gdp, 2)
names(gdp)

gdp <- tbl_df(gdp)
gdp <- filter(gdp, X != "")  # 191 has missing value.
gdp <- select(gdp, -X.2)  # All values NA
gdp <- select(gdp, -(X.5:X.9)) # All values NA
gdp <- rename(gdp, CountryCode = X, Rank = X.1, Country = X.3, GDP = X.4)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
              "./data/Country.csv",
              method = "curl")
country <- read.csv("./data/Country.csv")

head(country, 2)
tail(gdp, 2)
names(country)

intersect(names(gdp),names(country))

mergedData <- merge(gdp,country,by.x="CountryCode",by.y="CountryCode",all=TRUE)
mergedData <- tbl_df(mergedData)
sum(!is.na(unique(mergedData$Rank)))
mergedData <-arrange(mergedData, desc(Rank))
mergedData[13,1:5]

# Answer: 189 matches, 13th country is St. Kitts and Nevis

# Question 4 :: What is the average GDP ranking for the "High income: OECD" and 
# "High income: nonOECD" group?
mergedData %>% group_by(Income.Group) %>%
  summarize(Rank = mean(Rank, na.rm=TRUE))

# Answer: High income: OECD  32.96667, High income: nonOECD  91.91304
detach("package:dplyr", unload=TRUE)

# Question 5 :: Cut the GDP ranking into 5 separate quantile groups. Make a 
# table versus Income.Group. How many countries are Lower middle income but 
# among the 38 nations with highest GDP?
require("Hmisc")

mergedDat$Groups <- cut2(mergedDat$Rank,g=5)
table(mergedData$Groups)

detach("package:Hmisc", unload=TRUE)

rm(list=ls())
unlink("./data/Country.csv")
unlink("./data/GDP.csv")