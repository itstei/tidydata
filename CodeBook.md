## Original Dataset
Human Activity Recognition Using Smartphones Dataset

## Variables

- subjectId → ID of the subject (1–30)
- activityLabel → Type of activity performed:
    - WALKING
    - WALKING_UPSTAIRS
    - WALKING_DOWNSTAIRS
    - SITTING
    - STANDING
    - LAYING

## Measurements

Only measurements on mean() and std() were extracted.

Examples of cleaned variable names:

- TimeBodyAccelerometer-mean()-X
- TimeBodyAccelerometer-std()-Y
- FrequencyBodyGyroscope-mean()-Z

## Transformations Applied

1. Training and test datasets were merged.
2. Mean and standard deviation measurements were extracted.
3. Activity labels were merged to replace activity IDs.
4. Variable names were expanded to be descriptive.
5. A second tidy dataset was created with the average of each variable grouped by subject and activity.

## Final Dataset

The final tidy dataset contains:
- 180 rows (30 subjects × 6 activities)
- 68 variables
