# ============================================================================
# R Basics: User Input
# ============================================================================
# Getting input from users in R

# ----------------------------------------------------------------------------
# 1. BASIC INPUT
# ----------------------------------------------------------------------------

# readline() - Read a line of text from user
name <- readline(prompt = "Enter your name: ")
cat("Hello,", name, "\n")

# Reading numeric input
age_str <- readline(prompt = "Enter your age: ")
age <- as.numeric(age_str)
cat("You are", age, "years old\n")

# ----------------------------------------------------------------------------
# 2. MULTIPLE INPUTS
# ----------------------------------------------------------------------------

# Reading multiple values
cat("Enter three numbers separated by spaces: ")
numbers_str <- readline()
numbers <- as.numeric(strsplit(numbers_str, " ")[[1]])
cat("You entered:", numbers, "\n")
cat("Sum:", sum(numbers), "\n")

# ----------------------------------------------------------------------------
# 3. INPUT WITH VALIDATION
# ----------------------------------------------------------------------------

# Function to get valid numeric input
get_number <- function(prompt) {
    repeat {
        input <- readline(prompt = prompt)
        num <- suppressWarnings(as.numeric(input))
        if (!is.na(num)) {
            return(num)
        }
        cat("Invalid input. Please enter a number.\n")
    }
}

# Usage (commented to avoid blocking)
# value <- get_number("Enter a number: ")
# cat("You entered:", value, "\n")

# ----------------------------------------------------------------------------
# 4. YES/NO INPUT
# ----------------------------------------------------------------------------

get_yes_no <- function(prompt) {
    repeat {
        response <- tolower(readline(prompt = prompt))
        if (response %in% c("y", "yes")) {
            return(TRUE)
        } else if (response %in% c("n", "no")) {
            return(FALSE)
        }
        cat("Please enter yes or no (y/n)\n")
    }
}

# Usage (commented to avoid blocking)
# answer <- get_yes_no("Do you want to continue? (y/n): ")
# if (answer) {
#   cat("Continuing...\n")
# } else {
#   cat("Stopping...\n")
# }

# ----------------------------------------------------------------------------
# 5. MENU SELECTION
# ----------------------------------------------------------------------------

display_menu <- function(options) {
    cat("\nSelect an option:\n")
    for (i in seq_along(options)) {
        cat(i, "-", options[i], "\n")
    }

    repeat {
        choice <- readline(prompt = "Enter choice: ")
        choice_num <- suppressWarnings(as.integer(choice))
        if (!is.na(choice_num) && choice_num >= 1 && choice_num <= length(options)) {
            return(choice_num)
        }
        cat("Invalid choice. Please select 1-", length(options), "\n")
    }
}

# Usage (commented to avoid blocking)
# menu_options <- c("Add", "Subtract", "Multiply", "Divide", "Exit")
# selection <- display_menu(menu_options)
# cat("You selected:", menu_options[selection], "\n")

# ----------------------------------------------------------------------------
# 6. READING FROM STDIN (Non-interactive)
# ----------------------------------------------------------------------------

# Read from standard input (useful for piping)
# data <- readLines("stdin", n = 1)

# Read multiple lines
# lines <- readLines("stdin", n = -1)  # -1 reads all lines

# ----------------------------------------------------------------------------
# 7. COMMAND LINE ARGUMENTS
# ----------------------------------------------------------------------------

# Get command line arguments
args <- commandArgs(trailingOnly = TRUE)

if (length(args) > 0) {
    cat("Command line arguments:\n")
    for (i in seq_along(args)) {
        cat(i, ":", args[i], "\n")
    }
} else {
    cat("No command line arguments provided\n")
}

# Example usage: Rscript user-input.r arg1 arg2 arg3

# ----------------------------------------------------------------------------
# 8. SCAN FUNCTION
# ----------------------------------------------------------------------------

# scan() can read various types of input
cat("Enter numbers (press Enter twice when done):\n")
# nums <- scan()
# cat("Sum:", sum(nums), "\n")

# Read specific number of values
cat("Enter 5 numbers:\n")
# five_nums <- scan(n = 5)

# Read character data
cat("Enter words:\n")
# words <- scan(what = character())

# ----------------------------------------------------------------------------
# 9. PRACTICAL EXAMPLE - CALCULATOR
# ----------------------------------------------------------------------------

simple_calculator <- function() {
    cat("\n=== Simple Calculator ===\n")

    num1 <- get_number("Enter first number: ")
    num2 <- get_number("Enter second number: ")

    operations <- c("Add (+)", "Subtract (-)", "Multiply (*)", "Divide (/)")
    choice <- display_menu(operations)

    result <- switch(choice,
        num1 + num2,
        num1 - num2,
        num1 * num2,
        if (num2 != 0) num1 / num2 else "Error: Division by zero"
    )

    cat("Result:", result, "\n")
}

# Uncomment to run calculator
# simple_calculator()

# ----------------------------------------------------------------------------
# 10. FILE INPUT
# ----------------------------------------------------------------------------

# Read file name from user
# filename <- readline(prompt = "Enter file name to read: ")
# if (file.exists(filename)) {
#   content <- readLines(filename)
#   cat("File contents:\n")
#   cat(content, sep = "\n")
# } else {
#   cat("File not found\n")
# }

cat("\n=== User Input Examples Complete ===\n")
cat("Note: Most examples are commented to avoid blocking execution\n")
cat("Uncomment the sections you want to test interactively\n")
