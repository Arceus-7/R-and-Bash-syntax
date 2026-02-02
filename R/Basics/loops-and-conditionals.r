# ============================================================================
# R Basics: Loops and Conditional Statements
# ============================================================================
# Control structures for flow control in R

# ----------------------------------------------------------------------------
# 1. IF STATEMENTS
# ----------------------------------------------------------------------------

# Basic if statement
x <- 10
if (x > 5) {
    cat("x is greater than 5\n")
}

# if-else
age <- 20
if (age >= 18) {
    cat("Adult\n")
} else {
    cat("Minor\n")
}

# if-else if-else
score <- 85
if (score >= 90) {
    cat("Grade: A\n")
} else if (score >= 80) {
    cat("Grade: B\n")
} else if (score >= 70) {
    cat("Grade: C\n")
} else {
    cat("Grade: F\n")
}

# Nested if statements
num <- 15
if (num > 0) {
    if (num %% 2 == 0) {
        cat("Positive even number\n")
    } else {
        cat("Positive odd number\n")
    }
} else {
    cat("Non-positive number\n")
}

# ----------------------------------------------------------------------------
# 2. IFELSE - VECTORIZED CONDITIONAL
# ----------------------------------------------------------------------------

# ifelse() for vectors
numbers <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
result <- ifelse(numbers %% 2 == 0, "Even", "Odd")
cat("Numbers:", numbers, "\n")
cat("Result:", result, "\n")

# Nested ifelse
scores <- c(95, 82, 76, 68, 55, 91)
grades <- ifelse(scores >= 90, "A",
    ifelse(scores >= 80, "B",
        ifelse(scores >= 70, "C",
            ifelse(scores >= 60, "D", "F")
        )
    )
)
cat("Scores:", scores, "\n")
cat("Grades:", grades, "\n")

# Using ifelse for data transformation
temperatures <- c(32, 50, 75, 90, 100)
status <- ifelse(temperatures < 60, "Cold",
    ifelse(temperatures < 80, "Moderate", "Hot")
)
cat("Temperatures:", temperatures, "\n")
cat("Status:", status, "\n")

# ----------------------------------------------------------------------------
# 3. SWITCH STATEMENT
# ----------------------------------------------------------------------------

# switch with numeric index
get_day <- function(day_num) {
    switch(day_num,
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
    )
}
cat("Day 3:", get_day(3), "\n")
cat("Day 7:", get_day(7), "\n")

# switch with character matching
calculate <- function(operation, a, b) {
    switch(operation,
        "add" = a + b,
        "subtract" = a - b,
        "multiply" = a * b,
        "divide" = if (b != 0) a / b else "Error",
        "Unknown operation"
    )
}
cat("10 + 5 =", calculate("add", 10, 5), "\n")
cat("10 * 5 =", calculate("multiply", 10, 5), "\n")

# ----------------------------------------------------------------------------
# 4. FOR LOOPS
# ----------------------------------------------------------------------------

# Basic for loop
cat("Counting 1 to 5:\n")
for (i in 1:5) {
    cat(i, " ")
}
cat("\n")

# Loop through vector
fruits <- c("apple", "banana", "cherry")
cat("Fruits:\n")
for (fruit in fruits) {
    cat(fruit, "\n")
}

# Loop with index and value
cat("Indexed fruits:\n")
for (i in seq_along(fruits)) {
    cat(i, ":", fruits[i], "\n")
}

# Nested for loops
cat("Multiplication table (3x3):\n")
for (i in 1:3) {
    for (j in 1:3) {
        cat(i * j, "\t")
    }
    cat("\n")
}

# For loop with calculations
sum_total <- 0
for (num in 1:10) {
    sum_total <- sum_total + num
}
cat("Sum of 1 to 10:", sum_total, "\n")

# ----------------------------------------------------------------------------
# 5. WHILE LOOPS
# ----------------------------------------------------------------------------

# Basic while loop
count <- 1
cat("While loop counting:\n")
while (count <= 5) {
    cat(count, " ")
    count <- count + 1
}
cat("\n")

# While loop with condition
num <- 1
cat("Powers of 2 less than 100:\n")
while (num < 100) {
    cat(num, " ")
    num <- num * 2
}
cat("\n")

# While loop for iteration until condition
target <- 50
sum_val <- 0
i <- 1
while (sum_val < target) {
    sum_val <- sum_val + i
    i <- i + 1
}
cat("Sum reached", sum_val, "in", i - 1, "steps\n")

