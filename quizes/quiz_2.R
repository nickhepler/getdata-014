#  quiz_2.R
#  Week 2 Quiz

#  Question 1 :: Access the API to get information on your instructors
#  repositories (https://api.github.com/users/jtleek/repos").
#  Use this data to find the time that the datasharing repo was created.
#  What time was it created?
require(httr)
oauth_endpoints("github")

myapp <- oauth_app(
  "github",
  "3871b9a744dfaf3af7aa",
  "90e091f67a2854750ca34b49f8f680fed30bdd95")

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
#  Enter 2 Factor Authentication Code if enabled.

request <- GET("https://api.github.com/rate_limit", config(token = github_token))
stop_for_status(request)
content(request)

BROWSE("https://api.github.com/users/jtleek/repos",
       authenticate("Access Token",
                    "x-oauth-basic",
                    "basic"))

#  Answer: "created_at": "2013-11-07T13:25:07Z"
detach("package:httr", unload=TRUE)

#  Question 2 :: Which of the following commands will select only the data for
#  the probability weights pwgtp1 with ages less than 50?
require(sqldf)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
              dest = "./getdata_data_06pid.csv",
              method = "auto") # Use curl for Linux/Mac.

acs <- read.csv("./getdata_data_06pid.csv")
head(acs)
sqldf("select pwgtp1 from acs") # Selects all rows.
sqldf("select * from acs where AGEP < 50 and pwgtp1") # Selects all variables.
sqldf("select pwgtp1 from acs where AGEP < 50") # Correct answer.
sqldf("select * from acs where AGEP < 50") # Selects all variables.

#  Answer: sqldf("select pwgtp1 from acs where AGEP < 50")

#  Quesiton 3 :: Using the same data frame you created in the previous problem,
#  what is the equivalent function to unique(acs$AGEP)
length(unique(acs$AGEP)) # Returns 91
sqldf("select AGEP where unique from acs") # Invalid syntax.
sqldf("select unique * from acs") # Invalid syntax.
sqldf("select distinct AGEP from acs") # Correct answer.
sqldf("select unique AGEP from acs") # Invalid syntax.

#  Answer: sqldf("select distinct AGEP from acs")
detach("package:sqldf", unload=TRUE)

#  Question 4 :: How many characters are in the 10th, 20th, 30th and 100th
#  lines of HTML from this page:
#  http://biostat.jhsph.edu/~jleek/contact.html
page <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(page)
close(page)
sapply(htmlCode[c(10, 20, 30, 100)], nchar)

#  Answer: 45 31 7 25

#  Question 5 :: Read this data set into R and report the sum of the numbers in
#  the fourth of the nine columns.
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",
              "./wksst8110.for",
              method = 'auto') # Use curl for Linux/Mac.
download <- read.csv("./wksst8110.for")
dim(download)
head(download)
flat_file <- "./wksst8110.for"
data <- read.fwf(file=flat_file,widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4),
  skip=4)

head(data)
print(sum(data[, 4]))

#  Answer: 32426.7

#  Clean up environment
unlink("./getdata_data_06pid.csv")
unlink("wksst8110.for")

rm(list = ls()) # Remove Global Environment variables.
