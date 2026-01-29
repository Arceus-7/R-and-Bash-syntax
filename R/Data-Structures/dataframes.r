# ============================================================================
# R Data Structures: Data Frames
# ============================================================================
# Working with tabular data in R

# ----------------------------------------------------------------------------
# 1. CREATING DATA FRAMES
# ----------------------------------------------------------------------------

# Create data frame from vectors
df1 <- data.frame(
    name = c("ABC", "XYZ", "PQR", "LMN"),
    age = c(25, 30, 35, 28),
    salary = c(50000, 60000, 75000, 55000),
    department = c("IT", "HR", "Finance", "IT")
)
print(df1)

# Create with stringsAsFactors = FALSE (modern approach)
df2 <- data.frame(
    id = 1:5,
    city = c("City1", "City2", "City3", "City4", "City5"),
    population = c(1000000, 500000, 750000, 2000000, 1200000),
    stringsAsFactors = FALSE
)
print(df2)

# ----------------------------------------------------------------------------
# 2. DATA FRAME PROPERTIES
# ----------------------------------------------------------------------------

cat("Dimensions:", dim(df1), "\n")
cat("Rows:", nrow(df1), "Columns:", ncol(df1), "\n")
cat("Column names:", names(df1), "\n")
cat("Row names:", rownames(df1), "\n")
cat("Structure:\n")
str(df1)

# ----------------------------------------------------------------------------
# 3. ACCESSING DATA
# ----------------------------------------------------------------------------

# Access column by name
cat("Names:", df1$name, "\n")
cat("Ages:", df1[["age"]], "\n")
cat("Salaries:", df1[, "salary"], "\n")

# Access row
cat("First row:\n")
print(df1[1, ])

# Access specific cell
cat("First person's age:", df1[1, "age"], "\n")

# Multiple columns
cat("Name and age:\n")
print(df1[, c("name", "age")])

# Multiple rows
cat("First two rows:\n")
print(df1[1:2, ])

# ----------------------------------------------------------------------------
# 4. SUBSETTING AND FILTERING
# ----------------------------------------------------------------------------

# Filter rows where age > 28
older_than_28 <- df1[df1$age > 28, ]
print(older_than_28)

# Filter IT department
it_employees <- df1[df1$department == "IT", ]
print(it_employees)

# Multiple conditions
high_earners_it <- df1[df1$salary > 52000 & df1$department == "IT", ]
print(high_earners_it)

# Using subset()
it_dept <- subset(df1, department == "IT")
print(it_dept)

high_salary <- subset(df1, salary > 55000, select = c(name, salary))
print(high_salary)

# ----------------------------------------------------------------------------
# 5. ADDING COLUMNS
# ----------------------------------------------------------------------------

# Add new column
df1$bonus <- df1$salary * 0.1
print(df1)

# Add calculated column
df1$total_compensation <- df1$salary + df1$bonus
print(df1)

# Add column with transform()
df1 <- transform(df1, experience = age - 22)
print(df1)

# ----------------------------------------------------------------------------
# 6. ADDING ROWS
# ----------------------------------------------------------------------------

# Add single row
new_employee <- data.frame(
    name = "RST",
    age = 32,
    salary = 65000,
    department = "Finance",
    bonus = 6500,
    total_compensation = 71500,
    experience = 10
)
df1 <- rbind(df1, new_employee)
print(df1)

# ----------------------------------------------------------------------------
# 7. REMOVING COLUMNS AND ROWS
# ----------------------------------------------------------------------------

# Remove column
df_no_bonus <- df1[, !names(df1) %in% c("bonus")]
print(df_no_bonus)

# Or using NULL
df_copy <- df1
df_copy$bonus <- NULL
print(df_copy)

# Remove rows
df_without_first <- df1[-1, ]
print(df_without_first)

# Remove based on condition
df_filtered <- df1[df1$age >= 28, ]
print(df_filtered)

# ----------------------------------------------------------------------------
# 8. SORTING
# ----------------------------------------------------------------------------

# Sort by age
df_sorted_age <- df1[order(df1$age), ]
print(df_sorted_age)

# Sort descending
df_sorted_salary_desc <- df1[order(-df1$salary), ]
print(df_sorted_salary_desc)

# Sort by multiple columns
df_sorted_multi <- df1[order(df1$department, -df1$salary), ]
print(df_sorted_multi)

# ----------------------------------------------------------------------------
# 9. SUMMARY STATISTICS
# ----------------------------------------------------------------------------

# Summary of entire data frame
cat("Summary:\n")
print(summary(df1))

# Summary of specific column
cat("Age summary:\n")
print(summary(df1$age))

# Basic statistics
cat("Mean salary:", mean(df1$salary), "\n")
cat("Median age:", median(df1$age), "\n")
cat("SD of salary:", sd(df1$salary), "\n")
cat("Min age:", min(df1$age), "\n")
cat("Max salary:", max(df1$salary), "\n")

# ----------------------------------------------------------------------------
# 10. AGGREGATION
# ----------------------------------------------------------------------------

# aggregate() function
avg_salary_by_dept <- aggregate(salary ~ department, data = df1, FUN = mean)
print(avg_salary_by_dept)