# ----------------------------------------------------------------------------
# 6. REPEAT LOOPS
# ----------------------------------------------------------------------------

# Repeat loop with break
count <- 1
cat("Repeat loop:\n")
repeat {
    cat(count, " ")
    count <- count + 1
    if (count > 5) {
        break
    }
}
cat("\n")

# Finding a value with repeat
x <- 1
repeat {
    if (x^2 > 100) {
        break
    }
    x <- x + 1
}
cat("First integer whose square > 100:", x, "\n")

# ----------------------------------------------------------------------------
# 7. BREAK AND NEXT
# ----------------------------------------------------------------------------

# Using break to exit loop
cat("Break example:\n")
for (i in 1:10) {
    if (i > 5) {
        break
    }
    cat(i, " ")
}
cat("\n")

# Using next to skip iteration
cat("Next example (skip even numbers):\n")
for (i in 1:10) {
    if (i %% 2 == 0) {
        next
    }
    cat(i, " ")
}
cat("\n")

# Combined break and next
cat("Find first number divisible by 7 and 3:\n")
for (i in 1:100) {
    if (i %% 7 != 0) {
        next
    }
    if (i %% 3 == 0) {
        cat("Found:", i, "\n")
        break
    }
}

# ----------------------------------------------------------------------------
# 8. PRACTICAL APPLICATIONS
# ----------------------------------------------------------------------------

# Application 1: Sampling distribution simulation
set.seed(42)
sample_means <- numeric(1000)
for (i in 1:1000) {
    sample_data <- rnorm(30, mean = 100, sd = 15)
    sample_means[i] <- mean(sample_data)
}
cat("Sample means - Mean:", mean(sample_means), "SD:", sd(sample_means), "\n")

# Application 2: Prime number finder
is_prime <- function(n) {
    if (n <= 1) {
        return(FALSE)
    }
    if (n <= 3) {
        return(TRUE)
    }

    for (i in 2:sqrt(n)) {
        if (n %% i == 0) {
            return(FALSE)
        }
    }
    return(TRUE)
}

primes <- c()
for (num in 2:50) {
    if (is_prime(num)) {
        primes <- c(primes, num)
    }
}
cat("Primes up to 50:", primes, "\n")

# Application 3: Monte Carlo simulation
set.seed(123)
num_simulations <- 10000
inside_circle <- 0

for (i in 1:num_simulations) {
    x <- runif(1, -1, 1)
    y <- runif(1, -1, 1)

    if (x^2 + y^2 <= 1) {
        inside_circle <- inside_circle + 1
    }
}

pi_estimate <- 4 * inside_circle / num_simulations
cat("Pi estimate:", pi_estimate, "Actual:", pi, "\n")

# Application 4: Fibonacci sequence
n <- 10
fib <- numeric(n)
fib[1] <- 0
fib[2] <- 1

for (i in 3:n) {
    fib[i] <- fib[i - 1] + fib[i - 2]
}
cat("First", n, "Fibonacci numbers:", fib, "\n")

# Application 5: Cumulative sum with condition
values <- c(5, 10, 15, 20, 25, 30, 35, 40)
cumsum_val <- 0
count <- 0

for (val in values) {
    cumsum_val <- cumsum_val + val
    count <- count + 1
    if (cumsum_val > 50) {
        break
    }
}
cat("Cumulative sum exceeded 50 after", count, "values\n")

# Application 6: Data validation loop
data <- c(10, 20, -5, 30, 40, -10, 50)
valid_data <- c()

for (val in data) {
    if (val < 0) {
        cat("Warning: Negative value", val, "skipped\n")
        next
    }
    valid_data <- c(valid_data, val)
}
cat("Valid data:", valid_data, "\n")

# Application 7: Conditional aggregation
groups <- c("A", "B", "A", "C", "B", "A", "C")
values <- c(10, 20, 15, 30, 25, 12, 18)
group_sums <- list(A = 0, B = 0, C = 0)

for (i in seq_along(groups)) {
    group <- groups[i]
    if (group == "A") {
        group_sums$A <- group_sums$A + values[i]
    } else if (group == "B") {
        group_sums$B <- group_sums$B + values[i]
    } else if (group == "C") {
        group_sums$C <- group_sums$C + values[i]
    }
}
cat("Group A sum:", group_sums$A, "\n")
cat("Group B sum:", group_sums$B, "\n")
cat("Group C sum:", group_sums$C, "\n")
