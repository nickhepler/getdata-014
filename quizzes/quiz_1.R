#  quiz_1.R
#  Week 1 Quiz

#  Question 1 :: How many properties are worth $1,000,000 or more?
require(data.table)

if (!file.exists("data")) {
  dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,
  destfile = "./data/ss06hid.csv",
  method = "curl") #  Requied for Linux, Mac - use wb for Windows

list.files("./data")

dateDownloaded <- date()
dateDownloaded

ss06hid <- read.csv("./data/ss06hid.csv")
ss06hid <- data.table(ss06hid)
nrow(ss06hid[ss06hid$VAL==24])
#  Answer: 53

#  Question 2 :: Use the data you loaded from Question 1. Consider the variable
#  FES in the code book. Which of the "tidy data" principles does this variable
#  violate?

#  No R Source Required

#  Answer: Tidy data has one variable per column.

#  Question 3 :: What is the value of: sum(dat$Zip*dat$Ext,na.rm=T)?
require("xlsx")

if(!file.exists("data")){dir.create("data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

download.file(fileUrl,
  destfile="./data/ngap.xlsx",
  method="curl")

dateDownloaded <- date()

colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("./data/ngap.xlsx",
  sheetIndex=1,
  header=TRUE,
  colIndex=colIndex,
  rowIndex=rowIndex)

sum(dat$Zip*dat$Ext,na.rm=T)
#  Answer: 36534720

#  Question 4 :: How many restaurants have zipcode 21231?
require(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
rootNode <- xmlRoot(doc)
sum(xpathSApply(rootNode, "//zipcode", xmlValue)==21231)
#  Answer: 127

#  Question 5 :: Which of the following is the fastest way to calculate the 
#  average value of the variable?
if (!file.exists("data")) {
  dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl,
              destfile = "./data/ss06pid.csv",
              method = "curl") #  Requied for Linux, Mac - use wb for Windows

list.files("./data")

dateDownloaded <- date()
dateDownloaded

DT <- fread("./data/ss06pid.csv")
file.info("./data/ss06pid.csv")$size
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(DT[,mean(pwgtp15),by=SEX])

#  Answer: DT[,mean(pwgtp15),by=SEX]

rm(list = ls()) # Remove Global Environment variables.
