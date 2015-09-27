==============================================================================
CODEBOOK
==============================================================================

Here are the operations applied to the data set from Samsung

## 1. Putting together the features names, activity names and subject identifiers 
(number) with the actual variable values for each of the 2 main data sets: the 
training set and the test set.
** This part combines tasks 1, 3 and 4 of the assignment **

To do so, 
* features and activities are read from "features.txt" and "activity_labels.txt"
respectively.
* for each data set, the activity label and the variable values are read from 
"X_...txt" and "y_...txt" respectively using the function read.table(). We give 
as input the specific number of rows, the column names (from "features", and as 
"Activity" respectively)and precise there are no prior headers. 
* the "y_..." data is merged (merge()) with the label names to retrieve these 
names
* we the combine all the data from the resulting 3 tables using the function 
cbind(), into 2 tables 'train' and 'test'.

## 2. Extract only the measurements on the mean and standard deviation for each 
measurement. 
** This corresponds to task 2 of the assignment **

We use here the feature names which are already the column names and find those 
that include "mean()" or "std()" into the name. 
This is done thanks to the grep() function and the pattern recognition "mean()" 
and "std()"
Note, we excluse the variables including "meanFred()" by excluding the patterns
[^(Freq)].
These identified columns and the ones 'Subject' and 'ActivityName' are used to 
create a subset of the data set 'selected'.

## 3. tidy data set with the average of each variable for each activity and each 
subject, and write into .txt file
We use here the package reshape2 to leverage the functions melt() and dcast() 
to format the data in a clean way as requested.

==============================================================================
To read the output file "tidydata.txt", you can use the following script:

> output <- read.csv("tidydata.txt")
==============================================================================

