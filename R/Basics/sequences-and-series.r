# ============================================================================
# R Basics: Sequences and Series
# ============================================================================
# Comprehensive guide to sequences and series in R

cat("=== Sequences and Series in R ===\n\n")

# ----------------------------------------------------------------------------
# 1. BASIC SEQUENCES
# ----------------------------------------------------------------------------

cat("1. Basic Sequences:\n")

# Using colon operator
seq1 <- 1:10
cat("Using colon (1:10):", seq1, "\n")

# Reverse sequence
seq2 <- 10:1
cat("Reverse (10:1):", seq2, "\n")

# Using seq() function
seq3 <- seq(1, 10)
cat("Using seq(1, 10):", seq3, "\n")

# Sequence with custom step
seq4 <- seq(0, 20, by = 2)
cat("Even numbers (0 to 20):", seq4, "\n")

# Sequence with length
seq5 <- seq(0, 1, length.out = 11)
cat("11 points from 0 to 1:", seq5, "\n\n")

# ----------------------------------------------------------------------------
# 2. REPETITION
# ----------------------------------------------------------------------------

cat("2. Repetition:\n")

# Repeat single value
rep1 <- rep(5, times = 10)
cat("Repeat 5 ten times:", rep1, "\n")

# Repeat vector
rep2 <- rep(c(1, 2, 3), times = 3)
cat("Repeat vector 3 times:", rep2, "\n")

# Repeat each element
rep3 <- rep(c(1, 2, 3), each = 3)
cat("Repeat each element 3 times:", rep3, "\n")

# Complex repetition
rep4 <- rep(1:3, times = c(4, 2, 3))
cat("Variable repetition:", rep4, "\n\n")

# ----------------------------------------------------------------------------
# 3. ARITHMETIC SEQUENCES
# ----------------------------------------------------------------------------

cat("3. Arithmetic Sequences:\n")

# Arithmetic sequence: a_n = a_1 + (n-1)d
arithmetic_sequence <- function(a1, d, n) {
  a1 + (0:(n-1)) * d
}

arith_seq <- arithmetic_sequence(a1 = 5, d = 3, n = 10)
cat("Arithmetic sequence (a1=5, d=3, n=10):\n")
cat(arith_seq, "\n")

# Sum of arithmetic sequence: S_n = n/2 * (2a_1 + (n-1)d)
arith_sum <- function(a1, d, n) {
  (n / 2) * (2 * a1 + (n - 1) * d)
}

sum_arith <- arith_sum(5, 3, 10)
cat("Sum of sequence:", sum_arith, "\n")
cat("Verification:", sum(arith_seq), "\n\n")

# ----------------------------------------------------------------------------
# 4. GEOMETRIC SEQUENCES
# ----------------------------------------------------------------------------

cat("4. Geometric Sequences:\n")

# Geometric sequence: a_n = a_1 * r^(n-1)
geometric_sequence <- function(a1, r, n) {
  a1 * r^(0:(n-1))
}

geom_seq <- geometric_sequence(a1 = 2, r = 3, n = 8)
cat("Geometric sequence (a1=2, r=3, n=8):\n")
cat(geom_seq, "\n")

# Sum of geometric sequence: S_n = a_1 * (1 - r^n) / (1 - r)
geom_sum <- function(a1, r, n) {
  if (r == 1) {
    return(a1 * n)
  }
  a1 * (1 - r^n) / (1 - r)
}

sum_geom <- geom_sum(2, 3, 8)
cat("Sum of sequence:", sum_geom, "\n")
cat("Verification:", sum(geom_seq), "\n\n")

# ----------------------------------------------------------------------------
# 5. HARMONIC SEQUENCE
# ----------------------------------------------------------------------------

cat("5. Harmonic Sequence:\n")

# Harmonic sequence: 1, 1/2, 1/3, 1/4, ...
harmonic_sequence <- function(n) {
  1 / (1:n)
}

