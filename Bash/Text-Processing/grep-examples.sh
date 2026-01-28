#!/bin/bash

# ============================================================================
# Text Processing: grep Examples
# ============================================================================
# This script demonstrates various grep commands for searching text

echo "=== grep Examples ==="
echo

# Create a sample file for demonstration
cat > sample.txt << 'EOF'
word1
word2
WORD1
word3
word4
word1 phrase
Word5
word6
NNN word1s
word7
EOF

echo "Sample file created: sample.txt"
echo "Contents:"
cat sample.txt
echo
echo "---"
echo

# ----------------------------------------------------------------------------
# Basic Search
# ----------------------------------------------------------------------------

echo "1. Basic search (case-sensitive):"
grep "word1" sample.txt
echo

echo "2. Case-insensitive search:"
grep -i "word1" sample.txt
echo

# ----------------------------------------------------------------------------
# Line Numbers and Count
# ----------------------------------------------------------------------------

echo "3. Show line numbers:"
grep -n "word" sample.txt
echo

echo "4. Count matches:"
count=$(grep -c "word1" sample.txt)
echo "Number of lines containing 'word1': $count"
echo

# ----------------------------------------------------------------------------
# Invert Match
# ----------------------------------------------------------------------------

echo "5. Invert match (lines NOT containing pattern):"
grep -v "word1" sample.txt
echo

# ----------------------------------------------------------------------------
# Regular Expressions
# ----------------------------------------------------------------------------

echo "6. Lines starting with 'w':"
grep "^w" sample.txt
echo

echo "7. Lines ending with 'd':"
grep "d$" sample.txt
echo

echo "8. Lines containing digits:"
grep "[0-9]" sample.txt
echo

echo "9. Extended regex (word1 OR word7):"
grep -E "word1|word7" sample.txt
echo

# ----------------------------------------------------------------------------
# Context Lines
# ----------------------------------------------------------------------------

echo "10. Show 1 line after match:"
grep -A 1 "word2" sample.txt
echo

echo "11. Show 1 line before match:"
grep -B 1 "word3" sample.txt
echo

echo "12. Show 1 line before and after:"
grep -C 1 "word4" sample.txt
echo

# ----------------------------------------------------------------------------
# Multiple Files
# ----------------------------------------------------------------------------

# Create another sample file
cat > sample2.txt << 'EOF'
word1 item
word4 item
word7 item
EOF

echo "13. Search in multiple files:"
grep "item" sample.txt sample2.txt
echo

echo "14. Show only filenames with matches:"
grep -l "item" sample.txt sample2.txt
echo

# ----------------------------------------------------------------------------
# Word Boundaries
# ----------------------------------------------------------------------------

echo "15. Match whole word only:"
grep -w "word1" sample.txt
echo

# ----------------------------------------------------------------------------
# Cleanup
# ----------------------------------------------------------------------------

rm -f sample.txt sample2.txt
echo "Sample files cleaned up"
echo
echo "=== Examples Complete ==="
