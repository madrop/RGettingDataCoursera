README.md

This script makes one *tidy dataset* from several files with train and test data, which were related to (version 1) data used in study Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

#Preparation
copy into your working directory
*run_analysis.R
*zip file with raw data
Extract all files into a tree folder structure. Rename the top folder to **data**

#Run script in R
`source("run_analysis.R")`
`run_analysis()`
Function `run_analysis()` calls 2 worker functions `createTidyDataSet()` and `calculateMeans()`. Each of them generates a separate file, see next section.

#Expected outcome
*file TidyDataSet.txt  -- contains merged train and test set. Each set consists data from three files: subjects.txt, X_xxx.txt and  Y_xxx.txt. Contains only 66 features from 561 in raw X_xxx.txt.
*file TidyDataSet2_groupMeans.txt -- contains "averages" computed on Subject, Activity, feature (in file TidyDataSet.txt). 