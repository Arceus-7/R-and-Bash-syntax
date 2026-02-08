# ============================================================================
# R Assignment Solutions
# ============================================================================

# ----------------------------------------------------------------------------
# PROBLEM 1: Quadratic Equation Roots
# ----------------------------------------------------------------------------
# Draw a sample of size 3 from N(0,1) and use as coefficients a, b, c
# Determine if roots are real or complex

cat("\n========== PROBLEM 1 ==========\n")

# Generate random coefficients
set.seed(NULL)
coefficients <- rnorm(3)
a <- coefficients[1]
b <- coefficients[2]
c <- coefficients[3]

cat("Quadratic equation:", a, "x^2 +", b, "x +", c, "= 0\n")

# Calculate discriminant
discriminant <- b^2 - 4 * a * c

# Check if roots are real or complex
if (discriminant > 0) {
    root1 <- (-b + sqrt(discriminant)) / (2 * a)
    root2 <- (-b - sqrt(discriminant)) / (2 * a)
    cat("Discriminant =", discriminant, "\n")
    cat("The roots are REAL and DISTINCT:\n")
    cat("Root 1 =", root1, "\n")
    cat("Root 2 =", root2, "\n")
} else if (discriminant == 0) {
    root <- -b / (2 * a)
    cat("Discriminant =", discriminant, "\n")
    cat("The roots are REAL and EQUAL:\n")
    cat("Root =", root, "\n")
} else {
    real_part <- -b / (2 * a)
    imaginary_part <- sqrt(abs(discriminant)) / (2 * a)
    cat("Discriminant =", discriminant, "\n")
    cat("The roots are COMPLEX:\n")
    cat("Root 1 =", real_part, "+", imaginary_part, "i\n")
    cat("Root 2 =", real_part, "-", imaginary_part, "i\n")
}

# ----------------------------------------------------------------------------
# PROBLEM 2: Outlier Detection and Statistics
# ----------------------------------------------------------------------------
# Draw 500 samples from N(0,1) and calculate median if outliers exist,
# otherwise calculate mean

cat("\n========== PROBLEM 2 ==========\n")

set.seed(42)
sample_data <- rnorm(500)

# Calculate mean and SD
mean_val <- mean(sample_data)
sd_val <- sd(sample_data)

# Define outlier thresholds
upper_threshold <- mean_val + 3 * sd_val
lower_threshold <- mean_val - 3 * sd_val

# Check for outliers
outliers <- sample_data[sample_data > upper_threshold | sample_data < lower_threshold]
has_outliers <- length(outliers) > 0

cat("Mean =", mean_val, "\n")
cat("Standard Deviation =", sd_val, "\n")
cat("Upper threshold (Mean + 3SD) =", upper_threshold, "\n")
cat("Lower threshold (Mean - 3SD) =", lower_threshold, "\n")
cat("Does it have any outliers?\n", has_outliers, "\n")
cat("Number of outliers found =", length(outliers), "\n")

if (has_outliers) {
    cat("Outliers detected! Calculating MEDIAN...\n")
    result <- median(sample_data)
    cat("Median =", result, "\n")
} else {
    cat("No outliers detected! Calculating MEAN...\n")
    cat("Mean =", mean_val, "\n")
}

# ----------------------------------------------------------------------------
# PROBLEM 3: Frequency Distribution Table
# ----------------------------------------------------------------------------
# Create frequency distribution with class limits 11-19, 20-29, ..., 60-69

cat("\n========== PROBLEM 3 ==========\n")

observations <- c(
    11, 36, 25, 22, 19, 38, 67, 45, 56, 54, 43, 22,
    19, 38, 32, 28, 15, 65, 43, 23, 32, 38, 45, 60,
    10, 19, 34, 23, 45, 54, 56, 67, 66, 30, 23, 55
)

# Define class intervals
class_limits <- c("10-19", "20-29", "30-39", "40-49", "50-59", "60-69")
class_breaks <- c(10, 20, 30, 40, 50, 60, 70)

# Initialize frequency vector
frequencies <- numeric(length(class_limits))

