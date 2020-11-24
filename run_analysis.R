library(data.table)

# Read the features data and clean the data before applying the values as column names

features = read.table('./UCI HAR Dataset/features.txt')
features[, 2] = gsub("^f", "frequency", features[, 2])
features[, 2] <- gsub("^t", "time", features[, 2])
features[, 2] <- gsub("BodyBody", "Body", features[, 2])
features[, 2] <- gsub("mean", "Mean", features[, 2])
features[, 2] <- gsub("std", "Std", features[, 2])
features[, 2] <- gsub("[\\(\\),-]", "", features[, 2])

# Read the activities labels data

activity = data.table(read.table('./UCI HAR Dataset/activity_labels.txt'))[, .(actn = V1, activity = V2)]

# Read the train data and change the column names appropriately

trainsubjects = data.table(read.table('./UCI HAR Dataset/train/subject_train.txt'))[, .(subject = V1)]
trainvalues = data.table(read.table('./UCI HAR Dataset/train/X_train.txt'))
setnames(trainvalues, colnames(trainvalues), features[, 2])
trainact = data.table(read.table('./UCI HAR Dataset/train/Y_train.txt'))[, .(actn = V1)]
trainact = activity[trainact, on = .(actn)]
train = cbind(trainsubjects, trainvalues, trainact)


# Read the test data and change the column names appropriately

testsubjects = data.table(read.table('./UCI HAR Dataset/test/subject_test.txt'))[, .(subject = V1)]
testvalues = data.table(read.table('./UCI HAR Dataset/test/X_test.txt'))
setnames(testvalues, colnames(testvalues), features[, 2])
testact = data.table(read.table('./UCI HAR Dataset/test/Y_test.txt'))[, .(actn = V1)]
testact = activity[testact, on = .(actn)]
test = cbind(testsubjects, testvalues, testact)

# combine train and test data

all = rbind(train, test)

keepcols = colnames(all)[grepl('subject|actn|activity|Mean|StandardDevi', colnames(all))]
meancols = colnames(all)[grepl('Mean|StandardDevi', colnames(all))]
all = all[, ..keepcols]

means = all[, lapply(.SD, mean), .SDcols = meancols, keyby = .(subject, actn, activity)][, actn := NULL]

write.table(means, "./tidy_data.txt", row.names = FALSE, quote = FALSE)
