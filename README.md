# Getting and Cleaning Data - Course Project
## About the Script
The `run_analysis.R` performs the following procedures:
1. Verifies existence of the Data folder. If such folder does not exist, R will download it. The URL of the data is the following link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2. The data files (X,Y files of the train and test data sets) are loaded as CSV files. 

3. Data frames are merged by using `rbind`and `cbind` combining **Subject, Activity and Measurements** observations.

4. Columns' names are given by extracting them from **features.txt** file, which is included in the data set.

5. Columns that contain *mean* or *std* are found by using `grepl`.

6. IDs and names of activities are read from the **activity_labels.txt** file. The factor function is used to convert the activity IDs into descriptive names.

7. Using `ddply` a second data set is created. This data set includes the average of each variable given each activity and subject. 

8. Finally, `write.csv` is used to create the tidy data set in the same folder as `run_analysis.R` script.
