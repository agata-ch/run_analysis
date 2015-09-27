
The script works on the dowloaded data, places in a subfoder. 

SOURCE OF DATA

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

VARIABLES 

Subjects (1:30)

Activity (1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING)

Vector of features (1:561), from which only means and standard deviations are chosen (of original variables obtained from measurements); detailed description of features, their names and measurements can be found in the txt files dowloaded within the data package.

Additionally, when working with data, and importing the raw data (Inertial Signals) additional variables are included (from 128 readouts of measuring devices). 
Ultimately, however, the selected variables are the means and standard deviations, from the features' vector.

At the end, the script produces dataframe that gives means of previously selected variables, by subjects and activities. 

*Additionally, in the full-data and selected data dataframes (run_data, run_data_selected), one also has variables "Id" and "Source". "Source" lets one see the origin of the records (training or testing). 

GENERAL STEPS IN THE SCRIPT

1. The script works first with the "test" data, to form a (full-data) dataframe data_test. All variables are given unique names; raw data (Inertial Signals) also. Merging is done by the "Id" variable which will not appear in the final summary. "Source" variable is included (either "testing"" or "training""). 
//Appropriately labels the data set with descriptive variable names. 

2. Next, it performs analogous steps for "train" data, to form a (full-data) dataframe data_train.
//Appropriately labels the data set with descriptive variable names. (The test and train dataframes are created in such a way that the column names are the same; this lets you rbind them in the next step). 

3. Next, it merges data_test and data_train (to form run_data ) 
//Merges the training and the test sets to create one data set.

4. Selects only the feature variables that have means and stds: run_data_selected. 
//Extracts only the measurements on the mean and standard deviation for each measurement. 

4. Next, it substitutes integer values of activities (1:6) with corresponding character values.
//Uses descriptive activity names to name the activities in the data set

5. It groups the run_data_selected dataframe by subject and activity (to run_data_grouped).

6. It gives summary - means of selected feature variables according to groups (in run_data_summ).
//Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

7. Printing out the run_data_summ to a text file run_data_summary.txt 