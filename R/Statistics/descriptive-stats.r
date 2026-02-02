# ============================================================================
# R Statistics: Descriptive Statistics
# ============================================================================
# Comprehensive coverage of descriptive statistical measures

# ----------------------------------------------------------------------------
# 1. MEASURES OF CENTRAL TENDENCY
# ----------------------------------------------------------------------------

# Sample data
data <- c(12, 15, 18, 22, 25, 28, 30, 35, 40, 45)

# Mean (average)
data_mean <- mean(data)
cat("Mean:", data_mean, "\n")

# Median (middle value)
data_median <- median(data)
cat("Median:", data_median, "\n")

# Mode (most frequent value)
find_mode <- function(x) {
    ux <- unique(x)
    ux[which.max(tabulate(match(x, ux)))]
}

data_with_mode <- c(1, 2, 2, 3, 3, 3, 4, 5)
data_mode <- find_mode(data_with_mode)
cat("Mode:", data_mode, "\n")

# Weighted mean
values <- c(10, 20, 30)
weights <- c(2, 3, 5)
weighted_mean <- weighted.mean(values, weights)
cat("Weighted mean:", weighted_mean, "\n")

# Trimmed mean (remove outliers)
data_with_outliers <- c(10, 12, 15, 18, 20, 22, 100)
trimmed_mean <- mean(data_with_outliers, trim = 0.1) # Remove 10% from each end
cat("Trimmed mean (10%):", trimmed_mean, "\n")

# ----------------------------------------------------------------------------
# 2. MEASURES OF DISPERSION
# ----------------------------------------------------------------------------

# Variance
data_var <- var(data)
cat("Variance:", data_var, "\n")

# Standard deviation
data_sd <- sd(data)
cat("Standard deviation:", data_sd, "\n")

# Range
data_range <- range(data)
cat("Range:", data_range, "\n")
cat("Range width:", diff(data_range), "\n")

# Interquartile range (IQR)
data_iqr <- IQR(data)
cat("IQR:", data_iqr, "\n")

# Mean absolute deviation
mad_value <- mad(data)
cat("MAD:", mad_value, "\n")

# Coefficient of variation
cv <- (data_sd / data_mean) * 100
cat("Coefficient of variation:", cv, "%\n")

# ----------------------------------------------------------------------------
# 3. QUANTILES AND PERCENTILES
# ----------------------------------------------------------------------------

# Quartiles
quartiles <- quantile(data)
print(quartiles)

# Specific percentiles
percentiles <- quantile(data, probs = c(0.25, 0.50, 0.75, 0.90, 0.95))
print(percentiles)

# Custom quantiles
deciles <- quantile(data, probs = seq(0, 1, 0.1))
print(deciles)

# ----------------------------------------------------------------------------
# 4. FIVE-NUMBER SUMMARY
# ----------------------------------------------------------------------------

# Min, Q1, Median, Q3, Max
five_num <- fivenum(data)
cat("Five-number summary:", five_num, "\n")

# Comprehensive summary
cat("Summary:\n")
print(summary(data))

# ----------------------------------------------------------------------------
# 5. SHAPE OF DISTRIBUTION
# ----------------------------------------------------------------------------

# Skewness (requires moments package, using manual calculation)
calculate_skewness <- function(x) {
    n <- length(x)
    m <- mean(x)
    s <- sd(x)
    sum((x - m)^3) / (n * s^3)
}

skew <- calculate_skewness(data)
cat("Skewness:", skew, "\n")

# Kurtosis (manual calculation)
calculate_kurtosis <- function(x) {
    n <- length(x)
    m <- mean(x)
    s <- sd(x)
    sum((x - m)^4) / (n * s^4) - 3
}

kurt <- calculate_kurtosis(data)
cat("Kurtosis:", kurt, "\n")

# ----------------------------------------------------------------------------
# 6. FREQUENCY DISTRIBUTIONS
# ----------------------------------------------------------------------------

# Create frequency table
scores <- c(65, 72, 75, 78, 80, 80, 82, 85, 85, 85, 88, 90, 92, 95, 98)

# Simple frequency table
freq_table <- table(scores)
print(freq_table)

# Relative frequency
rel_freq <- prop.table(freq_table)
print(rel_freq)

# Grouped frequency distribution
breaks <- seq(60, 100, by = 10)
grouped <- cut(scores, breaks = breaks, right = FALSE)
grouped_freq <- table(grouped)
print(grouped_freq)

# Cumulative frequency
cum_freq <- cumsum(as.vector(grouped_freq))
cat("Cumulative frequency:", cum_freq, "\n")

