* 1 Study design :
  
  The aim of this study is to show how we can download data from the web , to clean it in some way and to summarize it.
 
  The data was collected by downloading a dataset in zip format from the following URL:
    
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    
  which corresponds to Human Activity Recognition Using Smartphones Dataset Version 1.0
   
  Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
 
  [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on     Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted       Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
 
  Very useful information about the raw data that has been used in this study can be found in the 
   UCI HAR Dataset/README.txt, UCI HAR Dataset/features_info.txt files
   
  The tidydata dataframe and tidydata.txt file were generated following 6 steps:
  
  * 1 Merge the training and the test sets to create one data set.
    
    Read training and test sets:
     
     Read the UCI HAR Dataset/train/X_train.txt file into trainingset dataframe: we obtain 7352 obs. of 561 variables.
     
     Read the UCI HAR Dataset/test/X_test.txt file into testset dataframe: we obtain 2947 obs. of 561 variables
    
    Read training and test labels:
     
     Read the UCI HAR Dataset/train/y_train.txt file into traininglabels dataframe: we obtain 7352 obs. of 1 variables
     
     Read the UCI HAR Dataset/test/y_test.txt file into testlabels dataframe: we obtain 2947 obs. of 1 variables
 
    Read training and test subjects:
     
     Read the UCI HAR Dataset/train/subject_train.txt file into trainingsubjects dataframe: we obtain 7352 obs. of 1          variables
     
     Read the UCI HAR Dataset/test/subject_test.txt file into testsubjects dataframe: we obtain 2947 obs. of 1                variables
     
    Merge trainingset and testset into measurements dataframe: we obtain 10299 obs. of 561 variables 
    
    Merge traininglabels and testlabels into labels dataframe: we obtain 10299 obs. of 1 variables 
    
    Merge trainingsubjects  and testsubjects into subjects dataframe: we obtain 10299 obs. of 1 variables
    
    rbind() function was used for the merges
    
    Read the descriptive activity names that will be used to name the activities in the dataset:
    
      Read the UCI HAR Dataset/activity_labels.txt file into activities dataframe: we obtain 6 obs. of 2 variables
     
    
    Read the  descriptive variable names that will be used to label the dataset:
    
      Read theUCI HAR Dataset/features.txt file into features dataframe: we obtain 561 obs. of 2 variables
     
  * 2 Extract only the measurements on the mean and standard deviation for each measurement.
    
    Use the grepl() command to creates submeasurementspos index that will be used 
     
     to select only the variables that contain -mean() and -std() in their name.
    
    Now for the measurements dataframe: we obtain 10299 obs. of 66 variables
 
    Use the submeasurementpos index to extract a subset of the descriptive variable names into submeasurementsnames
    
  * 3 Use descriptive activity names to name the activities in the data set
  
    Use the join() function from the plyr package to join labels and activities dataframes into labels datatframe:
     
       we obtain 10299 obs. of 2 variables
  

  * 4 Appropriately label the data set with descriptive variable names.
    
    Use the names() function to rename the columns of the measurements, labels ans subjects dataframes

  * 5 use cbind() and names() functions to merge subjects, labels and measurements dataframes into
      measurements dataframe: we obtain 10299 obs. of 68 variables

  * 6 Create a second, independent tidy data set with the average of each variable for each activity (6 acctivities) 
      and each subject (30 subjects)
 
    Use the ddply() function from the plyr package, the name() and write.table() function
    
    We obtain tidydata : 180 obs. of 68 variables
              tidydata.txt
              
* 2  CodeBook for tidydata and tidydata.txt:
  
 'data.frame':	180 obs. of  68 variables.
 
  $ activity : factor [WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING]
  
  $ subject: int[1:30]
 
  Note about the units  and ranges for variable names other than "activity" and "subject".
  
  They correspond to variable names prefixed by avg.
  
  If we read carefully the UCI HAR Dataset/README.txt, UCI HAR Dataset/features_info.txt files,
  
  we know that all those variables are normalized and bounded within [-1,1].
  
  We also know that the units for the "acc" variables are in  standard gravity units 'g'.
  
  We also know that the units for the "gyro" variables are in radians/second 
 
  Here's the list of those variables: 
 
   $ avgtbodyaccmeanx           
   $ avgtbodyaccmeany           
   $ avgtbodyaccmeanz           
   $ avgtbodyaccstdx            
   $ avgtbodyaccstdy            
   $ avgtbodyaccstdz            
   $ avgtgravityaccmeanx        
   $ avgtgravityaccmeany        
   $ avgtgravityaccmeanz        
   $ avgtgravityaccstdx         
   $ avgtgravityaccstdy         
   $ avgtgravityaccstdz         
   $ avgtbodyaccjerkmeanx       
   $ avgtbodyaccjerkmeany       
   $ avgtbodyaccjerkmeanz       
   $ avgtbodyaccjerkstdx        
   $ avgtbodyaccjerkstdy        
   $ avgtbodyaccjerkstdz        
   $ avgtbodygyromeanx          
   $ avgtbodygyromeany          
   $ avgtbodygyromeanz          
   $ avgtbodygyrostdx           
   $ avgtbodygyrostdy           
   $ avgtbodygyrostdz           
   $ avgtbodygyrojerkmeanx      
   $ avgtbodygyrojerkmeany      
   $ avgtbodygyrojerkmeanz      
   $ avgtbodygyrojerkstdx       
   $ avgtbodygyrojerkstdy       
   $ avgtbodygyrojerkstdz       
   $ avgtbodyaccmagmean         
   $ avgtbodyaccmagstd          
   $ avgtgravityaccmagmean      
   $ avgtgravityaccmagstd       
   $ avgtbodyaccjerkmagmean     
   $ avgtbodyaccjerkmagstd      
   $ avgtbodygyromagmean        
   $ avgtbodygyromagstd         
   $ avgtbodygyrojerkmagmean    
   $ avgtbodygyrojerkmagstd     
   $ avgfbodyaccmeanx           
   $ avgfbodyaccmeany           
   $ avgfbodyaccmeanz           
   $ avgfbodyaccstdx            
   $ avgfbodyaccstdy            
   $ avgfbodyaccstdz            
   $ avgfbodyaccjerkmeanx       
   $ avgfbodyaccjerkmeany       
   $ avgfbodyaccjerkmeanz       
   $ avgfbodyaccjerkstdx        
   $ avgfbodyaccjerkstdy        
   $ avgfbodyaccjerkstdz        
   $ avgfbodygyromeanx          
   $ avgfbodygyromeany          
   $ avgfbodygyromeanz          
   $ avgfbodygyrostdx           
   $ avgfbodygyrostdy           
   $ avgfbodygyrostdz           
   $ avgfbodyaccmagmean         
   $ avgfbodyaccmagstd          
   $ avgfbodybodyaccjerkmagmean 
   $ avgfbodybodyaccjerkmagstd  
   $ avgfbodybodygyromagmean    
   $ avgfbodybodygyromagstd     
   $ avgfbodybodygyrojerkmagmean
   $ avgfbodybodygyrojerkmagstd 
