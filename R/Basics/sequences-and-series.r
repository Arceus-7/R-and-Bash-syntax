# ============================================================================
# R Basics: Sequences and Series
# ============================================================================
# Comprehensive guide to sequences and series in R

# ----------------------------------------------------------------------------
# 1. BASIC SEQUENCES
# ----------------------------------------------------------------------------

# Using colon operator
seq1 <- 1:10
cat(seq1, "\n")

# Reverse sequence
seq2 <- 10:1
cat(seq2, "\n")

# Using seq() function
seq3 <- seq(1, 10)
cat(seq3, "\n")

# Sequence with custom step (even numbers)
seq4 <- seq(0, 20, by = 2)
cat(seq4, "\n")

# Sequence with specified length
seq5 <- seq(0, 1, length.out = 11)
cat(seq5, "\n\n")

# ----------------------------------------------------------------------------
# 2. REPETITION
# ----------------------------------------------------------------------------

# Repeat single value
rep1 <- rep(5, times = 10)
cat(rep1, "\n")

# Repeat vector
rep2 <- rep(c(1, 2, 3), times = 3)
cat(rep2, "\n")

# Repeat each element
rep3 <- rep(c(1, 2, 3), each = 3)
cat(rep3, "\n")

# Variable repetition for each element
rep4 <- rep(1:3, times = c(4, 2, 3))
cat(rep4, "\n\n")

# ----------------------------------------------------------------------------
# 3. ARITHMETIC SEQUENCES
# ----------------------------------------------------------------------------

# Arithmetic sequence: a_n = a_1 + (n-1)d
arithmetic_sequence <- function(a1, d, n) {
  a1 + (0:(n-1)) * d
}

arith_seq <- arithmetic_sequence(a1 = 5, d = 3, n = 10)
cat(arith_seq, "\n")

# Sum of arithmetic sequence: S_n = n/2 * (2a_1 + (n-1)d)
arith_sum <- function(a1, d, n) {
  (n / 2) * (2 * a1 + (n - 1) * d)
}

sum_arith <- arith_sum(5, 3, 10)
cat("Sum:", sum_arith, "\n\n")

# ----------------------------------------------------------------------------
# 4. GEOMETRIC SEQUENCES
# ----------------------------------------------------------------------------

# Geometric sequence: a_n = a_1 * r^(n-1)
geometric_sequence <- function(a1, r, n) {
  a1 * r^(0:(n-1))
}

geom_seq <- geometric_sequence(a1 = 2, r = 3, n = 8)
cat(geom_seq, "\n")

# Sum of geometric sequence: S_n = a_1 * (1 - r^n) / (1 - r)
geom_sum <- function(a1, r, n) {
  if (r == 1) {
    return(a1 * n)
  }
  a1 * (1 - r^n) / (1 - r)
}

sum_geom <- geom_sum(2, 3, 8)
cat("Sum:", sum_geom, "\n\n")

# ----------------------------------------------------------------------------
# 5. HARMONIC SEQUENCE
# ----------------------------------------------------------------------------

# Harmonic sequence: 1, 1/2, 1/3, 1/4, ...
harmonic_sequence <- function(n) {
  1 / (1:n)
}

harm_seq <- harmonic_sequence(10)
cat(harm_seq, "\n")
cat("Sum:", sum(harm_seq), "\n\n")

# ----------------------------------------------------------------------------
# 6. FIBONACCI SEQUENCE
# ----------------------------------------------------------------------------

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
cat(fib_seq, "\n\n")

# ----------------------------------------------------------------------------
# 7. PRIME NUMBERS
# ----------------------------------------------------------------------------

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
cat(prime_seq, "\n\n")

# ----------------------------------------------------------------------------
# 8. FACTORIAL SEQUENCE
# ----------------------------------------------------------------------------

factorial_sequence <- function(n) {
  factorials <- numeric(n)
  for (i in 1:n) {
    factorials[i] <- factorial(i)
  }
  return(factorials)
}