harm_seq <- harmonic_sequence(10)
cat("First 10 terms of harmonic sequence:\n")
cat(harm_seq, "\n")
cat("Sum (partial harmonic series):", sum(harm_seq), "\n\n")

# ----------------------------------------------------------------------------
# 6. FIBONACCI SEQUENCE
# ----------------------------------------------------------------------------

cat("6. Fibonacci Sequence:\n")

fibonacci_sequence <- function(n) {
  if (n <= 0) return(numeric(0))
  if (n == 1) return(c(0))
  
  fib <- numeric(n)
  fib[1] <- 0
  fib[2] <- 1
  
  if (n > 2) {
    for (i in 3:n) {
      fib[i] <- fib[i-1] + fib[i-2]
    }
  }
  
  return(fib)
}

fib_seq <- fibonacci_sequence(15)
cat("First 15 Fibonacci numbers:\n")
cat(fib_seq, "\n\n")

# ----------------------------------------------------------------------------
# 7. PRIME NUMBERS
# ----------------------------------------------------------------------------

cat("7. Prime Numbers:\n")

is_prime <- function(n) {
  if (n <= 1) return(FALSE)
  if (n <= 3) return(TRUE)
  if (n %% 2 == 0 || n %% 3 == 0) return(FALSE)
  
  i <- 5
  while (i * i <= n) {
    if (n %% i == 0 || n %% (i + 2) == 0) {
      return(FALSE)
    }
    i <- i + 6
  }
  return(TRUE)
}

primes_up_to <- function(n) {
  primes <- c()
  for (i in 2:n) {
    if (is_prime(i)) {
      primes <- c(primes, i)
    }
  }
  return(primes)
}

prime_seq <- primes_up_to(50)
cat("Prime numbers up to 50:\n")
cat(prime_seq, "\n\n")

# ----------------------------------------------------------------------------
# 8. FACTORIAL SEQUENCE
# ----------------------------------------------------------------------------

cat("8. Factorial Sequence:\n")

factorial_sequence <- function(n) {
  factorials <- numeric(n)
  for (i in 1:n) {
    factorials[i] <- factorial(i)
  }
  return(factorials)
}

fact_seq <- factorial_sequence(10)
cat("First 10 factorials:\n")
cat(fact_seq, "\n\n")

# ----------------------------------------------------------------------------
# 9. POWER SEQUENCES
# ----------------------------------------------------------------------------

cat("9. Power Sequences:\n")

# Powers of 2
powers_of_2 <- 2^(0:10)
cat("Powers of 2 (2^0 to 2^10):\n")
cat(powers_of_2, "\n")

# Sum of powers (2^0 + 2^1 + ... + 2^n = 2^(n+1) - 1)
cat("Sum:", sum(powers_of_2), "\n")
cat("Formula verification (2^11 - 1):", 2^11 - 1, "\n\n")

# ----------------------------------------------------------------------------
# 10. TRIANGULAR NUMBERS
# ----------------------------------------------------------------------------

cat("10. Triangular Numbers:\n")

# T_n = n(n+1)/2
triangular_numbers <- function(n) {
  nums <- 1:n
  nums * (nums + 1) / 2
}

tri_seq <- triangular_numbers(10)
cat("First 10 triangular numbers:\n")
cat(tri_seq, "\n\n")

# ----------------------------------------------------------------------------
# 11. SQUARE AND CUBIC NUMBERS
# ----------------------------------------------------------------------------

cat("11. Square and Cubic Numbers:\n")

squares <- (1:10)^2
cat("Squares (1^2 to 10^2):", squares, "\n")
cat("Sum of first 10 squares:", sum(squares), "\n")
cat("Formula n(n+1)(2n+1)/6:", 10*11*21/6, "\n\n")

cubes <- (1:10)^3
cat("Cubes (1^3 to 10^3):", cubes, "\n")
cat("Sum of first 10 cubes:", sum(cubes), "\n")
cat("Formula [n(n+1)/2]^2:", (10*11/2)^2, "\n\n")

# ----------------------------------------------------------------------------
# 12. CUMULATIVE OPERATIONS
# ----------------------------------------------------------------------------

