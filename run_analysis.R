#setwd("~/Documents/R/Geting-Cleaning_Data/CourseProject")
#Load the libraries
library(plyr)
library(dplyr)

#To download the file from the given url, to your working directory
if(!file.exists("data")){dir.create("data")}
list.files(".")
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
",temp)
unzip(temp, files = NULL, list = FALSE, overwrite = TRUE,junkpaths = FALSE, exdir = ".", 
      unzip = "internal",setTimes = FALSE)
unlink(temp)

#The data is divided into "test" and "train" sets, they will be managed separately to form data frames, 
#but will have the same columns/names.

####################################################################
####!!!!!!!!!!!!!!!TEST-PART!!!!!!!!!!!!!!!!!!!!!###################
####################################################################
#Reading the test data from the folder
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")

#check the diemnstions & number of records if needed - dim(); in this case number of records is 2947

#Creating the data frame for test records, indicate the origin of the records : "testing"
dat_test<-data.frame(Id=1:2947,Source="testing")

#Introducing names for features
features_names<-read.table("./UCI HAR Dataset/features.txt")
#test for arrtributes & dim of this object - data frame; column V2 is the column with names
#assign those names to names of the columns in X_test
colnames(X_test)<-features_names$V2
X_test$Id <-c(1:2947)

#Adding data to the existing dat_test
dat_test[,"subject"]<-subject_test
dat_test[,"activity"]<-y_test
data_test<-merge(dat_test,X_test,by.x="Id",by.y="Id")

#Load raw data into R from test/Inertial Signals
body_acc_x_test<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
body_acc_y_test<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
body_acc_z_test<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
body_gyro_x_test<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_y_test<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_z_test<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
total_acc_x_test<-read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
total_acc_y_test<-read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
total_acc_z_test<-read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")


##introduce proper names for columns in Inertial Signals data frames - before merging them into the data_test
##Creating a vector of names of (9*)128 readouts in test/Inertial Signals dataframes
rawnames<-rep(1:1152)
for(i in rawnames){
    if(i<129){rawnames[i]<-paste("body_acc_x",i,sep="_")}
    if(128<i & i<2*128+1){rawnames[i]<-paste("body_acc_y",i-128,sep="_")}
    if(2*128<i & i<3*128+1){rawnames[i]<-paste("body_acc_z",i-2*128,sep="_")}
    if(3*128<i & i<4*128+1){rawnames[i]<-paste("body_gyro_x",i-3*128,sep="_")}
    if(4*128<i & i<5*128+1){rawnames[i]<-paste("body_gyro_y",i-4*128,sep="_")}
    if(5*128<i & i<6*128+1){rawnames[i]<-paste("body_gyro_z",i-5*128,sep="_")}
    if(6*128<i & i<7*128+1){rawnames[i]<-paste("total_acc_x",i-6*128,sep="_")}
    if(7*128<i & i<8*128+1){rawnames[i]<-paste("total_acc_y",i-7*128,sep="_")}   
    if(8*128<i & i<9*128+1){rawnames[i]<-paste("total_acc_z",i-8*128,sep="_")}    
    }
#Renaming the columns in test/Inertial Signals dataframes, to have unique column names
colnames(body_acc_x_test)<-rawnames[1:128]
colnames(body_acc_y_test)<-rawnames[(128+1):(2*128)]
colnames(body_acc_z_test)<-rawnames[(2*128+1):(3*128)]
colnames(body_gyro_x_test)<-rawnames[(3*128+1):(4*128)]
colnames(body_gyro_y_test)<-rawnames[(4*128+1):(5*128)]
colnames(body_gyro_z_test)<-rawnames[(5*128+1):(6*128)]
colnames(total_acc_x_test)<-rawnames[(6*128+1):(7*128)]
colnames(total_acc_y_test)<-rawnames[(7*128+1):(8*128)]
colnames(total_acc_z_test)<-rawnames[(8*128+1):(9*128)]

##Adding the Id variable to all Test/Inertial Signals dataframes, before merging
body_acc_x_test$Id<-c(1:2947)
body_acc_y_test$Id<-c(1:2947)
body_acc_z_test$Id<-c(1:2947)
body_gyro_x_test$Id<-c(1:2947)
body_gyro_y_test$Id<-c(1:2947)
body_gyro_z_test$Id<-c(1:2947)
total_acc_z_test$Id<-c(1:2947)
total_acc_x_test$Id<-c(1:2947)
total_acc_y_test$Id<-c(1:2947)

##MERGING with other Test data, by Id
data_test<-merge(data_test,body_acc_x_test,by.x="Id",by.y="Id")
data_test<-merge(data_test,body_acc_y_test,by.x="Id",by.y="Id")
data_test<-merge(data_test,body_acc_z_test,by.x="Id",by.y="Id")
data_test<-merge(data_test,body_gyro_x_test,by.x="Id",by.y="Id")
data_test<-merge(data_test,body_gyro_y_test,by.x="Id",by.y="Id")
data_test<-merge(data_test,body_gyro_z_test,by.x="Id",by.y="Id")
data_test<-merge(data_test,total_acc_x_test,by.x="Id",by.y="Id")
data_test<-merge(data_test,total_acc_y_test,by.x="Id",by.y="Id")
data_test<-merge(data_test,total_acc_z_test,by.x="Id",by.y="Id")


####################################################################
####!!!!!!!!!!!!!!!TRAIN-PART!!!!!!!!!!!!!!!!!!!!!##################
####################################################################

