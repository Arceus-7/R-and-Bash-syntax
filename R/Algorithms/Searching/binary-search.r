# ============================================================================
# R Algorithms: Binary Search
# ============================================================================
# Time Complexity: O(log n)
# Space Complexity: O(1) iterative, O(log n) recursive

# ----------------------------------------------------------------------------
# Recursive Implementation
# ----------------------------------------------------------------------------

binary_search_recursive <- function(arr, target, low = 1, high = length(arr)) {
  if (low > high) {
    return(-1)
  }

  mid <- floor((low + high) / 2)

  if (arr[mid] == target) {
    return(mid)
  }

  if (arr[mid] > target) {
    return(binary_search_recursive(arr, target, low, mid - 1))
  }

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
      high <- mid - 1 # Continue searching left
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
      low <- mid + 1 # Continue searching right
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

# Basic search
arr1 <- c(2, 5, 8, 12, 16, 23, 38, 45, 56, 67, 78)
target1 <- 23
cat("Array:", arr1, "\n")
cat("Target:", target1, "\n")
result_rec <- binary_search_recursive(arr1, target1)
result_iter <- binary_search_iterative(arr1, target1)
cat("Recursive index:", result_rec, "\n")
cat("Iterative index:", result_iter, "\n")

# Element not found
target2 <- 100
result2 <- binary_search_iterative(arr1, target2)
cat("Search for", target2, ":", result2, "\n")

# Duplicates
arr2 <- c(1, 2, 2, 2, 3, 4, 5, 5, 5, 6)
target3 <- 5
cat("Array with duplicates:", arr2, "\n")
cat("First occurrence:", binary_search_first(arr2, target3), "\n")
cat("Last occurrence:", binary_search_last(arr2, target3), "\n")

# Large array performance
set.seed(42)
large_arr <- sort(sample(1:10000, 1000))
target4 <- large_arr[500]
time_start <- Sys.time()
result4 <- binary_search_iterative(large_arr, target4)
time_end <- Sys.time()
cat("Found at index:", result4, "Time:", format(time_end - time_start, scientific = FALSE), "\n")

# Comparison with linear search
linear_search <- function(arr, target) {
  for (i in seq_along(arr)) {
    if (arr[i] == target) {
      return(i)
    }
  }
  return(-1)
}

n <- 100000
test_arr <- 1:n
target <- n - 100

time_start <- Sys.time()
binary_result <- binary_search_iterative(test_arr, target)
time_binary <- Sys.time() - time_start

time_start <- Sys.time()
linear_result <- linear_search(test_arr, target)
time_linear <- Sys.time() - time_start

cat(sprintf("Array size: %d\n", n))
cat(sprintf("Binary search: %.6f seconds\n", time_binary))
cat(sprintf("Linear search: %.6f seconds\n", time_linear))
cat(sprintf("Speedup: %.0fx\n", time_linear / time_binary))
