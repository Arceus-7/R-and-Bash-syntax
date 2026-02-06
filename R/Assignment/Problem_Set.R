# Problem sets in R
# 1. Draw a sample of size 3 from a N(0,1) distribution. Use them as the co-efficients
# a,b and c respectively of the quadratic equation ax^2+bx+c=0.
# Determine whether the roots of the equation are real or complex. [ rnorm(3)
# will give you a sample of size 3 from N(0,1) distribution]
#
# 2. Draw a sample of size 500 from a N(0,1)distribution and store it in a vector.
# If some of these observations are found to be more than Mean+3SD or less than Mean-3SD
# ,calculate the median of the observations. Otherwise calculate the mean of the
# observations.
#
# 3. Consider the following set of observations:
# 11 36 25 22 19 38 67 45 56 54 43 22
# 19 38 32 28 15 65 43 23 32 38 45 60
# 10 19 34 23 45 54 56 67 66 30 23 55. Prepare a frequency distribution table(for loop)
# taking class limits as 11-19, 20-29,....60-69.
#
# 4. Compute the sums of the following infinite series:
# (a) 1+x+x^2+x^3+.......
# (b) 1+2x+3x^2+...... [ Take x=0.4 in each case].
#
# 5.Draw 1000 samples of sizes 10,50,100 and 1000 from a N(0,1) distribution.
# Compute the sample mean and sample variance for each sample.
#
# 6. Problems for Data Frame:
# 6.1 Consider the following data on the marks in Mathematics, Marks in Statistics
# and Gender of 15 students.
# Mathematics			Statistics			Gender
# 87				92				M
# 65				87				M
# 32				55				F
# 99				84				F
# 47				90				M
# 65				95				M
# 76				47				M
# 81				79				F
# 55				83				M
# 69				84				F
# 85				65				F
# 90				60				M
# 49				81				F
# 76				99				M
# 21				50				F
#
# Create a data frame to incorporate the above data and answer the following questions:
# (i) Display data on Statistics only.
#
# (ii) Display marks of Mathematics for the 3rd student.
#
# (iii) Display all data for the 3rd student.
#
# (iv) Obtain the measurements on the marks in Statistics.
#
# (v) Obtain data of all students who have scored more than 75 in Statistics.
#
# (vi) Obtain data for all female students.
#
# (vii)Obtain data for all students who have scored more than 70 in Mathematics and
# more than 80 in statistics.
#
# (viii) Obtain data for all students who have scored more than 70 in Mathematics or
# more than 80 in statistics.
#
# (ix)Obtain data for all students who are not males.
#
# (x) Obtain marks in Mathematics for those who have scored more than 65 in Statistics.
#
# (xi)Obtain the average marks in Mathematics.
#
# (xii) Obtain sd of marks in Statistics.
#
# 7. Enter the following data in a variable. Call it x.
# 20,8,3,6,16,11,6,8,19,8,6,17,15,1,14,16,16,9,16,13.
#
# (i) Find the number of observations.
#
# (ii) Arrange the observations in an ascending order.
#
# (iii) Arrange the observations in a descending order.
#
# (iv) Obtain the first 5 and the last 4 observations.
#
# (v)Obtain the observations which are more than 10 and also their positions in x.
# How many such observations are there?
#
# (vi)How many times do the numbers 8,11 and 16 occur in x?
#
# (vii) Create an array ("a","b","a","a","c","a","b"). Arrange the above letters
# in ascending as well as descending order.
#
# 8. Enter the following data in a variable named x:
# 39,96,15,54,96,67,95,13,62,26,6,2,51,31,10,8.
# Obtain the following using the in-built functions in R.
# (i) Sum of the elements in x.
# (ii) Sum of those numbers which are more than 40.
# (iii)Mean of x.
# (iv)Variance and standard error of x.
# (v)The three quartiles of x and the inter-quartile range.
# (vi)Minimum and Maximum Value of x.
# (vii) Use the function summary and observe what information it gives.
#
# 9. Following are the speeds ( in km p.h.) of cars on four different types of road
# conditions:
# Type A 	Type B 	Type C	Type D
# 77		90		46		69
# 70		73		54		76
# 63		71		60		79
# 84		91		70		81
# 96		93		74		83
# Enter the data in matrix form. Give column names as road types and car types as
# row names. Compute the average speed and standard deviation of speed corresponding
# to each road condition.
# Compute the grand mean.
# Later observations corresponding to a fifth type of road condition is also noted.
# These are 94,82,92,75 and 88. Add a new column to the original matrix
# and check how the new grand mean differs from the previous one.
# From the newly formed matrix what can you say about the effect of road condition on
# speed of car?
#
# 10. Suppose 12 rats were subjected to three different diets and their gain in weights
# (in gm) in 6 months were recorded:
# A	2	5	9	1	7
# B	3	3	1
# C	5	7	3	8
# Prepare a list containing the data on A,B and C and answer the following:
# (i) Display the data on B only.
#
# (ii) Obtain the average gain in weight due to diet A.
#
# (iii) Obtain the standard deviation of the gain in weight due to diet C.
#
#
#
