# ============================================================================
# R Loops and Conditionals
# ============================================================================
# If/else, for, while loops with examples

cat("\n========== IF-ELSE STATEMENTS ==========\n")

# Basic if-else
x <- rnorm(1) # random normal number
cat("x =", x, "\n")

if (x > 0) {
    y <- x + 5
    z <- x + 100
} else {
    y <- x + 1
    z <- x - 6
}
cat("y =", y, "\nz =", z, "\n")

# Multiple conditions with OR
x_1 <- rnorm(1)
cat("\nx_1 =", x_1, "\n")

if (x_1 > 1 | x_1 < (-1)) { # | is OR operator
    y <- x_1 + 5
    z <- x_1 - 5
} else {
    y <- x_1 + 100
    z <- x_1 + 100
}
cat("y =", y, "\nz =", z, "\n")

# Nested if-else
f <- function(x) {
    if (x > 30) {
        y <- x + 100
    } else if (x > 20 & x <= 30) { # & is AND operator
        y <- x + 200
    } else {
        y <- x + 1
    }
    print(paste("The value of the function evaluated at the given point is", y))
}

f(21)
f(35)
f(15)

# ----------------------------------------------------------------------------
# FOR LOOPS
# ----------------------------------------------------------------------------

cat("\n========== FOR LOOPS ==========\n")

# Q: Count even integers in a vector
count_even <- function(x) {
    count <- 0
    n <- length(x)
    for (i in 1:n) {
        if (x[i] %% 2 == 0) {
            count <- count + 1
        }
    }
    return(count)
}

vec <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
cat("Vector:", vec, "\n")
cat("Number of even integers:", count_even(vec), "\n")

# Alternative: iterate directly over elements
count_even_v2 <- function(x) {
    count <- 0
    for (i in x) {
        if (i %% 2 == 0) {
            count <- count + 1
        }
    }
    return(count)
}

cat("Using v2:", count_even_v2(vec), "\n")

# Q: Sum of squares of differences
sum_sq_diff <- function(x) {
    sum <- 0
    for (i in x) {
        for (j in x) {
            sum <- sum + (i - j)^2
        }
    }
    return(sum)
}

vec2 <- c(1, 2, 3)
cat("\nVector:", vec2, "\n")
cat("Sum of squared differences:", sum_sq_diff(vec2), "\n")

# ----------------------------------------------------------------------------
# WHILE LOOPS
# ----------------------------------------------------------------------------

cat("\n========== WHILE LOOPS ==========\n")

# Example: Convergence problem
convergence_sum <- function() {
    a_1 <- 1
    a_2 <- a_1 + 0.5^1
    i <- 1

    while (abs(a_1 - a_2) > 0.0000001) {
        a_1 <- a_2
        a_2 <- a_1 + (0.5)^(i + 1)
        i <- i + 1
    }

    return(a_1)
}

result <- convergence_sum()
cat("Convergence result:", result, "\n")

# Simple while loop example
cat("\nCounting down:\n")
n <- 5
while (n > 0) {
    cat(n, "")
    n <- n - 1
}
cat("\n")

cat("\n========== LOOPS AND CONDITIONALS COMPLETED ==========\n")
