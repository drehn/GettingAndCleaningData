setwd("/Users/dom/Coursera/datasciencecoursera")
library(data.table)
library(dplyr)

# Read in training and test data 
xtrain <- as.data.table(read.table("UCI HAR Dataset/train/X_train.txt"))
ytrain <- as.data.table(read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity_code"))
subjecttrain <- as.data.table(read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject"))
xtest <- as.data.table(read.table("UCI HAR Dataset/test/X_test.txt"))
ytest <- as.data.table(read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity_code"))
subjecttest <- as.data.table(read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject"))

# Read in variable descriptive names and apply to X datasets
vars <- read.table("UCI HAR Dataset/features.txt")
namevar <- as.vector(vars$V2)
names(xtrain) <- namevar
names(xtest) <- namevar

# Find and select only columns with mean or std in the column label
cols = grep("mean|std|Mean|Std|MEAN|STD", names(xtest))
xtrain = select(xtrain, cols)
xtest = select(xtest, cols)

# Merge all three training and test datasets
train <- cbind(subjecttrain,ytrain,xtrain)
test <- cbind(subjecttest,ytest,xtest)

# Append the test and training datasets into one full dataset
full = rbind(train, test)

# Read in the descriptive activity dataset
labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_code", "activity"))

# Add the descriptive activity labels to the full dataset 
full <- merge( labels, full, by="activity_code")

# Summarise each column to get the mean grouped by each subject and activity 
full <- as.data.table(full)
result <- full[, lapply(.SD, mean), by=c("subject", "activity")]

# Write out the tidy grouped dataset
write.table(result,"./tidy_movement_data.txt", row.names = FALSE)
