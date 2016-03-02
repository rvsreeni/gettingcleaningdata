### Datasets read by run_analysis R script

features.txt - List of variables present in Training, Test datasets (X_train, X_test) 
activity_labels.txt - Labels corresponding to Activity code
X_train.txt - Observatons in Training dataset
y_train.txt - Activity index to observatons in Training dataset
subject_train.txt - Subject index to observatons in Training dataset
X_test.txt - Observatons in Test dataset
y_test.txt - Activity index to observatons in Test dataset
subject_test.txt - Subject index to observatons in Test dataset


### Dataframes used in run_analysis R script

df_train - dataframe containing mean and standard deviation for Training measurements, along with subject and activity
df_test - dataframe containing mean and standard deviation for Test measurements, along with subject and activity
df_comb_train_test - dataframe comtaining merged (rowwise) Training aand Test data
oas_aggdata - dataframe containing Mean aggregate data on the key(subject, activity
df_result - dataframe containing final results 



	