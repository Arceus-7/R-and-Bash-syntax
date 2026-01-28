# ============================================================================
# R Algorithms: Fibonacci (Dynamic Programming)
# ============================================================================
# Calculate Fibonacci numbers using dynamic programming
# Time Complexity: O(n)
# Space Complexity: O(n)

# ----------------------------------------------------------------------------
# Recursive Implementation (Naive - Exponential Time)
# ----------------------------------------------------------------------------

fibonacci_recursive <- function(n) {
  # Base cases
  if (n <= 1) {
    return(n)
  }
  
  # Recursive call
  return(fibonacci_recursive(n - 1) + fibonacci_recursive(n - 2))
}

# ----------------------------------------------------------------------------
# Dynamic Programming Implementation (Memoization)
# ----------------------------------------------------------------------------

fibonacci_memoization <- function(n, memo = list()) {
  # Check if already computed
  if (n <= 1) {
    return(n)
  }
  
  # Check memo
  if (!is.null(memo[[as.character(n)]])) {
    return(memo[[as.character(n)]])
  }
  
  # Compute and store
  memo[[as.character(n)]] <- fibonacci_memoization(n - 1, memo) + 
                              fibonacci_memoization(n - 2, memo)
  
  return(memo[[as.character(n)]])
}

# ----------------------------------------------------------------------------
# Dynamic Programming Implementation (Tabulation)
# ----------------------------------------------------------------------------

fibonacci_tabulation <- function(n) {
  # Handle base cases
  if (n <= 1) {
    return(n)
  }
  
  # Create table
  fib <- numeric(n + 1)
  fib[1] <- 0
  fib[2] <- 1
  
  # Fill table bottom-up
  for (i in 3:(n + 1)) {
    fib[i] <- fib[i - 1] + fib[i - 2]
  }
  
  return(fib[n + 1])
}

# ----------------------------------------------------------------------------
# Space-Optimized Implementation
# ----------------------------------------------------------------------------

fibonacci_optimized <- function(n) {
  # Handle base cases
  if (n <= 1) {
    return(n)
  }
  
  # Use only two variables
  prev2 <- 0
  prev1 <- 1
  
  for (i in 2:n) {
    current <- prev1 + prev2
    prev2 <- prev1
    prev1 <- current
  }
  
  return(prev1)
}

# ----------------------------------------------------------------------------
# Demonstration
# ----------------------------------------------------------------------------

cat("=== Fibonacci Number Calculation ===\n\n")

# Test different approaches
n <- 15

cat(sprintf("Calculating Fibonacci(%d):\n\n", n))

# Recursive (only for small n)
if (n <= 20) {
  time_start <- Sys.time()
  result_rec <- fibonacci_recursive(n)
  time_rec <- Sys.time() - time_start
  cat(sprintf("Recursive: %d (Time: %.6f seconds)\n", result_rec, time_rec))
}

# Memoization
time_start <- Sys.time()
result_memo <- fibonacci_memoization(n)
time_memo <- Sys.time() - time_start
cat(sprintf("Memoization: %d (Time: %.6f seconds)\n", result_memo, time_memo))

# Tabulation
time_start <- Sys.time()
result_tab <- fibonacci_tabulation(n)
time_tab <- Sys.time() - time_start
cat(sprintf("Tabulation: %d (Time: %.6f seconds)\n", result_tab, time_tab))

# Optimized
time_start <- Sys.time()
result_opt <- fibonacci_optimized(n)
time_opt <- Sys.time() - time_start
cat(sprintf("Optimized: %d (Time: %.6f seconds)\n", result_opt, time_opt))

cat("\n")

# ----------------------------------------------------------------------------
# Generate Fibonacci Sequence
# ----------------------------------------------------------------------------

cat("=== Fibonacci Sequence ===\n\n")

generate_fibonacci_sequence <- function(count) {
  if (count <= 0) return(numeric(0))
  if (count == 1) return(c(0))
  
  sequence <- numeric(count)
  sequence[1] <- 0
  sequence[2] <- 1
  
  if (count > 2) {
    for (i in 3:count) {
      sequence[i] <- sequence[i - 1] + sequence[i - 2]
    }
  }
  
  return(sequence)
}

# Generate sequence
fib_seq <- generate_fibonacci_sequence(20)
cat("First 20 Fibonacci numbers:\n")
cat(fib_seq, "\n\n")

# ----------------------------------------------------------------------------
# Performance Comparison
# ----------------------------------------------------------------------------

cat("=== Performance Comparison (n=30) ===\n\n")

n_large <- 30

# Tabulation
time_start <- Sys.time()
result_tab <- fibonacci_tabulation(n_large)
time_tab <- Sys.time() - time_start

# Optimized
time_start <- Sys.time()
result_opt <- fibonacci_optimized(n_large)
time_opt <- Sys.time() - time_start

cat(sprintf("Tabulation: %.6f seconds\n", time_tab))
cat(sprintf("Optimized: %.6f seconds\n", time_opt))
cat(sprintf("Speedup: %.2fx\n", time_tab / time_opt))

cat("\n=== Algorithm Complete ===\n")
