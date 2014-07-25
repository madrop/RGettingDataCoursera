
#manages the whole process of
# a. making tidy dataset (merging train and test datasets)
# b. calculating means for subject, activity, variable (create 2nd dataset)

#ATTENTION <- you have to extract all raw files to folder "data"
run_analysis <- function( ) {
  
  tidyDataSet <- createTidyDataSet();
  
  calculateMeans(tidyDataSet)
  
  print("run_analysis() --- FINISHED")

}


#Merges the training and the test sets to create one data set.Extracts only the measurements 
#on the mean and standard deviation for each measurement.
createTidyDataSet <- function( ) {
  
  #1.Merges the training and the test sets to create one data set.---------------------------
  #2.Extracts only the measurements on the mean and standard deviation for each measurement.  
    #define, which columns to import
    features <- read.table("./data/features.txt", header = FALSE, sep = "", 
               na.strings = "NA", colClasses = c("integer","character"), nrows = 561,
               skip = 0, check.names = TRUE)  
    means_and_std_columns <- grepl("mean()",features[, 2], fixed = TRUE ) | grepl("std()",features[, 2], fixed = TRUE) 
    importedColumns <- rep("NULL", times=561)
    importedColumns[ means_and_std_columns ] <- "numeric"
  
  
    #create test set---------
      #read X values
      testSet <- read.table("./data/test/X_test.txt", header = FALSE, sep = "", quote = "\"'",
                            dec = ".", 
                            col.names = features[ , 2], 
                            colClasses = importedColumns, nrows = 3000,
                            check.names = TRUE)
      
      # add y-labels (activity codes) to test dataset
      testActivities <- read.table("./data/test/Y_test.txt")
      testSet$Activity <- testActivities[ ,1]
      
      #add subjects to test dataset
      testSubjects <- testActivities <- read.table("./data/test/subject_test.txt")
      testSet$Subject <- testSubjects[ ,1]
  
  
    #create train set------------------
      #read X values
      trainSet <- read.table("./data/train/X_train.txt", header = FALSE, sep = "", quote = "\"'",
                            dec = ".", 
                            col.names = features[ , 2], 
                            colClasses = importedColumns, nrows = 7500,
                            check.names = TRUE)
      
      # add y-labels (activity codes) to test dataset
      trainActivities <- read.table("./data/train/Y_train.txt")
      trainSet$Activity <- trainActivities[ ,1]
      
      #add subjects to test dataset
      trainSubjects <- testActivities <- read.table("./data/train/subject_train.txt")
      trainSet$Subject <- trainSubjects[ ,1]
     
      #add train and test set together
      fullSet <- rbind(trainSet, testSet)
  
    #remove unused objects
    rm( testSet, testActivities, testSubjects, trainSet, trainActivities, trainSubjects, importedColumns)
  
  #3.Uses descriptive activity names to name the activities in the data set---------------
  
    fullSet$Activity[ fullSet$Activity ==1] <- "WALKING"
    fullSet$Activity[ fullSet$Activity ==2] <- "WALKING_UPSTAIRS"
    fullSet$Activity[ fullSet$Activity ==3] <- "WALKING_DOWNSTAIRS"
    fullSet$Activity[ fullSet$Activity ==4] <- "SITTING"
    fullSet$Activity[ fullSet$Activity ==5] <- "STANDING"
    fullSet$Activity[ fullSet$Activity ==6] <- "LAYING"
  
  
  #4.Appropriately labels the data set with descriptive variable names.
  #DONE (during read.table --- reading from file)
  
  newNames <- sub("..","()",names(fullSet), fixed = TRUE)
  newNames <- gsub(".","-",newNames, fixed = TRUE)
  names(fullSet) <- newNames
  

  #Write tidy dataset
    write.table( fullSet, file = "TidyDataSet.txt")
  
  return (fullSet)

}


#5.Creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject. 
calculateMeans <- function( dataSet ) {
  
  dataSet$Subject <- factor(dataSet$Subject)
  dataSet$Activity <- factor(dataSet$Activity)
  
  library(reshape2)
  meltedSet <- melt( dataSet,id=c("Subject","Activity"),measure.vars= names(dataSet)[1:66]   )
  
  
  library(plyr)
  groupMeans<- ddply( meltedSet, .(Subject, Activity, variable),summarize, groupMean=mean(value) )
  
  #write result to file
  write.table ( groupMeans, file = "TidyDataSet2_groupMeans.txt" , na="")
}


