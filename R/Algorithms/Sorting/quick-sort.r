# ============================================================================
# R Algorithms: Quick Sort
# ============================================================================
# Time Complexity: O(n log n) average, O(n²) worst case
# Space Complexity: O(log n)

# ----------------------------------------------------------------------------
# Quick Sort Implementation
# ----------------------------------------------------------------------------

quick_sort <- function(arr) {
  if (length(arr) <= 1) {
    return(arr)
  }
  
  pivot <- arr[1]
  less <- arr[arr < pivot]
  equal <- arr[arr == pivot]
  greater <- arr[arr > pivot]
  
  return(c(quick_sort(less), equal, quick_sort(greater)))
}

# ----------------------------------------------------------------------------
# Alternative In-place Implementation
# ----------------------------------------------------------------------------

quick_sort_inplace <- function(arr, low = 1, high = length(arr)) {
  if (low < high) {
    pi <- partition(arr, low, high)
    arr <- quick_sort_inplace(arr, low, pi - 1)
    arr <- quick_sort_inplace(arr, pi + 1, high)
  }
  return(arr)
}

partition <- function(arr, low, high) {
  pivot <- arr[high]
  i <- low - 1
  
  for (j in low:(high - 1)) {
    if (arr[j] <= pivot) {
      i <- i + 1
      temp <- arr[i]
      arr[i] <- arr[j]
      arr[j] <- temp
    }
  }
  
  temp <- arr[i + 1]
  arr[i + 1] <- arr[high]
  arr[high] <- temp
  
  return(i + 1)
}

# ----------------------------------------------------------------------------
# Demonstration
# ----------------------------------------------------------------------------

# Random numbers
test1 <- c(64, 34, 25, 12, 22, 11, 90)
cat("Original:", test1, "\n")
cat("Sorted:", quick_sort(test1), "\n")

# Reverse sorted
test2 <- c(9, 8, 7, 6, 5, 4, 3, 2, 1)
cat("Original:", test2, "\n")
cat("Sorted:", quick_sort(test2), "\n")

# Already sorted
test3 <- c(1, 2, 3, 4, 5)
cat("Original:", test3, "\n")
cat("Sorted:", quick_sort(test3), "\n")

# Duplicates
test4 <- c(5, 2, 8, 2, 9, 1, 5, 5)
cat("Original:", test4, "\n")
cat("Sorted:", quick_sort(test4), "\n")

# Large random array
set.seed(42)
test5 <- sample(1:100, 20, replace = TRUE)
cat("Original:", test5, "\n")
cat("Sorted:", quick_sort(test5), "\n")

# Performance comparison
n <- 10000
large_array <- sample(1:n, n, replace = FALSE)

time_start <- Sys.time()
sorted_quick <- quick_sort(large_array)
time_quick <- Sys.time() - time_start

time_start <- Sys.time()
sorted_builtin <- sort(large_array)
time_builtin <- Sys.time() - time_start

cat(sprintf("Quick Sort (%d elements): %.4f seconds\n", n, time_quick))
cat(sprintf("Built-in sort (%d elements): %.4f seconds\n", n, time_builtin))
cat("Sorting correct:", all(sorted_quick == sorted_builtin), "\n")
