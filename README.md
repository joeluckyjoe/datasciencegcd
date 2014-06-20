datasciencegcd
==============

This repo will contain the script and readme that correspond to the project int he "Getting and Cleaning Data" class

* 1 Download the run_analysis.R script

* 2 Before you run the srcipt you may need to install plyr and reshape2 packages
  
   Following is the output for the sessionInfo() command that shows the verion of R I used and also the packages
   that were loaded for the script:
   
   > sessionInfo()

      R version 3.0.3 (2014-03-06)
      Platform: x86_64-w64-mingw32/x64 (64-bit)

      locale:
      [1] LC_COLLATE=French_Belgium.1252  LC_CTYPE=French_Belgium.1252    LC_MONETARY=French_Belgium.1252
      [4] LC_NUMERIC=C                    LC_TIME=French_Belgium.1252    

      attached base packages:
      [1] stats     graphics  grDevices utils     datasets  methods   base     

      other attached packages:
      [1] plyr_1.8.1   reshape2_1.4

      loaded via a namespace (and not attached):
      [1] Rcpp_0.11.1   stringr_0.6.2 tools_3.0.3 

* 3 Open and run the script in Rstudio or use the source() R command from the console to run the run_analysis.R script.
   
   There is no parameter needed to run this script. 
   
   Please use ?source to get help on the source() command.
  
* 4 The script will create a directory named gcddata  inside your working directory.
   
   It will download a file in zip format named Dataset.zip into the gcddata directory from 
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .
   
   It will process raw data that can be found inside the Dataset.zip file and generate a tidy dataset in two formats:
   
    a data frame named tidydata and a file named tidydata.txt in the gcddata directory.
    
* 5 If you wish, you can use the read.table() command to create another dataframe from the tidydata.txt file.
   
   This can be usefull to determine that we have a tidy dataset.
   
   Use "header = TRUE" in order to get meaningful column names for the data frame.
   
* 6 CodeBook.md file on this repo will contain information that will describe the variables that are in the tidy dataset.
   It also gives information about the raw data and how the script processes this data to get the tidy data.
