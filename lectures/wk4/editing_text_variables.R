# editing_text_variables.R
# Editing Text Variables

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

download.file(fileUrl,
  destfile="./data/cameras.csv",
  method="curl")

cameraData <- read.csv("./data/cameras.csv")
names(cameraData)

# Fixing character vectors with tolower(), toupper()
tolower(names(cameraData))

# Fixing character vectors with strsplit()
splitNames <- strsplit(names(cameraData),"\\.")
splitNames[[5]]
splitNames[[6]]

# Quick aside RE lists
mylist <- list(letters = c("A", "b", "c"),
  numbers = 1:3,
  matrix(1:25, ncol = 5))
head(mylist)

mylist[1]
$letters # Produces error, not indicated in slide.
mylist$letters
mylist[[1]]

# Fixing character vectors with sapply()
splitNames[[6]][1]

firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)

fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
download.file(fileUrl1,
  destfile="./data/reviews.csv",
  method="curl")
reviews <- read.csv("./data/reviews.csv")

fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl2,
  destfile="./data/solutions.csv",
  method="curl")
solutions <- read.csv("./data/solutions.csv")

head(reviews,2)
head(solutions,2)

names(reviews)
sub("_","",names(reviews),)

# Fixing character vectors with gsub()
testName <- "this_is_a_test"
sub("_","",testName)
gsub("_","",testName)

# Finding values with grep(),grepl()
grep("Alameda",cameraData$intersection)
table(grepl("Alameda",cameraData$intersection))

cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]

grep("Alameda",cameraData$intersection,value=TRUE)
grep("JeffStreet",cameraData$intersection)
length(grep("JeffStreet",cameraData$intersection))

# More useful string functions
require(stringr)
nchar("Jeffrey Leek")
substr("Jeffrey Leek",1,7)
paste("Jeffrey","Leek")

paste0("Jeffrey","Leek")
str_trim("Jeff      ")

# Clean up Global environment
detach("package:stringr", unload=TRUE)
rm(list=ls())
unlink("./data/cameras.csv")
unlink("./data/reviews.csv")
unlink("./data/solutions.csv")