fact_seq <- factorial_sequence(10)
cat(fact_seq, "\n\n")

# ----------------------------------------------------------------------------
# 9. POWER SEQUENCES
# ----------------------------------------------------------------------------

# Powers of 2
powers_of_2 <- 2^(0:10)
cat(powers_of_2, "\n")

# Sum formula: 2^0 + 2^1 + ... + 2^n = 2^(n+1) - 1
cat("Sum:", sum(powers_of_2), "\n\n")

# ----------------------------------------------------------------------------
# 10. TRIANGULAR NUMBERS
# ----------------------------------------------------------------------------

# T_n = n(n+1)/2
triangular_numbers <- function(n) {
  nums <- 1:n
  nums * (nums + 1) / 2
}

tri_seq <- triangular_numbers(10)
cat(tri_seq, "\n\n")

# ----------------------------------------------------------------------------
# 11. SQUARE AND CUBIC NUMBERS
# ----------------------------------------------------------------------------

squares <- (1:10)^2
cat("Squares:", squares, "\n")
cat("Sum:", sum(squares), "\n\n")

cubes <- (1:10)^3
cat("Cubes:", cubes, "\n")
cat("Sum:", sum(cubes), "\n\n")

# ----------------------------------------------------------------------------
# 12. CUMULATIVE OPERATIONS
# ----------------------------------------------------------------------------

nums <- 1:10
cat("Original:", nums, "\n")
cat("Cumulative sum:", cumsum(nums), "\n")
cat("Cumulative product:", cumprod(nums), "\n")
cat("Cumulative max:", cummax(nums), "\n")
cat("Cumulative min:", cummin(nums), "\n\n")

# ----------------------------------------------------------------------------
# 13. SERIES CONVERGENCE
# ----------------------------------------------------------------------------

# Approximate e: e = 1 + 1/1! + 1/2! + 1/3! + ...
approximate_e <- function(n) {
  sum(1 / factorial(0:n))
}

approx_e <- approximate_e(20)
cat("Approximation of e:", approx_e, "\n")
cat("Built-in e:", exp(1), "\n\n")

# Approximate π: π/4 = 1 - 1/3 + 1/5 - 1/7 + ...
approximate_pi <- function(n) {
  terms <- (-1)^(0:(n-1)) / (2 * (0:(n-1)) + 1)
  4 * sum(terms)
}

approx_pi <- approximate_pi(10000)
cat("Approximation of π:", approx_pi, "\n")
cat("Built-in π:", pi, "\n\n")

# ----------------------------------------------------------------------------
# 14. SEQUENCE MANIPULATION
# ----------------------------------------------------------------------------

seq_orig <- seq(10, 100, by = 10)
cat("Original:", seq_orig, "\n")
cat("Differences:", diff(seq_orig), "\n")
cat("Second-order differences:", diff(seq_orig, differences = 2), "\n\n")

# ----------------------------------------------------------------------------
# 15. COMPLEX PROBLEMS
# ----------------------------------------------------------------------------

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

result1 <- sum_even_fibonacci(1000)
cat("Even Fibonacci sum (up to 1000):", result1, "\n\n")

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

collatz_seq <- collatz_sequence(13)
cat("Collatz sequence (starting from 13):\n")
cat(collatz_seq, "\n")
cat("Length:", length(collatz_seq), "\n\n")

# Problem 3: Combined series
combined_series <- function(n) {
  arith <- (1:n)
  geom <- 2^(1:n)
  
  list(
    arithmetic_sum = sum(arith),
    geometric_sum = sum(geom),
    combined_sum = sum(arith + geom)
  )
}

result3 <- combined_series(10)
cat("Arithmetic sum:", result3$arithmetic_sum, "\n")
cat("Geometric sum:", result3$geometric_sum, "\n")
cat("Combined sum:", result3$combined_sum, "\n")