# Count frequencies using for loop
for (i in seq_along(class_limits)) {
    count <- 0
    for (obs in observations) {
        if (obs >= class_breaks[i] && obs < class_breaks[i + 1]) {
            count <- count + 1
        }
    }
    frequencies[i] <- count
}

# Create and display frequency table
freq_table <- data.frame(
    Class_Interval = class_limits,
    Frequency = frequencies
)

cat("\nFrequency Distribution Table:\n")
print(freq_table)
cat("\nTotal observations:", sum(frequencies), "\n")

# ----------------------------------------------------------------------------
# PROBLEM 4: Infinite Series Computation
# ----------------------------------------------------------------------------
# Compute (a) 1 + x + x^2 + x^3 + ... and (b) 1 + 2x + 3x^2 + ...
# with x = 0.4

cat("\n========== PROBLEM 4 ==========\n")

x <- 0.4
tolerance <- 1e-10
max_terms <- 1000

# Series (a): 1 + x + x^2 + x^3 + ...
# Geometric series with sum = 1 / (1 - x) for |x| < 1
sum_a <- 0
term_a <- 1
n <- 0

while (abs(term_a) > tolerance && n < max_terms) {
    sum_a <- sum_a + term_a
    n <- n + 1
    term_a <- x^n
}

cat("Series (a): 1 + x + x^2 + x^3 + ...\n")
cat("Number of terms computed:", n, "\n")
cat("Sum =", sum_a, "\n")
cat("Theoretical sum (1/(1-x)) =", 1 / (1 - x), "\n")

# Series (b): 1 + 2x + 3x^2 + 4x^3 + ...
# This is the derivative of series (a), sum = 1 / (1 - x)^2
sum_b <- 0
n <- 0

while (n < max_terms) {
    term_b <- (n + 1) * x^n
    if (abs(term_b) < tolerance) break
    sum_b <- sum_b + term_b
    n <- n + 1
}

cat("\nSeries (b): 1 + 2x + 3x^2 + 4x^3 + ...\n")
cat("Number of terms computed:", n, "\n")
cat("Sum =", sum_b, "\n")
cat("Theoretical sum (1/(1-x)^2) =", 1 / (1 - x)^2, "\n")

# ----------------------------------------------------------------------------
# PROBLEM 5: Sampling and Statistics
# ----------------------------------------------------------------------------
# Draw 1000 samples of different sizes and compute mean and variance

cat("\n========== PROBLEM 5 ==========\n")

set.seed(123)
sample_sizes <- c(10, 50, 100, 1000)
num_samples <- 1000

for (size in sample_sizes) {
    cat("\n--- Sample size:", size, "---\n")

    sample_means <- numeric(num_samples)
    sample_variances <- numeric(num_samples)

    for (i in seq_len(num_samples)) {
        sample_data <- rnorm(size)
        sample_means[i] <- mean(sample_data)
        sample_variances[i] <- var(sample_data)
    }

    cat("Mean of sample means:", mean(sample_means), "\n")
    cat("Variance of sample means:", var(sample_means), "\n")
    cat("Mean of sample variances:", mean(sample_variances), "\n")
    cat("Variance of sample variances:", var(sample_variances), "\n")
}

# ----------------------------------------------------------------------------
# PROBLEM 6: Data Frame Operations
# ----------------------------------------------------------------------------
# Student marks in Mathematics and Statistics

cat("\n========== PROBLEM 6 ==========\n")

# Create the data frame
students <- data.frame(
    Mathematics = c(87, 65, 32, 99, 47, 65, 76, 81, 55, 69, 85, 90, 49, 76, 21),
    Statistics = c(92, 87, 55, 84, 90, 95, 47, 79, 83, 84, 65, 60, 81, 99, 50),
    Gender = c("M", "M", "F", "F", "M", "M", "M", "F", "M", "F", "F", "M", "F", "M", "F")
)

cat("\nOriginal Data Frame:\n")
print(students)

# (i) Display data on Statistics only
cat("\n(i) Statistics data only:\n")
print(students$Statistics)

