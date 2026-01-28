# ============================================================================
# R Data Structures: Vectors
# ============================================================================
# Vectors are the most basic data structure in R
# They are one-dimensional arrays that hold elements of the same type

cat("=== R Vectors ===\n\n")

# ----------------------------------------------------------------------------
# 1. CREATING VECTORS
# ----------------------------------------------------------------------------

# Using c() function (combine)
numeric_vec <- c(1, 2, 3, 4, 5)
char_vec <- c("apple", "banana", "cherry")
logical_vec <- c(TRUE, FALSE, TRUE, TRUE)

cat("Basic vectors:\n")
print(numeric_vec)
print(char_vec)
print(logical_vec)
cat("\n")

# Sequence vectors
seq1 <- 1:10                    # Simple sequence
seq2 <- seq(1, 10, by = 2)      # Sequence by step
seq3 <- seq(0, 1, length.out = 5)  # Sequence by length

cat("Sequence vectors:\n")
cat("1:10 =", seq1, "\n")
cat("seq(1, 10, by=2) =", seq2, "\n")
cat("seq(0, 1, length.out=5) =", seq3, "\n\n")

# Repeat vectors
rep1 <- rep(5, times = 3)       # Repeat value
rep2 <- rep(c(1, 2), times = 3) # Repeat vector
rep3 <- rep(c(1, 2), each = 3)  # Repeat each element

cat("Repeat vectors:\n")
cat("rep(5, 3) =", rep1, "\n")
cat("rep(c(1,2), times=3) =", rep2, "\n")
cat("rep(c(1,2), each=3) =", rep3, "\n\n")

# ----------------------------------------------------------------------------
# 2. VECTOR PROPERTIES
# ----------------------------------------------------------------------------

v <- c(10, 20, 30, 40, 50)

cat("Vector properties:\n")
cat("length(v) =", length(v), "\n")
cat("class(v) =", class(v), "\n")
cat("typeof(v) =", typeof(v), "\n")
cat("is.vector(v) =", is.vector(v), "\n\n")

# ----------------------------------------------------------------------------
# 3. INDEXING AND SUBSETTING
# ----------------------------------------------------------------------------

numbers <- c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)

cat("Indexing:\n")
cat("numbers =", numbers, "\n")
cat("First element numbers[1] =", numbers[1], "\n")
cat("Third element numbers[3] =", numbers[3], "\n")
cat("Last element numbers[length(numbers)] =", numbers[length(numbers)], "\n\n")

# Multiple elements
cat("Multiple elements:\n")
cat("numbers[c(1, 3, 5)] =", numbers[c(1, 3, 5)], "\n")
cat("numbers[1:5] =", numbers[1:5], "\n")
cat("numbers[-1] (exclude first) =", numbers[-1], "\n")
cat("numbers[-(1:3)] (exclude first 3) =", numbers[-(1:3)], "\n\n")

# Logical indexing
cat("Logical indexing:\n")
cat("numbers > 50:", numbers[numbers > 50], "\n")
cat("numbers %% 20 == 0:", numbers[numbers %% 20 == 0], "\n\n")

# ----------------------------------------------------------------------------
# 4. VECTOR ARITHMETIC
# ----------------------------------------------------------------------------

v1 <- c(1, 2, 3, 4, 5)
v2 <- c(10, 20, 30, 40, 50)

cat("Vector arithmetic:\n")
cat("v1 =", v1, "\n")
cat("v2 =", v2, "\n")
cat("v1 + v2 =", v1 + v2, "\n")
cat("v1 * v2 =", v1 * v2, "\n")
cat("v2 / v1 =", v2 / v1, "\n")
cat("v1 + 10 =", v1 + 10, "(scalar addition)\n\n")

# ----------------------------------------------------------------------------
# 5. NAMED VECTORS
# ----------------------------------------------------------------------------

ages <- c(ABC = 25, XYZ = 30, PQR = 35)

cat("Named vectors:\n")
print(ages)
cat("Access by name: ages['ABC'] =", ages["ABC"], "\n")
cat("Get names: names(ages) =", names(ages), "\n\n")

# Add names to existing vector
scores <- c(85, 92, 78)
names(scores) <- c("Math", "Science", "English")
cat("Scores with names:\n")
print(scores)
cat("\n")

# ----------------------------------------------------------------------------
# 6. VECTOR FUNCTIONS
# ----------------------------------------------------------------------------

data <- c(23, 45, 12, 67, 34, 89, 56)

cat("Vector functions:\n")
cat("sum(data) =", sum(data), "\n")
cat("mean(data) =", mean(data), "\n")
cat("median(data) =", median(data), "\n")
cat("min(data) =", min(data), "\n")
cat("max(data) =", max(data), "\n")
cat("range(data) =", range(data), "\n")
cat("sd(data) =", sd(data), "(standard deviation)\n")
cat("var(data) =", var(data), "(variance)\n\n")

# Sorting
cat("sort(data) =", sort(data), "\n")
cat("sort(data, decreasing=TRUE) =", sort(data, decreasing = TRUE), "\n")
cat("order(data) =", order(data), "(indices for sorting)\n\n")

# Find elements
cat("which(data > 50) =", which(data > 50), "\n")
cat("which.max(data) =", which.max(data), "\n")
cat("which.min(data) =", which.min(data), "\n\n")

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

cat("Vector comparison:\n")
cat("x == y:", x == y, "\n")
cat("x > 3:", x > 3, "\n")
cat("x <= y:", x <= y, "\n")
cat("all(x == y):", all(x == y), "\n")
cat("any(x == y):", any(x == y), "\n\n")

# ----------------------------------------------------------------------------
# 9. SET OPERATIONS
# ----------------------------------------------------------------------------

a <- c(1, 2, 3, 4, 5)
b <- c(4, 5, 6, 7, 8)

cat("Set operations:\n")
cat("a =", a, "\n")
cat("b =", b, "\n")
cat("union(a, b) =", union(a, b), "\n")
cat("intersect(a, b) =", intersect(a, b), "\n")
cat("setdiff(a, b) =", setdiff(a, b), "\n")
cat("setdiff(b, a) =", setdiff(b, a), "\n")
cat("5 %in% a:", 5 %in% a, "\n\n")

# ----------------------------------------------------------------------------
# EXERCISES
# ----------------------------------------------------------------------------

cat("=== EXERCISES ===\n")
cat("1. Create a vector of even numbers from 2 to 20\n")
cat("2. Calculate the mean and median of: c(12, 15, 18, 22, 25, 28, 30)\n")
cat("3. Find all elements greater than 20 in the above vector\n")
cat("4. Create a named vector with your favorite movies and their ratings\n")
cat("5. Sort the vector c(45, 23, 67, 12, 89, 34) in descending order\n\n")

# Solutions (commented):
# ex1 <- seq(2, 20, by=2)
# ex2 <- c(12, 15, 18, 22, 25, 28, 30)
# mean(ex2); median(ex2)
# ex2[ex2 > 20]
# movies <- c("Inception"=9, "Matrix"=8.5, "Interstellar"=9.5)
# sort(c(45, 23, 67, 12, 89, 34), decreasing=TRUE)