#Reading the train data from the folder
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")

#you can double-check number of records by dim(), in this case it is 7352.

#Creating the data frame for train
dat_train<-data.frame(Id=1:7352,Source="training")

#Adding proper feature names to feature dataframe 
colnames(X_train)<-features_names$V2
X_train$Id <-c(1:7352)

#combining Id, Source, subject, activity and features for train data
dat_train[,"subject"]<-subject_train
dat_train[,"activity"]<-y_train
data_train<-merge(dat_train,X_train,by.x="Id",by.y="Id")

#Load raw data into R from train/Inertial Signals
body_acc_x_train<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
body_acc_y_train<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
body_acc_z_train<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")
body_gyro_x_train<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_y_train<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_z_train<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")
total_acc_x_train<-read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
total_acc_y_train<-read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
total_acc_z_train<-read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")

##introduce proper names for columns in those data frames - before merging them into the data_train
##Creating a vector of names of (9*)128 readouts in train/Inertial Signals dataframes

#Renaming the columns in test/Inertial Signals dataframes, to have unique colnames
colnames(body_acc_x_train)<-rawnames[1:128]
colnames(body_acc_y_train)<-rawnames[(128+1):(2*128)]
colnames(body_acc_z_train)<-rawnames[(2*128+1):(3*128)]
colnames(body_gyro_x_train)<-rawnames[(3*128+1):(4*128)]
colnames(body_gyro_y_train)<-rawnames[(4*128+1):(5*128)]
colnames(body_gyro_z_train)<-rawnames[(5*128+1):(6*128)]
colnames(total_acc_x_train)<-rawnames[(6*128+1):(7*128)]
colnames(total_acc_y_train)<-rawnames[(7*128+1):(8*128)]
colnames(total_acc_z_train)<-rawnames[(8*128+1):(9*128)]

##Adding the Id variable to all Test/Inertial Signals dataframes, before merging
body_acc_x_train$Id<-c(1:7352)
body_acc_y_train$Id<-c(1:7352)
body_acc_z_train$Id<-c(1:7352)
body_gyro_x_train$Id<-c(1:7352)
body_gyro_y_train$Id<-c(1:7352)
body_gyro_z_train$Id<-c(1:7352)
total_acc_z_train$Id<-c(1:7352)
total_acc_x_train$Id<-c(1:7352)
total_acc_y_train$Id<-c(1:7352)

##MERGING with other train data, by Id
data_train<-merge(data_train,body_acc_x_train,by.x="Id",by.y="Id")
data_train<-merge(data_train,body_acc_y_train,by.x="Id",by.y="Id")
data_train<-merge(data_train,body_acc_z_train,by.x="Id",by.y="Id")
data_train<-merge(data_train,body_gyro_x_train,by.x="Id",by.y="Id")
data_train<-merge(data_train,body_gyro_y_train,by.x="Id",by.y="Id")
data_train<-merge(data_train,body_gyro_z_train,by.x="Id",by.y="Id")
data_train<-merge(data_train,total_acc_x_train,by.x="Id",by.y="Id")
data_train<-merge(data_train,total_acc_y_train,by.x="Id",by.y="Id")
data_train<-merge(data_train,total_acc_z_train,by.x="Id",by.y="Id")


##################################################################
#COMBINING TWO TESTING WITH TRAINING 
##################################################################

#This is the data frame with full data in it. 
run_data<-rbind(data_test,data_train)

#Selecting only mean and std from features' names
#for (i in 1:length(values))
#vector <- c(vector, values[i])

##################################################################
#Selecting only means and standard deviations
##################################################################

#Selecting the variable names to choose
vec_names<-as.character(features_names$V2)
#selected<-as.character(vector())
sel<-vector()
for (i in 1:length(vec_names)){
    if(grepl("mean",vec_names[i])==TRUE | 
       grepl("Mean",vec_names[i])==TRUE | 
       grepl("std",vec_names[i])==TRUE | 
       grepl("Std",vec_names[i])==TRUE  ){#vector sel points the position of mean & std variables in the colnames of run_data
       sel<-c(sel,i+4)}
}
sel_col<-c(c(1,2,3,4),sel)
run_data_selected<-select(run_data,sel_col)

#Changing the activity into proper names
#1 WALKING
#2 WALKING_UPSTAIRS
#3 WALKING_DOWNSTAIRS
#4 SITTING
#5 STANDING
#6 LAYING

#Renaming the activities from integers 1:6, to proper names.
run_data_selected$activity<-as.character(run_data_selected$activity)

run_data_selected$activity[run_data_selected$activity=="1"]<-"Walking"
run_data_selected$activity[run_data_selected$activity=="2"]<-"Walking_upstairs"
run_data_selected$activity[run_data_selected$activity=="3"]<-"Walking_downstairs"
run_data_selected$activity[run_data_selected$activity=="4"]<-"Sitting"
run_data_selected$activity[run_data_selected$activity=="5"]<-"Standing"
run_data_selected$activity[run_data_selected$activity=="6"]<-"Laying"

#Grouping the data frame by subject and activity, into a new data frame 
run_data_grouped<-group_by(run_data_selected,subject,activity)

#Summarizing the grouped dataframe - obtaining avarage of all variables for each subject and each activity
run_data_summ<-summarise_each(run_data_grouped,mean,-(Id:activity))

#writing the data into txt file
write.table(run_data_summ,"run_data_summary.txt",sep="\t",row.name=FALSE)

