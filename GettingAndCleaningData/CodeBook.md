Code Book = Feature Selection (UPDATED)
=========================================================================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

UNTIDY DATASET    |	TIDY DATASET
------------------|-------------------------------
tBodyAcc-XYZ      |timeBodyAccel.Mean.XYZ
			|timeBodyAccel.Mean.Stdev.XYZ
                  |
tGravityAcc-XYZ	|timeGravityAccel.Mean.XYZ
			|timeGravityAccel.Stdev.X
                  |
tBodyAccJerk-XYZ	|timeBodyAccelJerk.Mean.XYZ
			|timeBodyAccelJerk.Stdev.XYZ
                  |
tBodyGyro-XYZ	|timeBodyGyro.Mean.XYZ
			|timeBodyGyro.Stdev.XYZ
                  |
tBodyGyroJerk-XYZ	|timeBodyGyroJerk.Mean.XYZ
			|timeBodyGyroJerk.Stdev.XYZ
                  |
tBodyAccMag		|timeBodyAccelMag.Mean
			|timeBodyAccelMag.Stdev
                  |
tGravityAccMag	|timeGravityAccelMag.Mean
			|timeGravityAccelMag.Stdev
                  |
tBodyAccJerkMag	|timeBodyAccelJerkMag.Mean
			|timeBodyAccelJerkMag.Stdev
                  |
tBodyGyroMag	|timeBodyGyroMag.Mean
			|timeBodyGyroMag.Stdev
                  |
tBodyGyroJerkMag	|timeBodyGyroJerkMag.Mean
			|timeBodyGyroJerkMag.Stdev	
                  |
fBodyAcc-XYZ	|frequBodyAccel.Mean.XYZ
			|frequBodyAccel.Stdev.XYZ
                  |
fBodyAccJerk-XYZ	|frequBodyAccelJerk.Mean.Z
			|frequBodyAccelJerk.Stdev.X
                  |
fBodyGyro-XYZ	|frequBodyGyro.Mean.XYZ
			|frequBodyGyro.Stdev.XYZ
                  |
fBodyAccMag		|frequBodyAccelMag.Mean
			|frequBodyAccelMag.Stdev
                  |
fBodyAccJerkMag	|frequBodyBodyAccelJerkMag.Mean
			|frequBodyBodyAccelJerkMag.Stdev
                  |
fBodyGyroMag	|frequBodyBodyGyroMag.Mean
			|frequBodyBodyGyroMag.Stdev
                  |
fBodyGyroJerkMag	|frequBodyBodyGyroJerkMag.Mean
			|frequBodyBodyGyroJerkMag.Stdev

A diverse set of variables were estimated from these signals, but only the Mean and the Standard deviation (Stdev) have been retained during the clean-up of the original data