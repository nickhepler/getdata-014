#  reading_web.R
#  Reading Data from the Web

#  Using readLines() function.
con <- url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode <- readLines(con)
close(con)
htmlCode

#  Parse with XML.
require(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)
xpathSApply(html, "//title", xmlValue)

#  httr package.
require(httr); html2 = GET(url)
content2 <- content(html2,as="text")
parsedHtml <- htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

#  httr package password protected site.
pg2 <- GET(
  "http://httpbin.org/basic-auth/user/passwd",
  authenticate("user","passwd"))

#  httr package using handles.
google <- handle("http://google.com")
pg1 <- GET(handle=google,path="/")
pg2 <- GET(handle=google,path="search")

detach("package:XML", unload=TRUE)
detach("package:httr", unload=TRUE)
