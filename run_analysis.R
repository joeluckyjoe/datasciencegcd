# run_analysis.R  does the following. 
# 
# 1 Merge the training and the test sets to create one data set.
# 
# 2 Extract only the measurements on the mean and standard deviation for each measurement. 
# 
# 3 Use descriptive activity names to name the activities in the data set
# 
# 4 Appropriately label the data set with descriptive variable names. 
# 
# 5 Create a second, independent tidy data set with the average of each variable for each activity 
#   and each subject. 



# 1 Merge the training and the test sets to create one data set.

# create a directory where we will download the zip file

#setwd("C:/Users/P06226/")

if (!file.exists("gcddata")) {
        dir.create("gcddata")
}

# download the zip file ...

zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists("./gcddata/Dataset.zip")) {
        download.file(zipUrl, destfile = "./gcddata/Dataset.zip",method = "internal", mode="wb")
}

list.files("./gcddata")


# get training set

trainingunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/train/X_train.txt")

trainingset <- read.table(trainingunz, header=FALSE) 

# get training labels

traininglabelsunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/train/y_train.txt")

traininglabels <- read.table(traininglabelsunz, header=FALSE) 

# get training subjects

trainingsubjectsunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/train/subject_train.txt")

trainingsubjects <- read.table(trainingsubjectsunz, header=FALSE)

# get test set

testunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/test/X_test.txt")

testset <- read.table(testunz, header=FALSE) 

# get test labels

testlabelsunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/test/y_test.txt")

testlabels <- read.table(testlabelsunz, header=FALSE) 

# get test subjects

testsubjectsunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/test/subject_test.txt")

testsubjects <- read.table(testsubjectsunz, header=FALSE)

# merge training and test sets in one set

measurements <- rbind(trainingset, testset)

# get the feature names from feature.txt file 
# the first variable (V1) contains the number of the feature
# the second variable (V2) contains the name of the feature

featuresunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/features.txt")

features <- read.table(featuresunz, header=FALSE) 

featurenames <- features[,2]

# merge training and test labels in one set

labels <- rbind(traininglabels, testlabels)

# merge training and test subjects in one set

subjects <- rbind(trainingsubjects, testsubjects)


# get the activity labels

activitiesunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/activity_labels.txt")

activities <- read.table(activitiesunz, header=FALSE) 

activitynames <- activities[,2]


# 2 Extract only the measurements on the mean and standard deviation for each measurement.

# find the position for the feature names that contain -mean() or -std() using grepl()
# put the result in submeasurementspos that will be an index for subsetting
# put the corresponding names in submeasurementsnames

submeasurementspos <- grepl(".*-(mean|std)\\(\\).*", featurenames)

submeasurementsnames <- featurenames[submeasurementspos]

# Extract only the measurements on the mean and standard deviation for each measurement based
# on submeasurementspos .

measurements <- measurements[,submeasurementspos]

# 3 Use descriptive activity names to name the activities in the data set

library(plyr)

labels <- join(labels,activities)


# 4 Appropriately label the data set with descriptive variable names. 

names(measurements) <- tolower(gsub("\\(\\)","",gsub("-","",submeasurementsnames)))

names(labels) <- c("activity","activityname")

names(subjects) <- c("subject")

# here's the first dataset ...

measurements <- cbind(subjects,labels$activityname, measurements)

names(measurements)[2] <- "activity"


# 5 Create a second, independent tidy data set with the average of each variable for each activity 
#   and each subject. 

library(plyr)

tidydata <- ddply(measurements,.(activity,subject),numcolwise(mean),.drop=TRUE)

names(tidydata)[3:length(names(tidydata))] <- 
        sub("(.*)","avg\\1",names(tidydata)[3:length(names(tidydata))])


# write tdm to a file using write.table

write.table(tidydata, file= "./gcddata/tidydata.txt", row.names = FALSE)

list.files("./gcddata")

# read the file back using read.table do not forget to user "header = TRUE"
#tdm2 <- read.table("./gcddata/tidydata.txt", header = TRUE)

