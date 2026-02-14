# Non-Linear Equations Solver
# Requires: pracma (fzero, Bfzero), nleqslv packages

# Single equation examples
f <- function(x) x^2 - 5 * x + 2
# fzero(f, 1.7)
# fzero(f, 0.4)

f_1 <- function(x) x^2 - 1
# fzero(f_1, 1.5)

f_2 <- function(x) x^2 - 5 * x + 6
# Bfzero(f_2, 1.5, 2.5)

# System of non-linear equations

# Q1: x^2 - y - 3 = 0 and x + y^2 - 5 = 0
g <- function(x) {
    y_1 <- array(dim = c(1, 2))
    y_1[1] <- x[1] * x[1] + x[2] - 3
    y_1[2] <- x[1] + x[2] * x[2] - 5
    y_1
}
# nleqslv(c(1, 1), g, method = "Newton")
# nleqslv(c(1.1, 2.0), g, method = "Newton")

# Q2: x^2 + y^2 = 4 and x^2 - y = 4
k <- function(x) {
    y_1 <- array(dim = c(1, 2))
    y_1[1] <- x[1] * x[1] + x[2] * x[2] - 4
    y_1[2] <- x[1] * x[1] - x[2] - 4
    y_1
}
# nleqslv(c(1, 1), k, method = "Newton")

# Q3: x + y + z = 6, x^2 + y^2 + z^2 = 14, x^3 + y^3 + z^3 = 36
h <- function(x) {
    y_1 <- array(dim = c(1, 3))
    y_1[1] <- x[1] + x[2] + x[3] - 4
    y_1[2] <- (x[1])^2 + (x[2])^2 + (x[3])^2 - 14
    y_1[3] <- (x[1])^3 + (x[2])^3 + (x[3])^3 - 36
    y_1
}
# nleqslv(c(1, 2, 2.9), h, method = "Newton")
# nleqslv(c(1, 1, 1), h, method = "Newton")

# Q4: xy + x + y + 2.3 = 0 and x - y + 2xy + 1.6 = 0
p <- function(x) {
    y_1 <- array(dim = c(1, 2))
    y_1[1] <- x[1] * x[2] + x[1] + x[2] + 2.3
    y_1[2] <- x[1] - x[2] + 2 * x[1] * x[2] + 1.6
    y_1
}
# nleqslv(c(1, 1), p, method = "Newton")