# (ii) Display marks of Mathematics for the 3rd student
cat("\n(ii) Mathematics marks for 3rd student:\n")
print(students$Mathematics[3])

# (iii) Display all data for the 3rd student
cat("\n(iii) All data for 3rd student:\n")
print(students[3, ])

# (iv) Obtain the measurements on the marks in Statistics
cat("\n(iv) Measurements on Statistics marks:\n")
print(summary(students$Statistics))

# (v) Students who scored more than 75 in Statistics
cat("\n(v) Students with Statistics > 75:\n")
print(students[students$Statistics > 75, ])

# (vi) All female students
cat("\n(vi) All female students:\n")
print(students[students$Gender == "F", ])

# (vii) Students with Math > 70 AND Stats > 80
cat("\n(vii) Students with Math > 70 AND Stats > 80:\n")
print(students[students$Mathematics > 70 & students$Statistics > 80, ])

# (viii) Students with Math > 70 OR Stats > 80
cat("\n(viii) Students with Math > 70 OR Stats > 80:\n")
print(students[students$Mathematics > 70 | students$Statistics > 80, ])

# (ix) Students who are not males
cat("\n(ix) Students who are not males:\n")
print(students[students$Gender != "M", ])

# (x) Math marks for those with Stats > 65
cat("\n(x) Math marks for students with Stats > 65:\n")
print(students$Mathematics[students$Statistics > 65])

# (xi) Average marks in Mathematics
cat("\n(xi) Average marks in Mathematics:", mean(students$Mathematics), "\n")

# (xii) SD of marks in Statistics
cat("\n(xii) Standard deviation of Statistics marks:", sd(students$Statistics), "\n")

# ----------------------------------------------------------------------------
# PROBLEM 7: Vector Operations
# ----------------------------------------------------------------------------

cat("\n========== PROBLEM 7 ==========\n")

x <- c(20, 8, 3, 6, 16, 11, 6, 8, 19, 8, 6, 17, 15, 1, 14, 16, 16, 9, 16, 13)

# (i) Number of observations
cat("(i) Number of observations:", length(x), "\n")

# (ii) Ascending order
cat("\n(ii) Observations in ascending order:\n")
print(sort(x))

# (iii) Descending order
cat("\n(iii) Observations in descending order:\n")
print(sort(x, decreasing = TRUE))

# (iv) First 5 and last 4 observations
cat("\n(iv) First 5 observations:\n")
print(head(x, 5))
cat("Last 4 observations:\n")
print(tail(x, 4))

# (v) Observations more than 10 and their positions
cat("\n(v) Observations more than 10:\n")
greater_than_10 <- x[x > 10]
positions <- which(x > 10)
print(greater_than_10)
cat("Positions:", positions, "\n")
cat("Count:", length(greater_than_10), "\n")

# (vi) Frequency of 8, 11, and 16
cat("\n(vi) Frequency of specific numbers:\n")
cat("8 occurs:", sum(x == 8), "times\n")
cat("11 occurs:", sum(x == 11), "times\n")
cat("16 occurs:", sum(x == 16), "times\n")

# (vii) Array sorting
cat("\n(vii) Letter array sorting:\n")
letters_array <- c("a", "b", "a", "a", "c", "a", "b")
cat("Original:", letters_array, "\n")
cat("Ascending:", sort(letters_array), "\n")
cat("Descending:", sort(letters_array, decreasing = TRUE), "\n")

# ----------------------------------------------------------------------------
# PROBLEM 8: Statistical Functions
# ----------------------------------------------------------------------------

cat("\n========== PROBLEM 8 ==========\n")

x <- c(39, 96, 15, 54, 96, 67, 95, 13, 62, 26, 6, 2, 51, 31, 10, 8)

# (i) Sum of elements
cat("(i) Sum of elements:", sum(x), "\n")

# (ii) Sum of numbers > 40
cat("\n(ii) Sum of numbers > 40:", sum(x[x > 40]), "\n")

# (iii) Mean
cat("\n(iii) Mean of x:", mean(x), "\n")

