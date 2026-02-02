# ============================================================================
# R Data Structures: Character Strings
# ============================================================================
# Working with text data in R

# ----------------------------------------------------------------------------
# 1. CREATING STRINGS
# ----------------------------------------------------------------------------

# Basic strings
str1 <- "Hello"
str2 <- "World"
cat(str1, str2, "\n")

# Multi-word string
sentence <- "This is a sentence"
cat(sentence, "\n")

# Strings with special characters
quote <- "He said, \"Hello!\""
cat(quote, "\n")

# String with newline
multi_line <- "Line 1\nLine 2\nLine 3"
cat(multi_line, "\n")

# ----------------------------------------------------------------------------
# 2. STRING CONCATENATION
# ----------------------------------------------------------------------------

# Using paste()
first <- "ABC"
last <- "XYZ"
full_name <- paste(first, last)
cat(full_name, "\n")

# paste with custom separator
date_str <- paste("2024", "01", "15", sep = "-")
cat(date_str, "\n")

# paste0 - no separator
email <- paste0("user", "@", "example.com")
cat(email, "\n")

# Concatenate vector elements
words <- c("R", "is", "awesome")
sentence <- paste(words, collapse = " ")
cat(sentence, "\n")

# Multiple vectors
names <- c("A", "B", "C")
ages <- c(25, 30, 35)
info <- paste(names, "is", ages, "years old")
cat(info, "\n")

# ----------------------------------------------------------------------------
# 3. STRING LENGTH
# ----------------------------------------------------------------------------

# nchar - number of characters
text <- "Hello World"
cat("Length:", nchar(text), "\n")

# Length of vector of strings
strings <- c("apple", "banana", "cherry")
lengths <- nchar(strings)
cat("Lengths:", lengths, "\n")

# ----------------------------------------------------------------------------
# 4. SUBSTRING EXTRACTION
# ----------------------------------------------------------------------------

# substr - extract substring
text <- "Programming"
sub1 <- substr(text, 1, 4)
cat("First 4 chars:", sub1, "\n")

sub2 <- substr(text, 8, 11)
cat("Chars 8-11:", sub2, "\n")

# substring - similar to substr
sub3 <- substring(text, 5)
cat("From char 5:", sub3, "\n")

# Extract from vector
words <- c("apple", "banana", "cherry")
first_three <- substr(words, 1, 3)
cat("First 3 chars:", first_three, "\n")

# ----------------------------------------------------------------------------
# 5. CASE CONVERSION
# ----------------------------------------------------------------------------

text <- "Hello World"

# To uppercase
upper <- toupper(text)
cat("Upper:", upper, "\n")

# To lowercase
lower <- tolower(text)
cat("Lower:", lower, "\n")

# Title case (capitalize first letter)
words <- c("hello", "world", "from", "r")
title_case <- paste(toupper(substring(words, 1, 1)),
    substring(words, 2),
    sep = ""
)
cat("Title case:", paste(title_case, collapse = " "), "\n")

# ----------------------------------------------------------------------------
# 6. STRING SPLITTING
# ----------------------------------------------------------------------------

# strsplit - split string
sentence <- "R is a great language"
words <- strsplit(sentence, " ")
print(words)

# Split and unlist
words_vec <- unlist(strsplit(sentence, " "))
cat("Words:", words_vec, "\n")

# Split by multiple delimiters
text <- "apple,banana;cherry:date"
fruits <- unlist(strsplit(text, "[,;:]"))
cat("Fruits:", fruits, "\n")

# Split CSV line
csv_line <- "ABC,25,Engineer,50000"
fields <- unlist(strsplit(csv_line, ","))
cat("Fields:", fields, "\n")

# ----------------------------------------------------------------------------
# 7. STRING SEARCHING
# ----------------------------------------------------------------------------

# grep - find pattern
fruits <- c("apple", "banana", "apricot", "cherry", "avocado")

# Find indices
indices <- grep("^a", fruits)
cat("Fruits starting with 'a' (indices):", indices, "\n")

# Find values
matches <- grep("^a", fruits, value = TRUE)
cat("Fruits starting with 'a':", matches, "\n")

# grepl - logical vector
contains_a <- grepl("a", fruits)
cat("Contains 'a':", contains_a, "\n")

# Find exact match
exact <- grep("^apple$", fruits, value = TRUE)
cat("Exact match:", exact, "\n")

# ----------------------------------------------------------------------------
# 8. STRING REPLACEMENT
# ----------------------------------------------------------------------------

text <- "Hello World"

# sub - replace first occurrence
new_text <- sub("o", "0", text)
cat("Replace first 'o':", new_text, "\n")

# gsub - replace all occurrences
new_text2 <- gsub("o", "0", text)
cat("Replace all 'o':", new_text2, "\n")

# Remove spaces
no_spaces <- gsub(" ", "", text)
cat("No spaces:", no_spaces, "\n")

# Replace multiple patterns
text2 <- "The price is $100"
cleaned <- gsub("[$]", "", text2)
cat("Cleaned:", cleaned, "\n")

# ----------------------------------------------------------------------------
# 9. PATTERN MATCHING (REGEX)
# ----------------------------------------------------------------------------

