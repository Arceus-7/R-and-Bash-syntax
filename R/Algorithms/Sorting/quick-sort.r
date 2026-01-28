# ============================================================================
# R Algorithms: Quick Sort
# ============================================================================
# Quick Sort is an efficient, divide-and-conquer sorting algorithm
# Time Complexity: O(n log n) average, O(n²) worst case
# Space Complexity: O(log n)

# ----------------------------------------------------------------------------
# Quick Sort Implementation
# ----------------------------------------------------------------------------

quick_sort <- function(arr) {
  # Base case: arrays with 0 or 1 element are already sorted
  if (length(arr) <= 1) {
    return(arr)
  }
  
  # Choose pivot (first element)
  pivot <- arr[1]
  
  # Partition array into three parts:
  # - Elements less than pivot
  # - Elements equal to pivot
  # - Elements greater than pivot
  less <- arr[arr < pivot]
  equal <- arr[arr == pivot]
  greater <- arr[arr > pivot]
  
  # Recursively sort the less and greater partitions
  # and combine: sorted(less) + equal + sorted(greater)
  return(c(quick_sort(less), equal, quick_sort(greater)))
}

# ----------------------------------------------------------------------------
# Alternative Implementation (In-place partitioning)
# ----------------------------------------------------------------------------

quick_sort_inplace <- function(arr, low = 1, high = length(arr)) {
  if (low < high) {
    # Partition the array and get pivot index
    pi <- partition(arr, low, high)
    
    # Recursively sort elements before and after partition
    arr <- quick_sort_inplace(arr, low, pi - 1)
    arr <- quick_sort_inplace(arr, pi + 1, high)
  }
  return(arr)
}

partition <- function(arr, low, high) {
  # Choose rightmost element as pivot
  pivot <- arr[high]
  
  # Index of smaller element
  i <- low - 1
  
  # Traverse through all elements
  for (j in low:(high - 1)) {
    # If current element is smaller than pivot
    if (arr[j] <= pivot) {
      i <- i + 1
      # Swap arr[i] and arr[j]
      temp <- arr[i]
      arr[i] <- arr[j]
      arr[j] <- temp
    }
  }
  
  # Swap arr[i+1] and arr[high] (pivot)
  temp <- arr[i + 1]
  arr[i + 1] <- arr[high]
  arr[high] <- temp
  
  return(i + 1)
}

# ----------------------------------------------------------------------------
# Demonstration
# ----------------------------------------------------------------------------

cat("=== Quick Sort Demonstration ===\n\n")

# Test case 1: Random numbers
test1 <- c(64, 34, 25, 12, 22, 11, 90)
cat("Original array:", test1, "\n")
sorted1 <- quick_sort(test1)
cat("Sorted array:  ", sorted1, "\n\n")

# Test case 2: Reverse sorted
test2 <- c(9, 8, 7, 6, 5, 4, 3, 2, 1)
cat("Reverse sorted array:", test2, "\n")
sorted2 <- quick_sort(test2)
cat("Sorted array:        ", sorted2, "\n\n")

# Test case 3: Already sorted
test3 <- c(1, 2, 3, 4, 5)
cat("Already sorted array:", test3, "\n")
sorted3 <- quick_sort(test3)
cat("Sorted array:        ", sorted3, "\n\n")

# Test case 4: Duplicates
test4 <- c(5, 2, 8, 2, 9, 1, 5, 5)
cat("Array with duplicates:", test4, "\n")
sorted4 <- quick_sort(test4)
cat("Sorted array:         ", sorted4, "\n\n")

# Test case 5: Large random array
set.seed(42)  # For reproducibility
test5 <- sample(1:100, 20, replace = TRUE)
cat("Random array (20 elements):\n")
cat(test5, "\n")
sorted5 <- quick_sort(test5)
cat("Sorted array:\n")
cat(sorted5, "\n\n")

# ----------------------------------------------------------------------------
# Performance Comparison
# ----------------------------------------------------------------------------

cat("=== Performance Comparison ===\n\n")

# Generate large array for benchmarking
n <- 10000
large_array <- sample(1:n, n, replace = FALSE)

# Time quick_sort
time_start <- Sys.time()
sorted_quick <- quick_sort(large_array)
time_end <- Sys.time()
time_quick <- time_end - time_start

cat(sprintf("Quick Sort (%d elements): %.4f seconds\n", n, time_quick))

# Compare with built-in sort
time_start <- Sys.time()
sorted_builtin <- sort(large_array)
time_end <- Sys.time()
time_builtin <- time_end - time_start

cat(sprintf("Built-in sort (%d elements): %.4f seconds\n", n, time_builtin))

# Verify correctness
is_correct <- all(sorted_quick == sorted_builtin)
cat(sprintf("\nSorting correct: %s\n", is_correct))

cat("\n=== Algorithm Complete ===\n")
