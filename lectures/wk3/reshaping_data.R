#  reshaping_data.R
#  Reshaping Data

require(reshape2)
require(plyr)
head(mtcars)

#  Melting data frames
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))

head(carMelt,n=3)
tail(carMelt,n=3)

#  Casting data frames
cylData <- dcast(carMelt, cyl ~ variable)
cylData

cylData <- dcast(carMelt, cyl ~ variable,mean)
cylData

#  Averaging values
head(InsectSprays)
tapply(InsectSprays$count,InsectSprays$spray,sum)

#  Another method - split
spIns =  split(InsectSprays$count,InsectSprays$spray)
spIns

#  Yet another method - apply
sprCount = lapply(spIns,sum)
sprCount

#  ...and another way - combine
unlist(sprCount)
sapply(spIns,sum)

#  Now another way - plyr package
ddply(InsectSprays,.(spray),summarize,sum=sum(count))

#  Creating a new variable
spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))
dim(spraySums)
head(spraySums)

detach("package:reshape2", unload=TRUE)
detach("package:plyr", unload=TRUE)
