#  run_analysis.R
#
#  Version 0.1.0
#
#  Copyright 2015 Nick Hepler <nick.hepler@outlook.com>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.

#  1. Merge the training and the test sets to create one data set.
subject.train <- read.table("./data/train/subject_train.txt")
subject.test <- read.table("./data/test/subject_test.txt")
subject <- rbind(subject.train, subject.test)

x.train <- read.table("./data/train/X_train.txt")
x.test <- read.table("./data/test/X_test.txt")
x <- rbind(x.train, x.test)

y.train <- read.table("./data/train/y_train.txt")
y.test <- read.table("./data/test/y_test.txt")
y <- rbind(y.train, y.test)

rm(subject.train, subject.test, x.train, x.test, y.train, y.test)

#  2. Extract only the measurements on the mean and standard deviation for
#  each measurement.
features <- read.table("./data/features.txt")
indices.features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
names(x) <- tolower(names(x))
x <- x[, indices.features]
names(x) <- features[indices.features, 2]
names(x) <- gsub("\\(|\\)", "", names(x))

# 3. Use descriptive activity names to name the activities in the data set
activities <- read.table("./data/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
y[,1] = activities[y[,1], 2]
names(y) <- "activity"

# 4. Appropriately label the data set with descriptive variable names.
names(subject) <- "subject"
tidy <- cbind(subject, y, x)
write.table(tidy, "./data/merged_tidy_data.txt")

# 5. Create a 2nd, independent tidy data set with the average of each variable 
# for each activity and each subject.

unique.subjects <- unique(subject)[,1]
num.subjects <- length(unique(subject)[,1])
num.activities <- length(activities[,1])
num.cols <- dim(tidy)[2]
result <- tidy[1:(num.subjects*num.activities), ]

row <- 1
for (s in 1:num.subjects) {
  for (a in 1:num.activities) {
    result[row, 1] = unique.subjects[s]
    result[row, 2] = activities[a, 2]
    temp <- tidy[tidy$subject==s & tidy$activity==activities[a, 2], ]
    result[row, 3:num.cols] <- colMeans(temp[, 3:num.cols])
    row = row+1
  }
}
write.table(result, "./data/data_set_with_the_avgs.txt", row.name=FALSE)