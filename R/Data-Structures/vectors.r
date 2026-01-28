# ============================================================================
# R Data Structures: Vectors
# ============================================================================
# Vectors are the most basic data structure in R

# ----------------------------------------------------------------------------
# 1. CREATING VECTORS
# ----------------------------------------------------------------------------

# Using c() function
numeric_vec <- c(1, 2, 3, 4, 5)
char_vec <- c("apple", "banana", "cherry")
logical_vec <- c(TRUE, FALSE, TRUE, TRUE)
print(numeric_vec)
print(char_vec)
print(logical_vec)

# Sequence vectors
seq1 <- 1:10
seq2 <- seq(1, 10, by = 2)
seq3 <- seq(0, 1, length.out = 5)
cat(seq1, "\n")
cat(seq2, "\n")
cat(seq3, "\n")

# Repeat vectors
rep1 <- rep(5, times = 3)
rep2 <- rep(c(1, 2), times = 3)
rep3 <- rep(c(1, 2), each = 3)
cat(rep1, "\n")
cat(rep2, "\n")
cat(rep3, "\n")

# ----------------------------------------------------------------------------
# 2. VECTOR PROPERTIES
# ----------------------------------------------------------------------------

v <- c(10, 20, 30, 40, 50)
cat("Length:", length(v), "\n")
cat("Class:", class(v), "\n")
cat("Type:", typeof(v), "\n")

# ----------------------------------------------------------------------------
# 3. INDEXING AND SUBSETTING
# ----------------------------------------------------------------------------

numbers <- c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
cat("All:", numbers, "\n")
cat("First:", numbers[1], "\n")
cat("Third:", numbers[3], "\n")
cat("Last:", numbers[length(numbers)], "\n")

# Multiple elements
cat(numbers[c(1, 3, 5)], "\n")
cat(numbers[1:5], "\n")
cat(numbers[-1], "\n")

# Logical indexing
cat(numbers[numbers > 50], "\n")
cat(numbers[numbers %% 20 == 0], "\n")

# ----------------------------------------------------------------------------
# 4. VECTOR ARITHMETIC
# ----------------------------------------------------------------------------

v1 <- c(1, 2, 3, 4, 5)
v2 <- c(10, 20, 30, 40, 50)
cat("v1:", v1, "\n")
cat("v2:", v2, "\n")
cat("v1 + v2:", v1 + v2, "\n")
cat("v1 * v2:", v1 * v2, "\n")
cat("v2 / v1:", v2 / v1, "\n")
cat("v1 + 10:", v1 + 10, "\n")

# ----------------------------------------------------------------------------
# 5. NAMED VECTORS
# ----------------------------------------------------------------------------

ages <- c(ABC = 25, XYZ = 30, PQR = 35)
print(ages)
cat("ABC's age:", ages["ABC"], "\n")
cat("Names:", names(ages), "\n")

# Add names to existing vector
scores <- c(85, 92, 78)
names(scores) <- c("Math", "Science", "English")
print(scores)

# ----------------------------------------------------------------------------
# 6. VECTOR FUNCTIONS
# ----------------------------------------------------------------------------

data <- c(23, 45, 12, 67, 34, 89, 56)
cat("Sum:", sum(data), "\n")
cat("Mean:", mean(data), "\n")
cat("Median:", median(data), "\n")
cat("Min:", min(data), "\n")
cat("Max:", max(data), "\n")
cat("Range:", range(data), "\n")
cat("SD:", sd(data), "\n")

# Sorting
cat("Sorted:", sort(data), "\n")
cat("Descending:", sort(data, decreasing = TRUE), "\n")

# Find elements
cat("Indices > 50:", which(data > 50), "\n")
cat("Max index:", which.max(data), "\n")
cat("Min index:", which.min(data), "\n")

# ----------------------------------------------------------------------------
# 7. VECTOR MANIPULATION
# ----------------------------------------------------------------------------

v <- c(1, 2, 3, 4, 5)

cat("Vector manipulation:\n")
cat("Original v =", v, "\n")

# Append
v <- c(v, 6, 7)
cat("After append =", v, "\n")

# Insert at position
v <- append(v, 99, after = 3)
cat("After insert 99 at position 3 =", v, "\n")

# Remove element
v <- v[-4]  # Remove 4th element
cat("After removing 4th element =", v, "\n")

# Reverse
cat("rev(v) =", rev(v), "\n\n")

# ----------------------------------------------------------------------------
# 8. VECTOR COMPARISON
# ----------------------------------------------------------------------------

x <- c(1, 2, 3, 4, 5)
y <- c(1, 4, 3, 2, 5)
cat("x == y:", x == y, "\n")
cat("x > 3:", x > 3, "\n")
cat("all(x == y):", all(x == y), "\n")
cat("any(x == y):", any(x == y), "\n")

# ----------------------------------------------------------------------------
# 9. SET OPERATIONS
# ----------------------------------------------------------------------------

a <- c(1, 2, 3, 4, 5)
b <- c(4, 5, 6, 7, 8)
cat("a:", a, "\n")
cat("b:", b, "\n")
cat("union:", union(a, b), "\n")
cat("intersect:", intersect(a, b), "\n")
cat("setdiff(a,b):", setdiff(a, b), "\n")
cat("setdiff(b,a):", setdiff(b, a), "\n")
cat("5 in a:", 5 %in% a, "\n")
