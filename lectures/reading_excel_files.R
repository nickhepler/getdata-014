#  reading_excel_files.R
#  Reading Excel Files

require("xlsx")

if(!file.exists("data")){dir.create("data")}

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"

download.file(fileUrl,
  destfile="./data/cameras.xlsx",
  method="curl")

dateDownloaded <- date()

cameraData <- read.xlsx("./data/cameras.xlsx",
  sheetIndex=1,
  header=TRUE)

head(cameraData)

#  Read specific rows and columns
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx",
  sheetIndex=1,
  colIndex=colIndex,
  rowIndex=rowIndex)

cameraDataSubset

rm(list = ls()) # Remove Global Environment variables.
unlink("./data/cameras.xlsx") # Delete downloaded file.

# Detach loaded packages from R.
detach("package:xlsx", unload=TRUE)
detach("package:xlsxjars", unload=TRUE)
detach("package:rJava", unload=TRUE)

