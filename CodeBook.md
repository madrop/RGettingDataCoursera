#File TidyDataSet.txt
consist of a subset of variables used in study study Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.
Details about these data can be found in original study, see files README_originalStudy.txt.

##Variables
File consist of these variables:
* 66 variables of 561 original variables. Only means and standard deviations of selected variables which were calculated on 50 Hz fixed-width sliding windows of 2.56 sec samples. Data were sampled from accelerometer and gyroscope of a smartphone, based on movements of subjects. These variables are normalized and bounded within [-1,1].
* Subject is a number, which identifies one of 30 persons who carried activity described in variable Activity, to which are data from accelerometer and gyroscope (see 66 variables above) related
*Activity is a factor, which describes type of movement, which was carried out by Subject.

##Data transformation
Data should have same values as used in study. They were only merged from six files into one dataset. 3 files were related to test set and 3 files were related to train set. For each set, the data from 3 files were merged based on an row index in a file. The files have same number of rows.

##Variable transformation
Only variable Activity differs from original value. It was modified according these rules:
*1 => WALKING
*2 => WALKING_UPSTAIRS
*3 => WALKING_DOWNSTAIRS
*4 => SITTING
*5 => STANDING
*6 => LAYING

#File TidyDataSet2_groupMeans.txt
consist of means calculated for each Subject, its Activity and each of 66 variables in file TidyDataset.txt.

##Variables
*Subject - identifies person, who carried out activity
*Activity - names type of activity, which was carried out by subject on several occasions.
*variable - identifies one of 66 variables, which were calculated or sampled from accelerometer and gyroscope during time windows
*groupMean - calculated Mean for each Subject-Activity-Variable combination in TidyDataset.txt