cat("12. Cumulative Operations:\n")

nums <- 1:10

# Cumulative sum
cat("Original sequence:", nums, "\n")
cat("Cumulative sum:", cumsum(nums), "\n")

# Cumulative product
cat("Cumulative product:", cumprod(nums), "\n")

# Cumulative min and max
cat("Cumulative max:", cummax(nums), "\n")
cat("Cumulative min:", cummin(nums), "\n\n")

# ----------------------------------------------------------------------------
# 13. SERIES CONVERGENCE
# ----------------------------------------------------------------------------

cat("13. Series Convergence:\n")

# Infinite series approximation
# e = 1 + 1/1! + 1/2! + 1/3! + ...
approximate_e <- function(n) {
  sum(1 / factorial(0:n))
}

approx_e <- approximate_e(20)
cat("Approximation of e (20 terms):", approx_e, "\n")
cat("Built-in e:", exp(1), "\n")
cat("Difference:", abs(approx_e - exp(1)), "\n\n")

# π/4 = 1 - 1/3 + 1/5 - 1/7 + ...
approximate_pi <- function(n) {
  terms <- (-1)^(0:(n-1)) / (2 * (0:(n-1)) + 1)
  4 * sum(terms)
}

approx_pi <- approximate_pi(10000)
cat("Approximation of π (10000 terms):", approx_pi, "\n")
cat("Built-in π:", pi, "\n")
cat("Difference:", abs(approx_pi - pi), "\n\n")

# ----------------------------------------------------------------------------
# 14. SEQUENCE MANIPULATION
# ----------------------------------------------------------------------------

cat("14. Sequence Manipulation:\n")

seq_orig <- seq(10, 100, by = 10)
cat("Original sequence:", seq_orig, "\n")

# Difference between consecutive elements
diffs <- diff(seq_orig)
cat("Differences:", diffs, "\n")

# Running differences of order 2
diffs2 <- diff(seq_orig, differences = 2)
cat("Second-order differences:", diffs2, "\n\n")

# ----------------------------------------------------------------------------
# 15. COMPLEX PROBLEMS
# ----------------------------------------------------------------------------

cat("15. Complex Problems:\n\n")

# Problem 1: Sum of even Fibonacci numbers up to limit
sum_even_fibonacci <- function(limit) {
  fib <- c(0, 1)
  total <- 0
  
  while (TRUE) {
    next_fib <- fib[length(fib)] + fib[length(fib) - 1]
    if (next_fib > limit) break
    
    if (next_fib %% 2 == 0) {
      total <- total + next_fib
    }
    
    fib <- c(fib, next_fib)
  }
  
  return(total)
}

cat("Problem 1: Sum of even Fibonacci numbers up to 1000\n")
cat("Result:", sum_even_fibonacci(1000), "\n\n")

# Problem 2: Collatz sequence
collatz_sequence <- function(n) {
  sequence <- n
  
  while (n != 1) {
    if (n %% 2 == 0) {
      n <- n / 2
    } else {
      n <- 3 * n + 1
    }
    sequence <- c(sequence, n)
  }
  
  return(sequence)
}

cat("Problem 2: Collatz sequence starting from 13\n")
collatz_seq <- collatz_sequence(13)
cat("Sequence:", collatz_seq, "\n")
cat("Length:", length(collatz_seq), "\n\n")

# Problem 3: Sum of arithmetic and geometric means
combined_series <- function(n) {
  arith <- (1:n)
  geom <- 2^(1:n)
  
  list(
    arithmetic_sum = sum(arith),
    geometric_sum = sum(geom),
    combined_sum = sum(arith + geom)
  )
}

cat("Problem 3: Combined series (n=10)\n")
result <- combined_series(10)
cat("Arithmetic sum:", result$arithmetic_sum, "\n")
cat("Geometric sum:", result$geometric_sum, "\n")
cat("Combined sum:", result$combined_sum, "\n\n")

cat("=== Complete ===\n")
