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

setwd("C:/Users/P06226/")

if (!file.exists("gcddata")) {
        dir.create("gcddata")
}

# download the zip file ...

zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./gcddata/Dataset.zip")) {
        download.file(zipUrl, destfile = "./gcddata/Dataset.zip",method = "internal", mode="wb")
}
list.files("./gcddata")

# get the acceleration signal files, the body acceleration signal files
#  and the angular velocity vector file
#total_acc_x_trainunz <- unz("./gcddata/Dataset.zip",
#                            "UCI HAR Dataset/train/Inertial Signals\total_acc_x_train.txt")
#total_acc_x_train <- read.table(total_acc_x_trainunz, header=FALSE)
# ....

# get training set

trainingunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/train/X_train.txt")
trainingset <- read.table(trainingunz, header=FALSE) 
#close(trainingunz)

# get training labels

traininglabelsunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/train/y_train.txt")
traininglabels <- read.table(traininglabelsunz, header=FALSE) 
#close(traininglabelsunz)

# get training subjects

trainingsubjectsunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/train/subject_train.txt")
trainingsubjects <- read.table(trainingsubjectsunz, header=FALSE)

# get test set

testunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/test/X_test.txt")
testset <- read.table(testunz, header=FALSE) 
#close(testunz)

# get test labels

testlabelsunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/test/y_test.txt")
testlabels <- read.table(testlabelsunz, header=FALSE) 
#close(testlabelsunz)

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
#      ... note that we could have chosen to find -mean or -std feature names
# put the result in submeasurementspos that will be an index for subsetting
# put the corresponding names in submeasurementsnames

submeasurementspos <- grepl(".*-(mean|std)\\(\\).*", featurenames)
#submeasurementspos <- grepl(".*-(std|mean)\\(\\).*", featurenames)
submeasurementsnames <- featurenames[submeasurementspos]

# Extract only the measurements on the mean and standard deviation for each measurement based
# on submeasurementspos .

measurements <- measurements[,submeasurementspos]


# 3 Use descriptive activity names to name the activities in the data set

labels <- as.data.frame(lapply(labels, f <- function(x) {x <- activitynames[x] }))
names(labels) <- c("activity")

# 4 Appropriately label the data set with descriptive variable names. 

names(measurements) <- submeasurementsnames
names(labels) <- c("activity")
names(subjects) <- c("subject")

# here's the first dataset ...

measurements <- cbind(subjects,labels, measurements)


# 5 Create a second, independent tidy data set with the average of each variable for each activity 
#   and each subject. 

# melt the measurements

library(reshape2)
mmeasurements <- melt(measurements, id=c("subject", "activity"))

# cast the molten data

#cmeasurements <- acast(mmeasurements, subject ~ activity ~ variable, mean)

cmeasurements <- acast(mmeasurements, subject + activity ~ variable , mean)

#get the subects from the row.names  of the cast data

csubjects <- sub("([0-9]*)\\_.*","\\1",row.names(cmeasurements))

#get the activities from the row.names  of the cast data

cactivities <- sub("([0-9]*)\\_(.*)","\\2",row.names(cmeasurements))

# get the column names of the cast data and prefix them with 'avg-'

ccolumnnames <- attr(cmeasurements,"dimnames")[[2]]
ccolumnnames <- sub("(.*)","avg\\-\\1",ccolumnnames)

# here's the tidy data set ...

tidymeasurements <- as.data.frame(cbind(csubjects,cactivities,cmeasurements))
row.names(tidymeasurements) <- NULL
names(tidymeasurements) <- c("subject","activity",ccolumnnames)
