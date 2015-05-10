#  reading_json.R
#  Reading JSON

require(jsonlite)
require(curl) # Found to be required for Linux.

#  Using GitHub API.
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login

#  Using R iris data set.
myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)
iris2 <- fromJSON(myjson)
head(iris2)

rm(list = ls()) # Remove Global Environment variables.

# Detach loaded packages from R.
detach("package:jsonlite", unload=TRUE)
detach("package:curl", unload=TRUE)