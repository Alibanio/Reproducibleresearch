---
title: "README"
author: "Arthur Libanio"
date: "27 de dezembro de 2015"
output: html_document
---

This file describes how the transformation was performed in the data set.

##1. Reading the files
Assuming that the files are in the working directory, and the main structure of the directories within the main file was not changed, every file is read by the use of **read.table** function.  
The outputs are storage in the subsequent files:  
1.1. Xtest has the main values for the test data set  
1.2. Xtrain has the main values for the training data set  
1.3. Test has the activities for the test data set  
1.4. Ytrain has the activities for the train data set  
1.5. Features has the features for both train and test  
1.6. ActLabel has the activity name for both data sets   
1.7. SubjectTrain has the subjects id for the train data set
1.8. SubjectTest  has the subjects id for the test data set  

##2. Joining all informations into two datasets.  
Xtest and Ytest receive all the additional information placed on secondary files.  
Two new variables are created:  
2.1. Subject  
2.2. Activity  
These new variables receive the information contained in the SubjectTrain and SubjectTest, and the ActLabel tables.  

##3.Mergin the two datasets: Xtest and Xtrain  
Aiming to construct one data set, the two primary table are merged.  
It is checked to see if there is any variables repeated in the data set, and if it is, they are removed.  

##4.Naming the Activities  
Using the **sapply** a custom function is created to compare the activity id from the merged data frame with the active name in the ActLabel data frame, and the return value is the name of the activity. This functions goes through all the values and return one of the following: Laying, Sitting, Walking, Walking Downstairs, Walking Upstairs.  

##5. Renaming the variables.  
It was perceived that the variables has their names abbreviated. Using the **gsub** function, five patters were search and replaced for the subsequent character string. The substitutions were as follow:  
1- "f" at the begging of a variable name for "Frequency"  
2- "t" at the beginning of a variable name for "Time"  
3- "Mag" for "Magnitude"  
4- "Acc" for "Accelerator"  
5- "Gyro" for "Gyroscope"  

##6. Naming the subjects  
The subject variable were only numeric, i.e. 1,2,3,4,...  
A code is implemented to change it for "Participant" + "Number". It is performed in the same fashion as for the activity names. A custom function is given to the **sapply** command, with the paste function within. The paste function paste the name "Participant" with their number, separated by spaces.  

##7. The mean for every variable by subject and activity  
Using the functions with in the **dplyr** package, the merged data frame is grouped by their subject and activity variables. And the function **summarize_each** is applied given the function **mean** as argument. This command stream returns a data set with the mean for each variable by the grouping combination of subject and activity.  
This data set is the final result of the data manipulation and it is called Tidy Data.  

##8. Final considerations.  
At the final step the Tidy Data is transformed into a text file by the **write.table** function and the intermediary data frames are removed from the working space for memory saving purposes.
