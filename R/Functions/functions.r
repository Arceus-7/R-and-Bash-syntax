# ============================================================================
# R Functions: Custom Functions and Apply Family
# ============================================================================
# Learn to create and use functions in R

cat("=== R Functions ===\n\n")

# ----------------------------------------------------------------------------
# 1. BASIC FUNCTION DEFINITION
# ----------------------------------------------------------------------------

# Simple function
greet <- function() {
  cat("Hello, World!\n")
}

cat("1. Simple function:\n")
greet()
cat("\n")

# Function with parameters
greet_person <- function(name) {
  cat("Hello,", name, "!\n")
}

cat("2. Function with parameters:\n")
greet_person("ABC")
greet_person("XYZ")
cat("\n")

# Function with multiple parameters
add_numbers <- function(a, b) {
  return(a + b)
}

cat("3. Function with return value:\n")
result <- add_numbers(5, 3)
cat("5 + 3 =", result, "\n\n")

# ----------------------------------------------------------------------------
# 2. DEFAULT PARAMETERS
# ----------------------------------------------------------------------------

greet_with_default <- function(name = "Guest", greeting = "Hello") {
  cat(greeting, ", ", name, "!\n", sep = "")
}

cat("4. Default parameters:\n")
greet_with_default()                          # Uses defaults
greet_with_default("ABC")                    # Uses default greeting
greet_with_default("XYZ", "Hi")              # Custom both
greet_with_default(greeting = "Welcome")     # Named parameter
cat("\n")

# ----------------------------------------------------------------------------
# 3. VARIABLE NUMBER OF ARGUMENTS
# ----------------------------------------------------------------------------

sum_all <- function(...) {
  args <- list(...)
  return(sum(unlist(args)))
}

cat("5. Variable arguments:\n")
cat("sum_all(1, 2, 3) =", sum_all(1, 2, 3), "\n")
cat("sum_all(1, 2, 3, 4, 5) =", sum_all(1, 2, 3, 4, 5), "\n\n")

# ----------------------------------------------------------------------------
# 4. RETURNING MULTIPLE VALUES
# ----------------------------------------------------------------------------

calculate_stats <- function(numbers) {
  list(
    mean = mean(numbers),
    median = median(numbers),
    sd = sd(numbers),
    min = min(numbers),
    max = max(numbers)
  )
}

cat("6. Returning multiple values:\n")
data <- c(12, 15, 18, 22, 25, 28, 30)
stats <- calculate_stats(data)
cat("Data:", data, "\n")
cat("Mean:", stats$mean, "\n")
cat("Median:", stats$median, "\n")
cat("SD:", stats$sd, "\n\n")

# ----------------------------------------------------------------------------
# 5. APPLY FAMILY - lapply (returns list)
# ----------------------------------------------------------------------------

cat("=== Apply Family ===\n\n")

numbers <- list(c(1, 2, 3), c(4, 5, 6), c(7, 8, 9))

cat("7. lapply - apply to list:\n")
cat("Original list:\n")
print(numbers)

# Apply mean to each element
means <- lapply(numbers, mean)
cat("Means:\n")
print(means)
cat("\n")

# ----------------------------------------------------------------------------
# 6. SAPPLY (simplified apply - returns vector)
# ----------------------------------------------------------------------------

cat("8. sapply - simplified apply:\n")
sums <- sapply(numbers, sum)
cat("Sums:", sums, "\n\n")

# ----------------------------------------------------------------------------
# 7. APPLY (for matrices)
# ----------------------------------------------------------------------------

matrix_data <- matrix(1:12, nrow = 3, ncol = 4)

cat("9. apply - for matrices:\n")
cat("Matrix:\n")
print(matrix_data)
cat("\n")

# Apply sum to rows (margin = 1)
row_sums <- apply(matrix_data, 1, sum)
cat("Row sums:", row_sums, "\n")

# Apply sum to columns (margin = 2)
col_sums <- apply(matrix_data, 2, sum)
cat("Column sums:", col_sums, "\n\n")

# ----------------------------------------------------------------------------
# 8. CUSTOM FUNCTION WITH APPLY
# ----------------------------------------------------------------------------

square <- function(x) {
  return(x^2)
}

values <- 1:5
cat("10. Custom function with sapply:\n")
cat("Original:", values, "\n")
squared <- sapply(values, square)
cat("Squared:", squared, "\n\n")

# ----------------------------------------------------------------------------
# 9. ANONYMOUS FUNCTIONS
# ----------------------------------------------------------------------------

cat("11. Anonymous (lambda) functions:\n")
doubled <- sapply(1:5, function(x) x * 2)
cat("Doubled:", doubled, "\n")

cubed <- sapply(1:5, function(x) x^3)
cat("Cubed:", cubed, "\n\n")

# ----------------------------------------------------------------------------
# 10. PRACTICAL EXAMPLE - Data Processing
# ----------------------------------------------------------------------------

cat("=== Practical Example ===\n\n")

# Process student scores
process_scores <- function(scores, bonus = 0) {
  # Add bonus
  adjusted <- scores + bonus
  
  # Cap at 100
  adjusted <- pmin(adjusted, 100)
  
  # Calculate grade
  grade <- sapply(adjusted, function(score) {
    if (score >= 90) "A"
    else if (score >= 80) "B"
    else if (score >= 70) "C"
    else if (score >= 60) "D"
    else "F"
  })
  
  list(
    original = scores,
    adjusted = adjusted,
    grades = grade,
    average = mean(adjusted)
  )
}

scores <- c(78, 85, 92, 65, 88, 95, 72)
cat("Student scores:", scores, "\n")

result <- process_scores(scores, bonus = 5)
cat("After +5 bonus:", result$adjusted, "\n")
cat("Grades:", result$grades, "\n")
cat("Class average:", result$average, "\n\n")

# ----------------------------------------------------------------------------
# EXERCISES
# ----------------------------------------------------------------------------

cat("=== EXERCISES ===\n")
cat("1. Write a function to calculate factorial of a number\n")
cat("2. Create a function that checks if a number is prime\n")
cat("3. Use lapply to square each number in list(1:3, 4:6, 7:9)\n")
cat("4. Write a function that takes a vector and returns min, max, range\n")
cat("5. Use sapply with anonymous function to convert Celsius to Fahrenheit\n")
cat("   Formula: F = C * 9/5 + 32, Test: c(0, 10, 20, 30, 100)\n\n")

# Solutions (commented):
# factorial_func <- function(n) { if(n <= 1) 1 else n * factorial_func(n-1) }
# is_prime <- function(n) { if(n < 2) FALSE else !any(n %% 2:(n-1) == 0) }
# lapply(list(1:3, 4:6, 7:9), function(x) x^2)
# minmax <- function(v) list(min=min(v), max=max(v), range=max(v)-min(v))
# sapply(c(0, 10, 20, 30, 100), function(c) c * 9/5 + 32)
