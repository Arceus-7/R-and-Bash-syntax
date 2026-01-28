#!/bin/bash

# ============================================================================
# Bash Algorithm: Bubble Sort
# ============================================================================
# Bubble Sort implementation in Bash
# Time Complexity: O(n²)

echo "=== Bubble Sort in Bash ==="
echo

# ----------------------------------------------------------------------------
# Bubble Sort Function
# ----------------------------------------------------------------------------

bubble_sort() {
    local arr=("$@")
    local n=${#arr[@]}
    local swapped
    
    for ((i = 0; i < n-1; i++)); do
        swapped=0
        
        for ((j = 0; j < n-i-1; j++)); do
            # Compare adjacent elements
            if (( arr[j] > arr[j+1] )); then
                # Swap
                temp=${arr[j]}
                arr[j]=${arr[j+1]}
                arr[j+1]=$temp
                swapped=1
            fi
        done
        
        # If no swaps, array is sorted
        if (( swapped == 0 )); then
            break
        fi
    done
    
    # Return sorted array
    echo "${arr[@]}"
}

# ----------------------------------------------------------------------------
# Test Cases
# ----------------------------------------------------------------------------

echo "Test 1: Random numbers"
test1=(64 34 25 12 22 11 90)
echo "Original: ${test1[@]}"
sorted1=($(bubble_sort "${test1[@]}"))
echo "Sorted:   ${sorted1[@]}"
echo

echo "Test 2: Reverse sorted"
test2=(9 8 7 6 5 4 3 2 1)
echo "Original: ${test2[@]}"
sorted2=($(bubble_sort "${test2[@]}"))
echo "Sorted:   ${sorted2[@]}"
echo

echo "Test 3: Already sorted"
test3=(1 2 3 4 5)
echo "Original: ${test3[@]}"
sorted3=($(bubble_sort "${test3[@]}"))
echo "Sorted:   ${sorted3[@]}"
echo

echo "Test 4: With duplicates"
test4=(5 2 8 2 9 1 5 5)
echo "Original: ${test4[@]}"
sorted4=($(bubble_sort "${test4[@]}"))
echo "Sorted:   ${sorted4[@]}"
echo

echo "=== Algorithm Complete ==="
