#  reading_mySQL.R
#  Reading mySQL

#  Requires RMySQL package; RMySQL depends DBI.
require("DBI")
require("RMySQL")

#  Connect to mySQL database.
testDb <- dbConnect(
  MySQL(),user="coursera",
  host="192.168.1.100")

#  Store results of show databases SQL command and disconnect.
result <- dbGetQuery(testDb,"show databases;"); dbDisconnect(testDb);

print(result)

#  Connecting to database and listing tables.
coursera <- dbConnect(MySQL(),user="coursera", db="coursera",
                      host="192.168.1.100")
allTables <- dbListTables(coursera)
length(allTables)

print(allTables[1:2])

# Get dimensions of a specific table.
dbListFields(coursera,"posts")

# Perform SQL Select Query
dbGetQuery(coursera, "select count(*) from posts")

# Read data from table
postData <- dbReadTable(coursera, "posts")
head(postData)

# Select a specific subset
query <- dbSendQuery(coursera, "select * from posts where author_id between 1 and 3")
postsMis <- fetch(query); quantile(postsMis$author_id)

# Select the first 10 records.
postsMisSmall <- fetch(query,n=10); dbClearResult(query);

dim(postsMisSmall)

dbDisconnect(coursera)

#  Unload packages
detach("package:RMySQL", unload=TRUE)
detach("package:DBI", unload=TRUE)