# ----------------------------------------------------------------------------
# 7. CROSS-TABULATION
# ----------------------------------------------------------------------------

# Two-way frequency table
gender <- c("M", "F", "M", "F", "M", "F", "M", "F")
grade <- c("A", "B", "A", "A", "B", "C", "A", "B")

# Create contingency table
cross_tab <- table(gender, grade)
print(cross_tab)

# Row proportions
row_props <- prop.table(cross_tab, margin = 1)
print(row_props)

# Column proportions
col_props <- prop.table(cross_tab, margin = 2)
print(col_props)

# Overall proportions
overall_props <- prop.table(cross_tab)
print(overall_props)

# ----------------------------------------------------------------------------
# 8. GROUPED DATA SUMMARY
# ----------------------------------------------------------------------------

# Create dataset
df <- data.frame(
    category = c("A", "A", "B", "B", "C", "C"),
    value = c(10, 15, 20, 25, 30, 35)
)

# Summary by group
aggregate(value ~ category, data = df, FUN = mean)
aggregate(value ~ category, data = df, FUN = sd)
aggregate(value ~ category, data = df, FUN = length)

# Multiple statistics
aggregate(value ~ category, data = df, FUN = function(x) {
    c(mean = mean(x), sd = sd(x), min = min(x), max = max(x))
})

# ----------------------------------------------------------------------------
# 9. OUTLIER DETECTION
# ----------------------------------------------------------------------------

# IQR method
Q1 <- quantile(data, 0.25)
Q3 <- quantile(data, 0.75)
IQR_val <- Q3 - Q1

lower_bound <- Q1 - 1.5 * IQR_val
upper_bound <- Q3 + 1.5 * IQR_val

outliers <- data[data < lower_bound | data > upper_bound]
cat("Outliers:", outliers, "\n")

# Z-score method
z_scores <- (data - mean(data)) / sd(data)
outliers_z <- data[abs(z_scores) > 2]
cat("Outliers (Z > 2):", outliers_z, "\n")

# ----------------------------------------------------------------------------
# 10. CORRELATION AND COVARIANCE
# ----------------------------------------------------------------------------

# Two variables
x <- c(1, 2, 3, 4, 5)
y <- c(2, 4, 5, 4, 5)

# Covariance
cov_xy <- cov(x, y)
cat("Covariance:", cov_xy, "\n")

# Pearson correlation
cor_pearson <- cor(x, y, method = "pearson")
cat("Pearson correlation:", cor_pearson, "\n")

# Spearman correlation
cor_spearman <- cor(x, y, method = "spearman")
cat("Spearman correlation:", cor_spearman, "\n")

# Kendall correlation
cor_kendall <- cor(x, y, method = "kendall")
cat("Kendall correlation:", cor_kendall, "\n")

# ----------------------------------------------------------------------------
# 11. STANDARDIZATION AND NORMALIZATION
# ----------------------------------------------------------------------------

# Z-score standardization
standardized <- scale(data)
cat("Standardized (first 5):", head(standardized, 5), "\n")
cat("Mean:", mean(standardized), "SD:", sd(standardized), "\n")

# Min-max normalization
normalize <- function(x) {
    (x - min(x)) / (max(x) - min(x))
}
normalized <- normalize(data)
cat("Normalized (first 5):", head(normalized, 5), "\n")

# ----------------------------------------------------------------------------
# 12. PRACTICAL EXAMPLES
# ----------------------------------------------------------------------------

# Example 1: Student grades analysis
grades <- c(55, 62, 68, 72, 75, 78, 82, 85, 88, 92, 95)

cat("\n=== Student Grades Analysis ===\n")
cat("Mean:", mean(grades), "\n")
cat("Median:", median(grades), "\n")
cat("SD:", sd(grades), "\n")
cat("Min:", min(grades), "Max:", max(grades), "\n")
print(summary(grades))

# Example 2: Sales data
sales <- c(10000, 12000, 15000, 18000, 20000, 22000, 25000)

cat("\n=== Sales Summary ===\n")
cat("Total sales:", sum(sales), "\n")
cat("Average sales:", mean(sales), "\n")
cat("SD:", sd(sales), "\n")
cat("Growth range:", max(sales) - min(sales), "\n")

# Example 3: Compare two groups
group_a <- c(85, 88, 90, 92, 95)
group_b <- c(70, 75, 78, 80, 85)

cat("\n=== Group Comparison ===\n")
cat("Group A - Mean:", mean(group_a), "SD:", sd(group_a), "\n")
cat("Group B - Mean:", mean(group_b), "SD:", sd(group_b), "\n")
cat("Difference in means:", mean(group_a) - mean(group_b), "\n")
