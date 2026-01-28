#!/bin/bash

# ============================================================================
# File Operations: Batch File Renamer
# ============================================================================
# This script demonstrates batch file operations

echo "=== Batch File Renamer ==="
echo

# Create test directory
TEST_DIR="test_files"
mkdir -p "$TEST_DIR"

echo "Creating test files..."

# Create sample files
for i in {1..10}; do
    touch "$TEST_DIR/file_$i.txt"
done

echo "Created 10 test files"
ls -1 "$TEST_DIR"
echo

# ----------------------------------------------------------------------------
# Rename files (add prefix)
# ----------------------------------------------------------------------------

echo "Adding prefix 'doc_' to all files..."

for file in "$TEST_DIR"/*.txt; do
    # Get directory and filename
    dir=$(dirname "$file")
    filename=$(basename "$file")
    
    # Rename with prefix
    mv "$file" "$dir/doc_$filename"
done

ls -1 "$TEST_DIR"
echo

# ----------------------------------------------------------------------------
# Change file extension
# ----------------------------------------------------------------------------

echo "Changing extension .txt to .md..."

for file in "$TEST_DIR"/*.txt; do
    # Get filename without extension
    base="${file%.txt}"
    
    # Rename with new extension
    mv "$file" "${base}.md"
done

ls -1 "$TEST_DIR"
echo

# ----------------------------------------------------------------------------
# Cleanup
# ----------------------------------------------------------------------------

echo "Cleaning up..."
rm -rf "$TEST_DIR"
echo "Test directory removed"

echo
echo "=== Script Complete ==="
echo
echo "Common file operations:"
echo "  mv file newname           - Rename file"
echo "  cp file1 file2            - Copy file"
echo "  cp -r dir1 dir2           - Copy directory"
echo "  find . -name '*.txt'      - Find files"
echo "  rename 's/old/new/' *     - Batch rename (if rename command available)"
