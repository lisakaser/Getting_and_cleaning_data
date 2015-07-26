## clean workspace
rm(list=ls()) #remove all variables
dev.off() #close plot
setwd("/Users/kaser/Documents/coursera/DataScience/1_TheDataScientistsToolbox/GitHub/getting_and_cleaning_data_project/UCI HAR Dataset/")

library(plyr)
library(dplyr)


## 1. Merges the training and the test sets to create one data set. 
# Load training and test data set and merge them
features<-read.table("features.txt")
data_colnames<-as.character(features[,2],length=100)
training<-tbl_df(read.table("train/X_train.txt"))#,col.names=data_colnames)
test<-tbl_df(read.table("test/X_test.txt"))#,col.names=data_colnames))
all_data<-rbind(training,test)

## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# Find all the col.names that correspond to mean and std of measurements
mean_variable_index<-grep("mean\\(\\)",data_colnames)
std_variable_index<-grep("std\\(\\)",data_colnames)


# select only a subset of data of mean and std measurements
#colNums_mean <- match(mean_variable_names,names(all_data))
#colNums_std <- match(std_variable_names,names(all_data))
#mean_and_std_data<- select(all_data,colNums_mean,colNums_std)
mean_and_std_data<- select(all_data,c(mean_variable_index,std_variable_index))
mean_and_std_column_names<-data_colnames[c(mean_variable_index,std_variable_index)]
## 3. Uses descriptive activity names to name the activities in the data set
# Load the training and test labels and merge them
training_labels<-tbl_df(read.table("train/y_train.txt"))
test_labels<-tbl_df(read.table("test/y_test.txt"))
all_labels<-rbind(training_labels,test_labels)


# create a factor variable translating training_labels and test_labels numbers into charater using activity_labels.txt definitions
activity_labels<-read.table("activity_labels.txt")
activity_labels<-as.character(activity_labels[,2])

activity_factor<-as.character(all_labels[[1]])
for(i in 1:6){
        index<-as.character(i)
        activity_factor[which(activity_factor == index)]<-activity_labels[i]
}
#activity_factor<-as.factor(activity_factor)


# load subject information and transform into factor variable
subject_test<-tbl_df(read.table("test/subject_test.txt"))
subject_training<-tbl_df(read.table("train/subject_train.txt"))
all_subjects<-rbind(subject_training,subject_test)

all_subjects<-as.numeric(all_subjects[[1]])
# add activity factor and all_subjects to mean_and_std_data
mean_and_std_data<-mutate(mean_and_std_data,activity=activity_factor,subjects=all_subjects)

## 4. Appropriately labels the data set with descriptive variable names. 
#create descriptive variable names
new_labels<-mean_and_std_column_names
new_labels<-sub("BodyBody","Body",new_labels)
new_labels<-sub("tBody","time domain body ",new_labels)
new_labels<-sub("fBody","frequency domain body ",new_labels)
new_labels<-sub("tGravity","time domain gravity ",new_labels)
new_labels<-sub("fGravity","frequency domain gravity ",new_labels)
new_labels<-sub("Acc","accelerometer ",new_labels)
new_labels<-sub("Gyro","gyroscope ",new_labels)
new_labels<-sub("Jerk","jerk ",new_labels)
new_labels<-sub("Mag","magnitude ",new_labels)
new_labels<-sub("-mean()","mean",new_labels,fixed=TRUE)#fixed=TRUE is necessary because else () are not treated as regular string characters
new_labels<-sub("-std()","stdandard deviation",new_labels,fixed=TRUE)
new_labels<-sub("-X"," x direction",new_labels)
new_labels<-sub("-Y"," y direction",new_labels)
new_labels<-sub("-Z"," z direction",new_labels)

#rename the data columns
names(mean_and_std_data)<-c(new_labels,"activity","subjects")
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# rearrange the data frame

mean_and_std_data<-select(mean_and_std_data,activity,subjects,1:(dim(mean_and_std_data)[2]-2))

# use aggregate with the function mean (FUN=mean) to average each variable for each activity and each subject
new_Data<-aggregate(mean_and_std_data[3:dim(mean_and_std_data)[2]],by=list(mean_and_std_data$activity,mean_and_std_data$subjects),FUN=mean, na.rm=TRUE)
new_Data<-rename(new_Data,activity=Group.1,subject=Group.2)
new_Data<-arrange(new_Data,as.numeric(subject))

setwd("/Users/kaser/Documents/coursera/DataScience/1_TheDataScientistsToolbox/GitHub/getting_and_cleaning_data_project/UCI HAR Dataset/")

write.table(new_Data,"newData.txt", row.names = FALSE)
## to do:
# Write Code book and readme files
# why did I choose mean and not mean() maybe change that!
# give better names maybe watch that part of week 4
# wite in Readme what packages/libraries are needed and that the data needs to be downloaded and unpacked from the following webpage and that the setpath in the third line needs to be set accordingly if one once to run the R script
# removed BodyBody because it did not seem to be necessary
##units, mentione that none was found (all seem to be in dbl)