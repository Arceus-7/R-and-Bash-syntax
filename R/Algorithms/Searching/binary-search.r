# ============================================================================
# R Algorithms: Binary Search
# ============================================================================
# Binary Search is an efficient algorithm for finding an item in a sorted array
# Time Complexity: O(log n)
# Space Complexity: O(1) iterative, O(log n) recursive

# ----------------------------------------------------------------------------
# Recursive Implementation
# ----------------------------------------------------------------------------

binary_search_recursive <- function(arr, target, low = 1, high = length(arr)) {
  # Base case: element not found
  if (low > high) {
    return(-1)
  }
  
  # Find middle element
  mid <- floor((low + high) / 2)
  
  # Check if target is at mid
  if (arr[mid] == target) {
    return(mid)
  }
  
  # If target is smaller, search left half
  if (arr[mid] > target) {
    return(binary_search_recursive(arr, target, low, mid - 1))
  }
  
  # If target is larger, search right half
  return(binary_search_recursive(arr, target, mid + 1, high))
}

# ----------------------------------------------------------------------------
# Iterative Implementation
# ----------------------------------------------------------------------------

binary_search_iterative <- function(arr, target) {
  low <- 1
  high <- length(arr)
  
  while (low <= high) {
    mid <- floor((low + high) / 2)
    
    if (arr[mid] == target) {
      return(mid)
    } else if (arr[mid] > target) {
      high <- mid - 1
    } else {
      low <- mid + 1
    }
  }
  
  # Element not found
  return(-1)
}

# ----------------------------------------------------------------------------
# Find First/Last Occurrence
# ----------------------------------------------------------------------------

binary_search_first <- function(arr, target) {
  low <- 1
  high <- length(arr)
  result <- -1
  
  while (low <= high) {
    mid <- floor((low + high) / 2)
    
    if (arr[mid] == target) {
      result <- mid
      high <- mid - 1  # Continue searching in left half
    } else if (arr[mid] > target) {
      high <- mid - 1
    } else {
      low <- mid + 1
    }
  }
  
  return(result)
}

binary_search_last <- function(arr, target) {
  low <- 1
  high <- length(arr)
  result <- -1
  
  while (low <= high) {
    mid <- floor((low + high) / 2)
    
    if (arr[mid] == target) {
      result <- mid
      low <- mid + 1  # Continue searching in right half
    } else if (arr[mid] > target) {
      high <- mid - 1
    } else {
      low <- mid + 1
    }
  }
  
  return(result)
}

# ----------------------------------------------------------------------------
# Demonstration
# ----------------------------------------------------------------------------

cat("=== Binary Search Demonstration ===\n\n")

# Test case 1: Basic search
arr1 <- c(2, 5, 8, 12, 16, 23, 38, 45, 56, 67, 78)
target1 <- 23

cat("Array:", arr1, "\n")
cat("Target:", target1, "\n")

result_rec <- binary_search_recursive(arr1, target1)
result_iter <- binary_search_iterative(arr1, target1)

cat("Recursive result: Index =", result_rec, "\n")
cat("Iterative result: Index =", result_iter, "\n\n")

# Test case 2: Element not found
target2 <- 100
result2 <- binary_search_iterative(arr1, target2)
cat("Search for", target2, ": Index =", result2, "(not found)\n\n")

# Test case 3: First and last element
cat("First element (2): Index =", binary_search_iterative(arr1, 2), "\n")
cat("Last element (78): Index =", binary_search_iterative(arr1, 78), "\n\n")

# Test case 4: Duplicates
arr2 <- c(1, 2, 2, 2, 3, 4, 5, 5, 5, 6)
target3 <- 5

cat("Array with duplicates:", arr2, "\n")
cat("Target:", target3, "\n")
cat("First occurrence: Index =", binary_search_first(arr2, target3), "\n")
cat("Last occurrence: Index =", binary_search_last(arr2, target3), "\n")
cat("Any occurrence: Index =", binary_search_iterative(arr2, target3), "\n\n")

# Test case 5: Large array
set.seed(42)
large_arr <- sort(sample(1:10000, 1000))
target4 <- large_arr[500]

cat("Large array (1000 elements)\n")
cat("Searching for:", target4, "\n")

time_start <- Sys.time()
result4 <- binary_search_iterative(large_arr, target4)
time_end <- Sys.time()

cat("Found at index:", result4, "\n")
cat("Time taken:", format(time_end - time_start, scientific = FALSE), "\n\n")

# ----------------------------------------------------------------------------
# Comparison with Linear Search
# ----------------------------------------------------------------------------

linear_search <- function(arr, target) {
  for (i in 1:length(arr)) {
    if (arr[i] == target) {
      return(i)
    }
  }
  return(-1)
}

cat("=== Binary Search vs Linear Search ===\n\n")

n <- 100000
test_arr <- 1:n
target <- n - 100

# Binary search
time_start <- Sys.time()
binary_result <- binary_search_iterative(test_arr, target)
time_binary <- Sys.time() - time_start

# Linear search
time_start <- Sys.time()
linear_result <- linear_search(test_arr, target)
time_linear <- Sys.time() - time_start

cat(sprintf("Array size: %d elements\n", n))
cat(sprintf("Target: %d (near end)\n\n", target))
cat(sprintf("Binary Search: %.6f seconds\n", time_binary))
cat(sprintf("Linear Search: %.6f seconds\n", time_linear))
cat(sprintf("Speedup: %.0fx faster\n", time_linear / time_binary))

cat("\n=== Algorithm Complete ===\n")
