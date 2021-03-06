This repository includes the following files:
=========================================
'READme.txt'

'run_analysis.R' 

'CodeBook.md'

=========================================

The file 'run_analysis.R' is an R script that will take a source data set and 
produce a tidy data text file with table containing average values for each 
subject and activity combination of measurements taken using a Samsung 
smartphone (accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and 
tGyro-XYZ). 

Additional information about the original data used in this analysis can be 
found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The script uses the '-mean()' and '-std()' variables from the test and training 
data from the above source. These are the mean and standard deviations of the 
33 main variables in original data. [For a discussion of the various mean and 
std variables, see 
https://class.coursera.org/getdata-031/forum/thread?thread_id=160.]

Each line of the table generated by this script represents the average 
measurements from one activity as completed by one subject. The value for each 
variable is a mean of all measurements taken for that activity/variable 
combination, when multiple measurements of that activity were available in the 
original data.

The 'CodeBook.md' file contains additional details regarding variables.

Prior to running this script:
=========================================
Download data from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Prior to running the script, both the unzipped UCI HAR Dataset folder (as 
downloaded from the URL above) and the 'run_analysis.R' script file should be 
saved together in the user's working directory. 

This analysis uses the R package 'dplyr', which should be installed prior to 
sourcing the script file within R.

This script was developed using R version 3.1.2 (2014-10-31).




