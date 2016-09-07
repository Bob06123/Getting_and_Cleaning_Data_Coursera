# Codebook.md accompanying the run-anaysis.R script

The full description of the source data from UCI can be found on http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The run_analysis.R script takes the data from UCI (Human activity recognation data gathered through Smartphones) and converts it to a file that is structured clean and writes that to the disk with the name Second_tidy_UCI.txt.
Following steps are performed to get from the raw data to this tidy file:
* Downloading and unzipping dataset in a directory called "dataUCI", reading in files.
  * Variables in this step are fileurl (containing the full adress and name of the zip file) __x_train,  y_train, subject_train, x_test, y_test, subject_test, features and activitylables__. The names of the variables correspond with the files that are read in and need no further description.  
* Assigning column names that are stored in the text files
* Merging the sets (train and test) to have one data set
  * The sets are merged in two steps: first the train data stored in the variable __mergeTrain__, than the test data stored in the variable __mergeTest__, in both cases using column bind. These two are combined in __AllTogether__ using row bind.  
* Getting the mean and standard deviation for each measurement and set activity names
  * Mean and Standard deviation columns types are stored __meanAndStandarddev__, and __AllTogether__ dataset is filtered based on this variable (mean and std are TRUE). Resultset is stored in __meanAndStandarddev_list__. This dataset is enriched with the Activity and stored in __baseWithNames__
* Create Output dataset aand file with the average of each variable for each activity and each subject
  * the in the previous step generated set __baseWithNames__ is finally aggregated and stored in __tidiedDataset__ to have a base for writing the outputfile.  

