# Load required library
library(dplyr)

# 1. Load Data

# Read feature names and activity labels
features <- read.table("UCI HAR Dataset/features.txt", 
                       col.names = c("featureId", "featureName"))

activities <- read.table("UCI HAR Dataset/activity_labels.txt", 
                         col.names = c("activityId", "activityLabel"))

# Read training data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", 
                      col.names = "activityId")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "subjectId")

# Read test data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", 
                     col.names = "activityId")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                           col.names = "subjectId")

# Assign feature names to datasets
colnames(x_train) <- features$featureName
colnames(x_test) <- features$featureName

# 2. Merge Training and Test Sets 

train_data <- cbind(subject_train, y_train, x_train)
test_data  <- cbind(subject_test, y_test, x_test)

merged_data <- rbind(train_data, test_data)

# 3. Extract Mean and Standard Deviation Measurements 

mean_std_data <- merged_data %>%
  select(subjectId, activityId, contains("mean()"), contains("std()"))

# 4. Use Descriptive Activity Names

mean_std_data <- mean_std_data %>%
  left_join(activities, by = "activityId")

# Reorder columns
mean_std_data <- mean_std_data %>%
  select(subjectId, activityLabel, everything(), -activityId)

# 5. Label Data Set with Descriptive Variable Names 

colnames(mean_std_data) <- colnames(mean_std_data) %>%
  gsub("^t", "Time", .) %>%
  gsub("^f", "Frequency", .) %>%
  gsub("Acc", "Accelerometer", .) %>%
  gsub("Gyro", "Gyroscope", .) %>%
  gsub("Mag", "Magnitude", .) %>%
  gsub("BodyBody", "Body", .)

# 6. Create Second Tidy Data Set

tidy_data <- mean_std_data %>%
  group_by(subjectId, activityLabel) %>%
  summarise(across(where(is.numeric), mean), .groups = "drop")

# Write output file
write.table(tidy_data, "TidyData.txt", row.name = FALSE)

