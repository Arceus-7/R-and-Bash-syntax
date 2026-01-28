# ============================================================================
# R Basics: Variables and Data Types
# ============================================================================
# This script covers fundamental R concepts including variables, data types,
# and basic operations.

# ----------------------------------------------------------------------------
# 1. VARIABLES
# ----------------------------------------------------------------------------

# Numeric variables
x <- 42
y <- 3.14159
z <- -17.5
cat(x, y, z, "\n")

# Character (String) variables
name <- "ABC"
greeting <- 'Hello, World!'
message <- "Learning R"
cat(name, greeting, message, "\n")

# Logical (Boolean) variables
is_student <- TRUE
is_raining <- FALSE
has_passed <- T  # T is shorthand for TRUE
failed_test <- F  # F is shorthand for FALSE
cat(is_student, is_raining, "\n")

# ----------------------------------------------------------------------------
# 2. DATA TYPES
# ----------------------------------------------------------------------------

# Check type of variables
cat(class(x), class(name), class(is_student), "\n")
cat(typeof(x), typeof(name), typeof(is_student), "\n")

# Integer type (requires L suffix)
count <- 10L
cat(count, class(count), "\n")

# Type checking functions
cat(is.numeric(x), is.character(name), is.logical(is_student), is.integer(count), "\n")

# ----------------------------------------------------------------------------
# 3. TYPE CONVERSION
# ----------------------------------------------------------------------------

# String to number
num_str <- "123"
num_val <- as.numeric(num_str)
cat(num_str, num_val, "\n")

# Logical to numeric
log_num <- as.numeric(TRUE)   # TRUE becomes 1
log_num2 <- as.numeric(FALSE) # FALSE becomes 0
cat(log_num, log_num2, "\n")

# Number to character
num_char <- as.character(3.14)
cat(num_char, "\n")

# ----------------------------------------------------------------------------
# 4. SPECIAL VALUES
# ----------------------------------------------------------------------------

# NA - Not Available (missing value)
missing_value <- NA
cat("NA:", missing_value, "\n")

# NULL - Empty/undefined
empty_value <- NULL
cat("NULL:", empty_value, "\n")

# Inf - Infinity
cat("Infinity:", 1/0, "\n")

# NaN - Not a Number
cat("NaN:", 0/0, "\n")

# ----------------------------------------------------------------------------
# 5. PRINTING AND OUTPUT
# ----------------------------------------------------------------------------

# print() - basic printing
print(x)

# cat() - concatenate and print
cat("x =", x, "\n")

# paste() - concatenate strings
result <- paste("x =", x, "and y =", y)
print(result)

# paste0() - concatenate without spaces
result2 <- paste0("x=", x, " y=", y)
print(result2)

# sprintf() - formatted printing
result3 <- sprintf("x = %.2f, y = %.4f", x, y)
print(result3)
