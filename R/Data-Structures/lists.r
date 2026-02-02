# ============================================================================
# R Data Structures: Lists
# ============================================================================
# Lists are flexible containers that can hold different types of data

# ----------------------------------------------------------------------------
# 1. CREATING LISTS
# ----------------------------------------------------------------------------

# Basic list
list1 <- list(10, 20, 30, 40, 50)
print(list1)

# List with different types
list2 <- list(42, "hello", TRUE, 3.14)
print(list2)

# Named list
person <- list(
    name = "ABC",
    age = 25,
    height = 5.9,
    employed = TRUE
)
print(person)

# List containing vectors
list3 <- list(
    numbers = c(1, 2, 3, 4, 5),
    letters = c("a", "b", "c"),
    logicals = c(TRUE, FALSE, TRUE)
)
print(list3)

# ----------------------------------------------------------------------------
# 2. ACCESSING LIST ELEMENTS
# ----------------------------------------------------------------------------

# Access by index using [[]]
cat("First element:", list1[[1]], "\n")
cat("Second element:", list1[[2]], "\n")

# Access by name using $
cat("Name:", person$name, "\n")
cat("Age:", person$age, "\n")

# Access by name using [[]]
cat("Height:", person[["height"]], "\n")

# Access using [] returns a list
subset_list <- person[1:2]
print(subset_list)

# Multiple elements
cat("First two elements:\n")
print(list1[1:2])

# ----------------------------------------------------------------------------
# 3. NESTED LISTS
# ----------------------------------------------------------------------------

# Create nested list
employee <- list(
    id = 101,
    personal = list(
        name = "XYZ",
        age = 30,
        address = list(
            street = "Street A",
            city = "City B",
            zip = "12345"
        )
    ),
    department = "IT",
    salary = 60000
)
print(employee)

# Access nested elements
cat("Employee name:", employee$personal$name, "\n")
cat("City:", employee$personal$address$city, "\n")
cat("Zip code:", employee[[2]][[3]][[3]], "\n")

# ----------------------------------------------------------------------------
# 4. MODIFYING LISTS
# ----------------------------------------------------------------------------

# Add new element
person$city <- "City A"
print(person)

# Modify existing element
person$age <- 26
cat("Updated age:", person$age, "\n")

# Add element by index
list1[[6]] <- 60
print(list1)

# Remove element by setting to NULL
person$height <- NULL
print(person)

# ----------------------------------------------------------------------------
# 5. LIST PROPERTIES
# ----------------------------------------------------------------------------

cat("Length:", length(person), "\n")
cat("Names:", names(person), "\n")
cat("Structure:\n")
str(person)

# Check if object is list
cat("Is list:", is.list(person), "\n")

# ----------------------------------------------------------------------------
# 6. COMBINING LISTS
# ----------------------------------------------------------------------------

# Concatenate lists
list_a <- list(1, 2, 3)
list_b <- list(4, 5, 6)
combined <- c(list_a, list_b)
print(combined)

# Append to list
list_a <- append(list_a, list(7, 8))
print(list_a)

# Merge named lists
person1 <- list(name = "A", age = 25)
person2 <- list(name = "B", age = 30)
people <- list(person1, person2)
print(people)

# ----------------------------------------------------------------------------
# 7. APPLYING FUNCTIONS TO LISTS
# ----------------------------------------------------------------------------

# Create list of numbers
num_list <- list(
    a = c(1, 2, 3),
    b = c(10, 20, 30),
    c = c(100, 200, 300)
)

# lapply - returns list
means_list <- lapply(num_list, mean)
print(means_list)

# sapply - returns vector
means_vec <- sapply(num_list, mean)
cat("Means:", means_vec, "\n")

# Apply custom function
squares <- lapply(num_list, function(x) x^2)
print(squares)

# ----------------------------------------------------------------------------
# 8. FILTERING AND SUBSETTING LISTS
# ----------------------------------------------------------------------------

