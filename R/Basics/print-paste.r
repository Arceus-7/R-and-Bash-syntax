# Print and Paste Functions

# Print displays any object
a <- 4.7
print(a)

b <- -3.6
print(b)
print("My name is XYZ")

# Paste for string concatenation
paste("My name is XYZ")

# Power function with vectors
x <- c(3, 4, 8)
y <- c(1, 5, 6)

power <- function(x, y) {
    p <- x^y
    print(paste(x, "raised to the power", y, "is", p))
}

power(x, y)

# Single value version
power_single <- function(x, y) {
    p <- x^y
    print(paste(x, "raised to the power", y, "is", p))
}

power_single(2, 3)
power_single(4, 2)
