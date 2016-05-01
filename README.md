# GettingAndCleaningData
Course Assignment for Getting and Cleaning Data Coursera

There is one R script in this repo -> run_analysis.r

This script analyses data from the following site:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

It takes data from the following zip file:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This script merges the datasets and combines the training and test data into one dataset.

It only keeps mean and standard deviation variables provided.

It then groups the data by individual subject and activity type and provides mean values for each variable.

Further information on the output can be found in the CodeBook markdown file.
