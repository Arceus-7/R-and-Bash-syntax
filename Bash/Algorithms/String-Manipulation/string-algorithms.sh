#!/bin/bash

# ============================================================================
# String Manipulation: Algorithms
# ============================================================================
# Common string algorithms in Bash

echo "=== String Manipulation Algorithms ==="
echo

# ----------------------------------------------------------------------------
# 1. Reverse a String
# ----------------------------------------------------------------------------

reverse_string() {
    local str="$1"
    local reversed=""
    local len=${#str}
    
    for (( i=len-1; i>=0; i-- )); do
        reversed="${reversed}${str:$i:1}"
    done
    
    echo "$reversed"
}

echo "1. Reverse String:"
test_str="Hello, World!"
echo "Original: $test_str"
echo "Reversed: $(reverse_string "$test_str")"
echo

# ----------------------------------------------------------------------------
# 2. Check Palindrome
# ----------------------------------------------------------------------------

is_palindrome() {
    local str=$(echo "$1" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')
    local reversed=$(reverse_string "$str")
    
    if [[ "$str" == "$reversed" ]]; then
        echo "true"
    else
        echo "false"
    fi
}

echo "2. Palindrome Check:"
echo "racecar: $(is_palindrome "racecar")"
echo "hello: $(is_palindrome "hello")"
echo "A man a plan a canal Panama: $(is_palindrome "amanaplanacanalpanama")"
echo

# ----------------------------------------------------------------------------
# 3. Count Vowels
# ----------------------------------------------------------------------------

count_vowels() {
    local str=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    local count=0
    
    for (( i=0; i<${#str}; i++ )); do
        char="${str:$i:1}"
        if [[ "$char" =~ [aeiou] ]]; then
            ((count++))
        fi
    done
    
    echo "$count"
}

echo "3. Count Vowels:"
test_text="Hello World"
echo "Text: $test_text"
echo "Vowels: $(count_vowels "$test_text")"
echo

# ----------------------------------------------------------------------------
# 4. Find Longest Word
# ----------------------------------------------------------------------------

find_longest_word() {
    local text="$1"
    local longest=""
    
    for word in $text; do
        if (( ${#word} > ${#longest} )); then
            longest="$word"
        fi
    done
    
    echo "$longest"
}

echo "4. Find Longest Word:"
sentence="The quick brown fox jumps"
echo "Sentence: $sentence"
echo "Longest word: $(find_longest_word "$sentence")"
echo

# ----------------------------------------------------------------------------
# 5. Remove Duplicates
# ----------------------------------------------------------------------------

remove_duplicate_chars() {
    local str="$1"
    local result=""
    
    for (( i=0; i<${#str}; i++ )); do
        char="${str:$i:1}"
        if [[ "$result" != *"$char"* ]]; then
            result="${result}${char}"
        fi
    done
    
    echo "$result"
}

echo "5. Remove Duplicate Characters:"
dup_str="programming"
echo "Original: $dup_str"
echo "Without duplicates: $(remove_duplicate_chars "$dup_str")"
echo

# ----------------------------------------------------------------------------
# 6. String Compression (Run-Length Encoding)
# ----------------------------------------------------------------------------

compress_string() {
    local str="$1"
    local compressed=""
    local count=1
    
    for (( i=0; i<${#str}; i++ )); do
        current="${str:$i:1}"
        next="${str:$((i+1)):1}"
        
        if [[ "$current" == "$next" ]]; then
            ((count++))
        else
            compressed="${compressed}${current}${count}"
            count=1
        fi
    done
    
    echo "$compressed"
}

echo "6. String Compression:"
comp_str="aaabbbcccaaa"
echo "Original: $comp_str"
echo "Compressed: $(compress_string "$comp_str")"
echo

echo "=== Algorithms Complete ==="