# Select elements by condition
data_list <- list(a = 10, b = 25, c = 5, d = 30, e = 15)
large_values <- data_list[sapply(data_list, function(x) x > 10)]
print(large_values)

# Select by names
selected <- data_list[c("a", "c", "e")]
print(selected)

# Remove elements
data_list$b <- NULL
print(data_list)

# ----------------------------------------------------------------------------
# 9. CONVERTING BETWEEN LISTS AND VECTORS
# ----------------------------------------------------------------------------

# List to vector (if elements are compatible)
simple_list <- list(10, 20, 30, 40)
vec <- unlist(simple_list)
cat("Vector:", vec, "\n")

# Vector to list
numbers <- c(1, 2, 3, 4, 5)
num_list <- as.list(numbers)
print(num_list)

# Named vector to list
named_vec <- c(a = 1, b = 2, c = 3)
named_list <- as.list(named_vec)
print(named_list)

# ----------------------------------------------------------------------------
# 10. LISTS vs DATA FRAMES
# ----------------------------------------------------------------------------

# List can have different length elements
mixed_list <- list(
    x = c(1, 2, 3),
    y = c("a", "b"),
    z = 42
)
print(mixed_list)

# Convert list to data frame (if lengths match)
df_list <- list(
    name = c("A", "B", "C"),
    age = c(25, 30, 35),
    salary = c(50000, 60000, 70000)
)
df <- as.data.frame(df_list)
print(df)

# Data frame to list
list_from_df <- as.list(df)
print(list_from_df)

# ----------------------------------------------------------------------------
# 11. ADVANCED LIST OPERATIONS
# ----------------------------------------------------------------------------

# Flatten nested list
nested <- list(
    a = 1,
    b = list(2, 3),
    c = list(4, list(5, 6))
)
flattened <- unlist(nested)
cat("Flattened:", flattened, "\n")

# Reverse list
reversed <- rev(data_list)
print(reversed)

# Sort list by values
sorted_list <- data_list[order(unlist(data_list))]
print(sorted_list)

# ----------------------------------------------------------------------------
# 12. PRACTICAL EXAMPLES
# ----------------------------------------------------------------------------

# Example 1: Store multiple analysis results
analysis_results <- list(
    data = c(10, 20, 30, 40, 50),
    mean = mean(c(10, 20, 30, 40, 50)),
    sd = sd(c(10, 20, 30, 40, 50)),
    min = min(c(10, 20, 30, 40, 50)),
    max = max(c(10, 20, 30, 40, 50)),
    summary = summary(c(10, 20, 30, 40, 50))
)
print(analysis_results)

# Example 2: Configuration settings
config <- list(
    database = list(
        host = "localhost",
        port = 5432,
        name = "mydb"
    ),
    auth = list(
        username = "user",
        password = "pass"
    ),
    options = list(
        timeout = 30,
        retries = 3
    )
)
cat("DB Host:", config$database$host, "\n")
cat("Timeout:", config$options$timeout, "\n")

# Example 3: Group students by class
students <- list(
    class_a = c("Student1", "Student2", "Student3"),
    class_b = c("Student4", "Student5"),
    class_c = c("Student6", "Student7", "Student8", "Student9")
)
cat("Total classes:", length(students), "\n")
cat("Students in class A:", length(students$class_a), "\n")

# Example 4: Store function results
compute_stats <- function(data) {
    list(
        n = length(data),
        mean = mean(data),
        median = median(data),
        sd = sd(data),
        range = range(data)
    )
}
result <- compute_stats(c(5, 10, 15, 20, 25))
print(result)

# Example 5: Iterate over list
scores <- list(math = 85, science = 92, english = 78, history = 88)
for (subject in names(scores)) {
    cat(subject, ":", scores[[subject]], "\n")
}

# Calculate average
total <- sum(unlist(scores))
avg <- total / length(scores)
cat("Average score:", avg, "\n")
