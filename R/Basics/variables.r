# ============================================================================
# R Basics: Variables and Data Types
# ============================================================================
# This script covers fundamental R concepts including variables, data types,
# and basic operations.

cat("=== R Variables and Data Types ===\n\n")

# ----------------------------------------------------------------------------
# 1. VARIABLES
# ----------------------------------------------------------------------------
# Variables in R are created using the assignment operator <-
# You can also use = but <- is preferred in R

# Numeric variables
x <- 42
y <- 3.14159
z <- -17.5

cat("Numeric variables:\n")
cat("x =", x, "\n")
cat("y =", y, "\n")
cat("z =", z, "\n\n")

# Character (String) variables
name <- "ABC"
greeting <- 'Hello, World!'
message <- "Learning R"

cat("Character variables:\n")
cat("name =", name, "\n")
cat("greeting =", greeting, "\n")
cat("message =", message, "\n\n")

# Logical (Boolean) variables
is_student <- TRUE
is_raining <- FALSE
has_passed <- T  # T is shorthand for TRUE
failed_test <- F  # F is shorthand for FALSE

cat("Logical variables:\n")
cat("is_student =", is_student, "\n")
cat("is_raining =", is_raining, "\n\n")

# ----------------------------------------------------------------------------
# 2. DATA TYPES
# ----------------------------------------------------------------------------

# Check type of variables
cat("Data types:\n")
cat("class(x) =", class(x), "\n")           # "numeric"
cat("class(name) =", class(name), "\n")     # "character"
cat("class(is_student) =", class(is_student), "\n\n")  # "logical"

# typeof() gives more detailed type information
cat("typeof(x) =", typeof(x), "\n")         # "double"
cat("typeof(name) =", typeof(name), "\n\n") # "character"

# Integer type (requires L suffix)
count <- 10L
cat("count =", count, "(", class(count), ")\n\n")

# Complex numbers
complex_num <- 3 + 2i
cat("complex_num =", complex_num, "\n")
cat("class(complex_num) =", class(complex_num), "\n\n")

# ----------------------------------------------------------------------------
# 3. TYPE CHECKING
# ----------------------------------------------------------------------------

cat("Type checking functions:\n")
cat("is.numeric(x) =", is.numeric(x), "\n")
cat("is.character(name) =", is.character(name), "\n")
cat("is.logical(is_student) =", is.logical(is_student), "\n")
cat("is.integer(count) =", is.integer(count), "\n\n")

# ----------------------------------------------------------------------------
# 4. TYPE CONVERSION
# ----------------------------------------------------------------------------

# Convert between types
num_str <- "123"
num_val <- as.numeric(num_str)  # String to number

cat("Type conversion:\n")
cat("Original:", num_str, "(", class(num_str), ")\n")
cat("Converted:", num_val, "(", class(num_val), ")\n\n")

# Logical to numeric
log_num <- as.numeric(TRUE)   # TRUE becomes 1
log_num2 <- as.numeric(FALSE) # FALSE becomes 0
cat("TRUE as numeric:", log_num, "\n")
cat("FALSE as numeric:", log_num2, "\n\n")

# Number to character
num_char <- as.character(3.14)
cat("3.14 as character:", num_char, "\n\n")

# ----------------------------------------------------------------------------
# 5. SPECIAL VALUES
# ----------------------------------------------------------------------------

cat("Special values in R:\n")

# NA - Not Available (missing value)
missing_value <- NA
cat("Missing value: NA\n")

# NULL - Empty/undefined
empty_value <- NULL
cat("NULL value represents absence\n")

# Inf - Infinity
infinity <- Inf
cat("Infinity: 1/0 =", 1/0, "\n")

# NaN - Not a Number
not_a_number <- NaN
cat("NaN: 0/0 =", 0/0, "\n\n")

# ----------------------------------------------------------------------------
# 6. VARIABLE NAMING RULES
# ----------------------------------------------------------------------------

# Valid variable names:
my_var <- 10
myVar <- 20
my.var <- 30
MyVar2 <- 40

cat("Valid variable names:\n")
cat("my_var, myVar, my.var, MyVar2\n\n")

# Invalid names (uncomment to see errors):
# 2var <- 10      # Cannot start with number
# my-var <- 10    # Cannot use hyphen
# my var <- 10    # Cannot have spaces

# ----------------------------------------------------------------------------
# 7. PRINTING AND OUTPUT
# ----------------------------------------------------------------------------

cat("Different ways to print:\n")

# print() - basic printing
print(x)

# cat() - concatenate and print (no newline by default)
cat("The value of x is:", x, "\n")

# paste() - concatenate strings
result <- paste("x =", x, "and y =", y)
print(result)

# paste0() - concatenate without spaces
result2 <- paste0("x=", x, " y=", y)
print(result2)

# sprintf() - formatted printing
result3 <- sprintf("x = %.2f, y = %.4f", x, y)
print(result3)

cat("\n")

# ----------------------------------------------------------------------------
# EXERCISES
# ----------------------------------------------------------------------------

cat("=== EXERCISES ===\n")
cat("Try these exercises to practice:\n\n")
cat("1. Create variables for your name, age, and whether you're a student\n")
cat("2. Use class() to check the type of each variable\n")
cat("3. Convert your age to a character string\n")
cat("4. Create a message using paste() with your variables\n")
cat("5. Use sprintf() to format: 'My name is X and I am Y years old'\n\n")

# Example solutions (commented out - try yourself first!):
# my_name <- "XYZ"
# my_age <- N
# am_i_student <- TRUE
# age_str <- as.character(my_age)
# msg <- paste("Name is", my_name, "and age is", my_age)
# formatted_msg <- sprintf("Name is %s and age is %d", my_name, my_age)
