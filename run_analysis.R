rm(list = ls())

if (!dir.exists("Project")) {dir.create("Project")}
setwd("./Project")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","projectfiles.zip")
unzip("projectfiles.zip")

# read features, activities
features <- read.csv("./UCI HAR Dataset/features.txt",sep = " ",header = F)
activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt",header = F,col.names = c("Activity","ActivityName"))

# read training measures, activities and subjects
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",header = F,col.names = "Activity",nrows = 7352)
Y_train <- merge(y_train,activity_names, by = "Activity")
head(Y_train)
head(select(Y_train,2))
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt",header = F,col.names = features[,2],nrows = 7352)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",header = F,col.names = "Subject",nrows = 7352)

# merge above to create full training set
train <- cbind(subject_train,select(Y_train,2),X_train)
ncol(train)
nrow(train)
train[1:5,1:10]

# read test measures, activities and subjects
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",header = F,col.names = "Activity",nrows = 2947)
Y_test <- merge(y_test,activity_names, by = "Activity")
head(Y_test)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt",header = F,col.names = features[,2],nrows = 2947)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",header = F,col.names = "Subject")

# merge above to create full test set
test <- cbind(subject_test,select(Y_test,2),X_test)
ncol(test)
nrow(test)
test[1:5,1:10]

# merge training and test sets
all <- rbind(test,train)
ncol(all)
nrow(all)
all[1:5,1:10]

# Extract only the measurements on the mean and standard deviation for each measurement. 
subsetcols <- c(1, 2, grep("mean[^(Freq)]()",names(all)),grep("std()",names(all)))
library(dplyr)
selected <- select(all,subsetcols)
ncol(selected)
selected[1:5,1:18]

# tidy data set with the average of each variable for each activity and each subject
install.packages("reshape2")
library(reshape2)
names(selected)[-1:-2]
selectedmelt <- melt(selected,id = c("ActivityName","Subject"),measure.vars=names(selected)[-1:-2])
head(selectedmelt,10)
meanofall <- dcast(selectedmelt, Subject + ActivityName ~ variable, mean)

# write the new tidy data in a txt file
write.table(meanofall,file = "tidydata.txt",append = F,row.names = F,sep = ",")
