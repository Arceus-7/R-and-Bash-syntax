# ============================================================================
# R Functions: Custom Functions and Apply Family
# ============================================================================

# ----------------------------------------------------------------------------
# 1. BASIC FUNCTION DEFINITION
# ----------------------------------------------------------------------------

# Simple function
greet <- function() {
  cat("Hello, World!\n")
}
greet()

# Function with parameters
greet_person <- function(name) {
  cat("Hello,", name, "!\n")
}
greet_person("ABC")
greet_person("XYZ")

# Function with return value
add_numbers <- function(a, b) {
  return(a + b)
}
result <- add_numbers(5, 3)
cat("5 + 3 =", result, "\n")

# ----------------------------------------------------------------------------
# 2. DEFAULT PARAMETERS
# ----------------------------------------------------------------------------

greet_with_default <- function(name = "Guest", greeting = "Hello") {
  cat(greeting, ", ", name, "!\n", sep = "")
}
greet_with_default()
greet_with_default("ABC")
greet_with_default("XYZ", "Hi")

# ----------------------------------------------------------------------------
# 3. VARIABLE NUMBER OF ARGUMENTS
# ----------------------------------------------------------------------------

sum_all <- function(...) {
  args <- list(...)
  return(sum(unlist(args)))
}
cat("sum_all(1,2,3):", sum_all(1, 2, 3), "\n")
cat("sum_all(1,2,3,4,5):", sum_all(1, 2, 3, 4, 5), "\n")

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

data <- c(12, 15, 18, 22, 25, 28, 30)
stats <- calculate_stats(data)
cat("Mean:", stats$mean, "\n")
cat("Median:", stats$median, "\n")
cat("SD:", stats$sd, "\n")

# ----------------------------------------------------------------------------
# 5. APPLY FAMILY
# ----------------------------------------------------------------------------

# lapply - returns list
numbers <- list(c(1, 2, 3), c(4, 5, 6), c(7, 8, 9))
means <- lapply(numbers, mean)
print(means)

# sapply - returns vector
sums <- sapply(numbers, sum)
cat("Sums:", sums, "\n")

# apply - for matrices
matrix_data <- matrix(1:12, nrow = 3, ncol = 4)
print(matrix_data)
cat("Row sums:", apply(matrix_data, 1, sum), "\n")
cat("Column sums:", apply(matrix_data, 2, sum), "\n")

# ----------------------------------------------------------------------------
# 6. CUSTOM FUNCTION WITH APPLY
# ----------------------------------------------------------------------------

square <- function(x) {
  return(x^2)
}
values <- 1:5
cat("Original:", values, "\n")
squared <- sapply(values, square)
cat("Squared:", squared, "\n")

# ----------------------------------------------------------------------------
# 7. ANONYMOUS FUNCTIONS
# ----------------------------------------------------------------------------

doubled <- sapply(1:5, function(x) x * 2)
cat("Doubled:", doubled, "\n")

cubed <- sapply(1:5, function(x) x^3)
cat("Cubed:", cubed, "\n")

# ----------------------------------------------------------------------------
# 8. PRACTICAL EXAMPLE
# ----------------------------------------------------------------------------

# Process student scores
process_scores <- function(scores, bonus = 0) {
  adjusted <- scores + bonus
  adjusted <- pmin(adjusted, 100)
  
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
cat("Original scores:", scores, "\n")
result <- process_scores(scores, bonus = 5)
cat("After +5 bonus:", result$adjusted, "\n")
cat("Grades:", result$grades, "\n")
cat("Average:", result$average, "\n")
