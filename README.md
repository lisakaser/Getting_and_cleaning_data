## How to use the files in this folder to get the tidy data required for the assignement

### What is needed before running the code (run_analysis.R):

* Data needs to be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Downloaded file needs to be unzipped
* Unzipped data needs to be in Your working directoy in R or the working directory needs to be set to the data folder using setwd("your_data_directory_here")
* The R packages plyr and dplyr need to be downloaded

### Good to know about running and understanding the code:

* The item numbers below line up item numbers in the code 

### What the code does
* 0. prepare the R workspace and R environment
	+ workspace gets cleaned
	+ library plyr and dplyr get loaded (warning: dont change the order of the loading of these libraries, else code will not work)
* 1. Loades and merges data sets (X_tain.txt and X_test.txt) using features.txt as (preliminary) column names. Merged data set is saved in variable "all_data"
* 2. Only mean() and standard deviation (std()) of each measurement are selected and saved in variable "mean_and_std_data"
* 3. Training and test labels are loaded from the y_train.txt and y_test.txt files and translated into an descriptive activity name using the translation in the activity.labels.txt
* 4. preliminary columnlabels from 1. are translated into descriptive variable names.
	+ Note: "BodyBody" was renamed as "Body" as I interpreted it as an error. Reason: Nowhere was a single "Body" so the doubeling "BodyBody" didnt seem necessary
* 5. From the "mean_and_std_data" data set that has now descriptive variables a new indipendent data set averaging each variable for activity and subject is created using the 'aggregate()' function and this new data called "new_Data" is saved into a .txt file.