# Match digits
text <- "Age: 25, Score: 95"
numbers <- regmatches(text, gregexpr("[0-9]+", text))
cat("Numbers:", unlist(numbers), "\n")

# Match words
sentence <- "R is awesome!"
words <- regmatches(sentence, gregexpr("[A-Za-z]+", sentence))
cat("Words:", unlist(words), "\n")

# Check if string matches pattern
email <- "user@example.com"
is_email <- grepl("@", email)
cat("Contains @:", is_email, "\n")

# ----------------------------------------------------------------------------
# 10. STRING TRIMMING
# ----------------------------------------------------------------------------

# Remove leading/trailing whitespace
text <- "  Hello World  "
trimmed <- trimws(text)
cat("Original: '", text, "'\n", sep = "")
cat("Trimmed: '", trimmed, "'\n", sep = "")

# Remove leading whitespace only
left_trimmed <- trimws(text, which = "left")
cat("Left trimmed: '", left_trimmed, "'\n", sep = "")

# Remove trailing whitespace only
right_trimmed <- trimws(text, which = "right")
cat("Right trimmed: '", right_trimmed, "'\n", sep = "")

# ----------------------------------------------------------------------------
# 11. FORMATTED STRINGS
# ----------------------------------------------------------------------------

# sprintf - C-style formatting
name <- "ABC"
age <- 25
formatted <- sprintf("Name: %s, Age: %d", name, age)
cat(formatted, "\n")

# Format numbers
value <- 3.14159
formatted_num <- sprintf("%.2f", value)
cat("Formatted:", formatted_num, "\n")

# Multiple values
sprintf("%s is %d years old and earns $%.2f", "ABC", 25, 50000.50)

# Padded numbers
sprintf("%05d", 42) # Output: 00042

# ----------------------------------------------------------------------------
# 12. STRING COMPARISON
# ----------------------------------------------------------------------------

str1 <- "apple"
str2 <- "banana"

# Exact comparison
cat("Equal:", str1 == str2, "\n")
cat("Not equal:", str1 != str2, "\n")

# Lexicographic comparison
cat("Less than:", str1 < str2, "\n")
cat("Greater than:", str1 > str2, "\n")

# Case-insensitive comparison
upper_str <- "APPLE"
cat("Case-insensitive equal:", tolower(str1) == tolower(upper_str), "\n")

# ----------------------------------------------------------------------------
# 13. CHARACTER<CHARSETS AND ENCODING
# ----------------------------------------------------------------------------

# Check character type
cat("Is letter:", grepl("[A-Za-z]", "abc"), "\n")
cat("Is digit:", grepl("[0-9]", "123"), "\n")
cat("Is alphanumeric:", grepl("^[A-Za-z0-9]+$", "abc123"), "\n")

# ----------------------------------------------------------------------------
# 14. PRACTICAL EXAMPLES
# ----------------------------------------------------------------------------

# Example 1: Parse full name
full_name <- "ABC XYZ"
parts <- unlist(strsplit(full_name, " "))
first_name <- parts[1]
last_name <- parts[2]
cat("First:", first_name, "Last:", last_name, "\n")

# Example 2: Email validation (basic)
validate_email <- function(email) {
    grepl("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$", email)
}
cat("Valid email:", validate_email("user@example.com"), "\n")
cat("Invalid email:", validate_email("invalid-email"), "\n")

# Example 3: Clean data
messy_data <- c("  apple  ", "BANANA", "Cherry  ", "  DATE")
clean_data <- tolower(trimws(messy_data))
cat("Cleaned:", clean_data, "\n")

# Example 4: Extract numbers from text
text <- "I have 5 apples and 10 oranges"
numbers <- as.numeric(unlist(regmatches(text, gregexpr("[0-9]+", text))))
cat("Numbers:", numbers, "\n")
cat("Total:", sum(numbers), "\n")

# Example 5: Build file path
folder <- "data"
filename <- "results.csv"
filepath <- paste(folder, filename, sep = "/")
cat("File path:", filepath, "\n")

# Example 6: Create acronym
phrase <- "Analysis Of Variance"
words <- unlist(strsplit(phrase, " "))
acronym <- paste(substr(words, 1, 1), collapse = "")
cat("Acronym:", acronym, "\n")

# Example 7: Mask sensitive data
credit_card <- "1234-5678-9012-3456"
masked <- gsub("[0-9]", "*", substr(credit_card, 1, nchar(credit_card) - 4))
masked <- paste0(masked, substr(credit_card, nchar(credit_card) - 3, nchar(credit_card)))
cat("Masked:", masked, "\n")

# Example 8: Count word frequency
text <- "apple banana apple cherry banana apple"
words <- unlist(strsplit(text, " "))
word_counts <- table(words)
print(word_counts)

# Example 9: Reverse string
reverse_string <- function(str) {
    paste(rev(strsplit(str, "")[[1]]), collapse = "")
}
cat("Reversed:", reverse_string("hello"), "\n")

# Example 10: Check palindrome
is_palindrome <- function(str) {
    str <- tolower(gsub("[^A-Za-z]", "", str))
    str == reverse_string(str)
}
cat("Is palindrome (radar):", is_palindrome("radar"), "\n")
cat("Is palindrome (hello):", is_palindrome("hello"), "\n")
