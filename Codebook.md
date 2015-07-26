## Explanation of variables in the file newData.txt
 newData.txt was created by the run_analysis.R function

### Variable names:

* activity (has 6 different options: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS. Each measurement was averaged for each subject and each activity. So each subject has 6 average values per measurement as each subject was tested for each activity)
* subject (is a number between 1 and 30 associated with a specific person each. The tidy new data is sorted by ascending subject number)
* all the other colums are measurements averaged for each subject and activity with units of dbl (Even though I did not find the translation of that in any of the given files, I assume that it stands for decibel)

	+ Generally all the measurement values can be divided into 'time domain' or 'frequency domain' variables. This is the beginnig of each variable name.

	+ For all the variables exists a mean and standard deviation measure

	+ Most of the variables have a measure in x, y and z direction
## The following renaming was done to get from "features.txt" to more descriptive variable names:

* 'BodyBody' was renamed to 'Body' because it seemed a mistake and not necessary
* the 't' in the beginning of the names was translated to 'time domain'
* the 'f' in the beginning of the names was translated to 'frequency domain'
* 'Acc' to 'accelerometer'
* 'Gyro' to 'gyroscope'
* 'Mag' to 'magnitude'
* '-X', '-Y', '-Z' to 'x direction','y direction' and 'z direction' respectively

More details about the original measurement names can be found in features_info.txt.