# (iv) Variance and standard deviation
cat("\n(iv) Variance:", var(x), "| SD:", sd(x), "| SE:", sd(x) / sqrt(length(x)), "\n")

# (v) Quartiles and IQR
cat("\n(v) Quartiles:\n")
quartiles <- quantile(x, probs = c(0.25, 0.5, 0.75))
print(quartiles)
cat("Inter-quartile range (IQR):", IQR(x), "\n")

# (vi) Minimum and Maximum
cat("\n(vi) Range: [", min(x), ",", max(x), "]\n")

# (vii) Summary function
cat("\n(vii) Summary of x:\n")
print(summary(x))

# ----------------------------------------------------------------------------
# PROBLEM 9: Matrix Operations - Road Conditions
# ----------------------------------------------------------------------------

cat("\n========== PROBLEM 9 ==========\n")

# Create matrix with car speeds
speed_data <- matrix(
    c(
        77, 70, 63, 84, 96, # Type A
        90, 73, 71, 91, 93, # Type B
        46, 54, 60, 70, 74, # Type C
        69, 76, 79, 81, 83 ), # Type D
    nrow = 5,
    ncol = 4,
    byrow = FALSE
)

# Set column names and row names
colnames(speed_data) <- c("Type_A", "Type_B", "Type_C", "Type_D")
rownames(speed_data) <- c("Car1", "Car2", "Car3", "Car4", "Car5")

cat("\nOriginal Speed Matrix:\n")
print(speed_data)

# Calculate average speed for each road type
cat("\nAverage speed for each road type:\n")
avg_speeds <- colMeans(speed_data)
print(avg_speeds)

# Calculate standard deviation for each road type
cat("\nStandard deviation for each road type:\n")
sd_speeds <- apply(speed_data, 2, sd)
print(sd_speeds)

# Calculate grand mean
grand_mean_original <- mean(speed_data)
cat("\nGrand mean (original):", grand_mean_original, "\n")

# Add new column for Type E
type_e <- c(94, 82, 92, 75, 88)
speed_data_new <- cbind(speed_data, Type_E = type_e)

cat("\nNew Speed Matrix with Type E:\n")
print(speed_data_new)

# Calculate new grand mean
grand_mean_new <- mean(speed_data_new)
cat("\nGrand mean (with Type E):", grand_mean_new, "\n")
cat("Difference in grand means:", grand_mean_new - grand_mean_original, "\n")

# Analysis
cat("\nAnalysis of road condition effect:\n")
cat("Average speeds by road type:\n")
print(colMeans(speed_data_new))
cat(
    "\nObservation: Type B roads have the highest average speed (", mean(speed_data[, "Type_B"]),
    "km/h),\n"
)
cat("while Type C roads have the lowest (", mean(speed_data[, "Type_C"]), "km/h).\n")
cat("Road condition significantly affects car speed.\n")

# ----------------------------------------------------------------------------
# PROBLEM 10: List Operations - Diet Experiment
# ----------------------------------------------------------------------------

cat("\n========== PROBLEM 10 ==========\n")

# Create list with diet data
diet_data <- list(
    A = c(2, 5, 9, 1, 7),
    B = c(3, 3, 1),
    C = c(5, 7, 3, 8)
)

cat("Complete diet data (as list):\n")
print(diet_data)

# (i) Display data on B only
cat("\n(i) Data on diet B only:\n")
print(diet_data$B)

# (ii) Average gain in weight for diet A
cat("\n(ii) Average gain in weight for diet A:\n")
avg_A <- mean(diet_data$A)
cat("Mean =", avg_A, "gm\n")

# (iii) Standard deviation for diet C
cat("\n(iii) Standard deviation of weight gain for diet C:\n")
sd_C <- sd(diet_data$C)
cat("SD =", sd_C, "gm\n")

# Additional analysis
cat("\nSummary statistics for all diets:\n")
for (diet_name in names(diet_data)) {
    cat("\nDiet", diet_name, ":\n")
    print(summary(diet_data[[diet_name]]))
    cat("SD =", sd(diet_data[[diet_name]]), "gm\n")
}

