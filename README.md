Readme
======

This is the course project in the coursera course "Getting and Cleaning Data".

The given file presented data collected from the accelerometers from the Samsung Galaxy S smartphone. The goal of this project was to prepare tidy data of the averages of the means and standard deviations of several measurements that can be used for later analysis.

### Preprocessing

Unzip the file in your working directory into a directory "getdata-project". Load the package "reshape2" in R.

### Merging the data

The files X_train.txt, subject_train.txt and y_train.txt can be combined column-wise. Same goes for the files X_test.txt, subject_test.txt and y_test.txt. The data of the test and the training datasets can be combined row-wise.
 
### Variable names

You can find the variable names in the file features.txt. After assigning the variable names they get cleaned up by omitting parentheses and hyphens. And contrary to Prof.Leek I'm a fan of camel casing for better readability.

### Picking the variables of interest

For the purpose of this analysis the means and standard variations are interesting. Note that I omitted the mean frequencies and angles of means.

### Finalizing the project

After replacing the activity labels with the activity we take the average of the means and the standard deviatons by subject and activity and write the resulting table to a txt-file.

