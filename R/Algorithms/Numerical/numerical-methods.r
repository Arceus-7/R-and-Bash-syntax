# Numerical Methods and Algorithms

# Bisection method example
f <- function(x) x^15 - 17 * x + 1
# library(pracma)
# bisect(f, 0, 1)

f(0.5)
f(0.25)
f(0.15)

# Collatz conjecture (3n + 1 problem)
# v1 = a, v(n+1) = v(n)/2 if even, 3*v(n)+1 if odd
# Stop when v(n) = 1

a <- 30
v <- c(a)
n <- 1
w <- a

while (w > 1) {
    if (v[n] %% 2 == 0) {
        w <- v[n] / 2
    } else {
        w <- 3 * v[n] + 1
    }
    n <- n + 1
    v <- c(v, w)
}

print(v)

# Decimal representation of p/q
# Find recurring and non-recurring parts

p <- 3
q <- 7

rem <- p %% q
v <- c(rem)
l <- 0

while (l < 1) {
    rem <- 10 * rem
    rem <- rem %% q
    z <- which(v == rem, TRUE)

    if (length(z) > 0) {
        l <- 1
    } else {
        v <- c(v, rem)
    }
}

print(v)

n <- z[1] - 1
if (n == 0) {
    cat("No non-recurring part\n")
} else {
    w <- v[1:n]
    u <- v[z[1]:length(v)]
    cat("Non-recurring part:", w, "\n")
    cat("Recurring part:", u, "\n")
}
