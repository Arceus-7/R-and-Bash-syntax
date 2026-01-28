#!/bin/bash

# ============================================================================
# Bash Basics: Variables and Data Types
# ============================================================================
# This script covers fundamental Bash concepts including variables, strings,
# arrays, and basic operations.

echo "=== Bash Variables and Data Types ==="
echo

# ----------------------------------------------------------------------------
# 1. VARIABLES
# ----------------------------------------------------------------------------
# Variables are created without the $ symbol
# NO SPACES around the = sign!

# String variables
name="ABC XYZ"
greeting='Hello, World!'
message="Learning Bash"

echo "String variables:"
echo "name = $name"
echo "greeting = $greeting"
echo "message = $message"
echo

# Numeric variables (stored as strings)
age=NN
count=MMM
price=PP.PP

echo "Numeric variables:"
echo "age = $age"
echo "count = $count"
echo "price = $price"
echo

# ----------------------------------------------------------------------------
# 2. VARIABLE EXPANSION
# ----------------------------------------------------------------------------

echo "Variable expansion:"
echo "Simple: $name"
echo "With braces: ${name}"
echo "Concatenation: ${name} is ${age} years old"
echo

# ----------------------------------------------------------------------------
# 3. COMMAND SUBSTITUTION
# ----------------------------------------------------------------------------

# Capture command output in variables
current_date=$(date)
file_count=$(ls | wc -l)
current_dir=$(pwd)

echo "Command substitution:"
echo "Current date: $current_date"
echo "Files in directory: $file_count"
echo "Current directory: $current_dir"
echo

# Older syntax (backticks)
# user_name=`whoami`

# ----------------------------------------------------------------------------
# 4. ARITHMETIC OPERATIONS
# ----------------------------------------------------------------------------

x=10
y=5

# Arithmetic expansion
sum=$((x + y))
diff=$((x - y))
prod=$((x * y))
quot=$((x / y))
mod=$((x % y))

echo "Arithmetic operations:"
echo "$x + $y = $sum"
echo "$x - $y = $diff"
echo "$x * $y = $prod"
echo "$x / $y = $quot"
echo "$x % $y = $mod"
echo

# Increment/Decrement
counter=0
((counter++))
echo "After increment: $counter"
((counter--))
echo "After decrement: $counter"
echo

# ----------------------------------------------------------------------------
# 5. ARRAYS
# ----------------------------------------------------------------------------

# Create array
fruits=("apple" "banana" "orange" "grape")
numbers=(1 2 3 4 5)

echo "Arrays:"
echo "First fruit: ${fruits[0]}"
echo "Second fruit: ${fruits[1]}"
echo "All fruits: ${fruits[@]}"
echo "Number of fruits: ${#fruits[@]}"
echo

# Loop through array
echo "Looping through fruits:"
for fruit in "${fruits[@]}"; do
    echo "  - $fruit"
done
echo

# Add element to array
fruits+=("mango")
echo "After adding mango: ${fruits[@]}"
echo

# ----------------------------------------------------------------------------
# 6. STRING OPERATIONS
# ----------------------------------------------------------------------------

text="Hello, Bash Scripting!"

echo "String operations:"
echo "Original: $text"
echo "Length: ${#text}"
echo "Substring (0-5): ${text:0:5}"
echo "Substring (from 7): ${text:7}"
echo

# String replacement
echo "Replace first: ${text/Bash/Shell}"
echo "Replace all: ${text//a/A}"
echo

# Case conversion
echo "Uppercase: ${text^^}"
echo "Lowercase: ${text,,}"
echo

# ----------------------------------------------------------------------------
# 7. SPECIAL VARIABLES
# ----------------------------------------------------------------------------

echo "Special variables:"
echo "Script name: $0"
echo "Process ID: $$"
echo "Number of arguments: $#"
echo "All arguments: $@"
echo "Exit status of last command: $?"
echo

# ----------------------------------------------------------------------------
# 8. ENVIRONMENT VARIABLES
# ----------------------------------------------------------------------------

echo "Common environment variables:"
echo "USER: $USER"
echo "HOME: $HOME"
echo "PATH: $PATH"
echo "SHELL: $SHELL"
echo

# Export variable (make available to child processes)
export MY_VAR="accessible to child processes"

# ----------------------------------------------------------------------------
# 9. READ-ONLY VARIABLES
# ----------------------------------------------------------------------------

readonly PI=3.14159
echo "Read-only variable PI: $PI"

# Uncommenting the next line would cause an error:
# PI=3.14

echo

# ----------------------------------------------------------------------------
# 10. DEFAULT VALUES
# ----------------------------------------------------------------------------

# Use default if variable is unset
echo "Default values:"
echo "undefined_var: ${undefined_var:-default_value}"
echo "name with default: ${name:-Anonymous}"
echo

# Set default if unset
unset_var=${unset_var:=assigned_value}
echo "unset_var after assignment: $unset_var"
echo

# ----------------------------------------------------------------------------
# EXERCISES
# ----------------------------------------------------------------------------

echo "=== EXERCISES ==="
echo "Try these exercises:"
echo
echo "1. Create variables for your name, city, and favorite number"
echo "2. Use command substitution to store today's date"
echo "3. Create an array of your top 5 favorite foods"
echo "4. Perform arithmetic: calculate (your_age * 2) + 10"
echo "5. Concatenate strings to create a full sentence about yourself"
echo

# Example solutions (uncomment to try):
# my_name="ABC"
# my_city="XYZ City"
# fav_number=N
# today=$(date +%Y-%m-%d)
# foods=("item1" "item2" "item3" "item4" "item5")
# my_age=NN
# result=$((my_age * 2 + 10))
# sentence="${my_name} lives in ${my_city} and likes the number ${fav_number}"
