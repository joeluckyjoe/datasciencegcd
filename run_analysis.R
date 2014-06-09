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

if (!file.exists("gcddata")) {
        dir.create("gcddata")
}

# download the zip file ...

zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipUrl, destfile = "./gcddata/Dataset.zip",method = "internal", mode="wb")
list.files("./gcddata")

# get training set

trainingunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/train/X_train.txt")
trainingset <- read.table(trainingunz, header=FALSE) 
#close(trainingunz)

# get training labels

traininglabelsunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/train/y_train.txt")
traininglabels <- read.table(traininglabelsunz, header=FALSE) 
#close(traininglabelsunz)

# get test set

testunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/test/X_test.txt")
testset <- read.table(testunz, header=FALSE) 
#close(testunz)

# get test labels

testlabelsunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/test/y_test.txt")
testlabels <- read.table(testlabelsunz, header=FALSE) 
#close(testlabelsunz)

# merge training and test sets in one set

measurements <- rbind(trainingset, testset)

# get the feature names from feature.txt file 
# the first variable (V1) contains the number of the feature
# the second variable (V2) contains the name of the feature

featuresunz <- unz("./gcddata/Dataset.zip","UCI HAR Dataset/features.txt")
features <- read.table(featuresunz, header=FALSE) 
featurenames <- features[,2]

# name the measurements dataset using featurenames

names(measurements) <- featurenames