# Multiple aggregations
dept_stats <- aggregate(cbind(salary, age) ~ department, data = df1, FUN = mean)
print(dept_stats)

# Count by department
dept_count <- aggregate(name ~ department, data = df1, FUN = length)
names(dept_count)[2] <- "count"
print(dept_count)

# ----------------------------------------------------------------------------
# 11. MERGING DATA FRAMES
# ----------------------------------------------------------------------------

# Create two data frames
employees <- data.frame(
    emp_id = 1:4,
    name = c("A", "B", "C", "D"),
    dept_id = c(101, 102, 101, 103)
)

departments <- data.frame(
    dept_id = c(101, 102, 103),
    dept_name = c("Sales", "Marketing", "IT")
)

# Inner join
merged_inner <- merge(employees, departments, by = "dept_id")
print(merged_inner)

# Left join
merged_left <- merge(employees, departments, by = "dept_id", all.x = TRUE)
print(merged_left)

# ----------------------------------------------------------------------------
# 12. RESHAPING DATA
# ----------------------------------------------------------------------------

# Wide to long format (using base R)
wide_data <- data.frame(
    person = c("P1", "P2", "P3"),
    year1 = c(100, 150, 120),
    year2 = c(110, 160, 130),
    year3 = c(120, 170, 140)
)
print(wide_data)

# Stack columns
long_data <- reshape(wide_data,
    varying = c("year1", "year2", "year3"),
    v.names = "value",
    timevar = "year",
    times = c("year1", "year2", "year3"),
    direction = "long"
)
print(long_data)

# ----------------------------------------------------------------------------
# 13. HANDLING MISSING DATA
# ----------------------------------------------------------------------------

# Create data with NA
df_na <- data.frame(
    x = c(1, 2, NA, 4, 5),
    y = c(10, NA, 30, 40, 50),
    z = c("a", "b", "c", NA, "e")
)
print(df_na)

# Check for NA
cat("Any NA:", any(is.na(df_na)), "\n")
cat("NA count per column:\n")
print(colSums(is.na(df_na)))

# Remove rows with any NA
df_complete <- na.omit(df_na)
print(df_complete)

# Replace NA with value
df_filled <- df_na
df_filled$x[is.na(df_filled$x)] <- mean(df_filled$x, na.rm = TRUE)
print(df_filled)

# ----------------------------------------------------------------------------
# 14. READING AND WRITING DATA
# ----------------------------------------------------------------------------

# Write to CSV
write.csv(df1, "employees.csv", row.names = FALSE)

# Read from CSV
# df_from_csv <- read.csv("employees.csv")

# Write to tab-delimited
write.table(df1, "employees.txt", sep = "\t", row.names = FALSE)

# Read with specific options
# df_from_txt <- read.table("employees.txt", header = TRUE, sep = "\t")

# ----------------------------------------------------------------------------
# 15. APPLY FUNCTIONS ON DATA FRAMES
# ----------------------------------------------------------------------------

# lapply - returns list
numeric_cols <- df1[, sapply(df1, is.numeric)]
col_means <- lapply(numeric_cols, mean)
print(col_means)

# sapply - returns vector
col_means_vec <- sapply(numeric_cols, mean)
print(col_means_vec)

# apply - by rows or columns
row_sums <- apply(numeric_cols, 1, sum)
cat("Row sums:", row_sums, "\n")

col_maxs <- apply(numeric_cols, 2, max)
cat("Column maxs:", col_maxs, "\n")

# ----------------------------------------------------------------------------
# 16. DATA FRAME OPERATIONS
# ----------------------------------------------------------------------------

# Unique values
cat("Unique departments:", unique(df1$department), "\n")

# Frequency table
dept_table <- table(df1$department)
print(dept_table)

# Cross tabulation
df_cross <- data.frame(
    gender = c("M", "F", "M", "F", "M"),
    department = c("IT", "HR", "IT", "Finance", "HR")
)
cross_tab <- table(df_cross$gender, df_cross$department)
print(cross_tab)

# Proportion table
prop_table <- prop.table(cross_tab)
print(prop_table)

# ----------------------------------------------------------------------------
# 17. CONDITIONAL OPERATIONS
# ----------------------------------------------------------------------------

# ifelse for vectorized conditions
df1$salary_category <- ifelse(df1$salary > 60000, "High", "Low")
print(df1)

# Nested ifelse
df1$performance <- ifelse(df1$salary > 70000, "Excellent",
    ifelse(df1$salary > 60000, "Good", "Average")
)
print(df1)

# ----------------------------------------------------------------------------
# 18. DUPLICATES
# ----------------------------------------------------------------------------

# Check for duplicates
df_dup <- data.frame(
    id = c(1, 2, 2, 3, 4),
    value = c(10, 20, 20, 30, 40)
)
cat("Duplicated rows:", which(duplicated(df_dup)), "\n")

# Remove duplicates
df_unique <- unique(df_dup)
print(df_unique)

# Or use
df_no_dup <- df_dup[!duplicated(df_dup), ]
print(df_no_dup)

cat("\n=== Data Frame Operations Complete ===\n")
