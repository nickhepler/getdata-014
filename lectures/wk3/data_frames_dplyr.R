#  data_frames_dplyr.R
#  Managing Data Frames with dplyr - Basic Tools

require(dplyr)

if (!file.exists("data")) {
  dir.create("data")
}

fileUrl <- "https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/dplyr/chicago.rds?raw=true"
download.file(fileUrl,
              destfile = "./data/chicago.rds",
              method = "auto") #  Requied for Linux, Mac - use auto for Windows

chicago <- readRDS("./data/chicago.rds")  # Had to download manually.
dim(chicago)
names(chicago)

# Select
head(select(chicago,1:5))
names(chicago)[1:3]
head(select(chicago, city:dptp))
head(select(chicago, -(city:dptp)))

# Filter
chic.f <- filter(chicago, pm25tmean2 > 30)
head(select(chic.f, 1:3, pm25tmean2),10)

chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(select(chic.f, 1:3, pm25tmean2, tmpd),10)

# Arrange
chicago <- arrange(chicago, date)
head(select(chicago, date, pm25tmean2),3)
tail(select(chicago, date, pm25tmean2),3)

chicago <- arrange(chicago, desc(date)
head(select(chicago, date, pm25tmean2),3)
tail(select(chicago, date, pm25tmean2),3)

# Rename
chicago <- rename(chicago, 
                  dewpoint = dptp, 
                  pm25 = pm25tmean2)

head(select(chicago,1:5))
chicago <- mutate(chicago,
                  pm25detrend=pm25-mean(pm25, na.rm=TRUE))
head(select(chicago, pm25, pm25detrend))
tail(select(chicago, pm25, pm25detrend))

# Group By
chicago <- mutate(chicago,
  tempcat=factor(1*(tmpd > 80),
  labels = c("cold","hot")))

hotcold <- group_by(chicago, tempcat)

summarize(hotcold,pm25=mean(pm25,na.rm=TRUE),
 o3=max(o3tmean2),
 no2=median(no2tmean2))

chicago %>% 
  mutate(month=as.POSIXlt(date)$mon+1) %>%
  group_by(month) %>%
  summarize(pm25=mean(pm25,na.rm=TRUE),
  o3=max(o3tmean2, na.rm=TRUE),
  no2=median(no2tmean2, na.rm=TRUE))