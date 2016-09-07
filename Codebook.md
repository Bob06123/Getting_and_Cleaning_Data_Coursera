# Codebook.md accompanying the run-anaysis.R script

The full description of the source data from UCI can be found on http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The run_analysis.R script takes the data from UCI (Human activity recognation data gathered through Smartphones) and converts it to a file that is structured clean and writes that to the disk with the name Second_tidy_UCI.txt.
Following steps are performed to get from the raw data to this tidy file:
* Downloading and unzipping dataset in a directory called "dataUCI", reading in files
* Assigning column names that are stored in the text files
* Merging the sets (train and test) to have one data set
* Getting the mean and standard deviation for each measurement and set activity names
* Create Output dataset aand file with the average of each variable for each activity and each subject
