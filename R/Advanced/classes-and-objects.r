# ============================================================================
# R Advanced: Classes and Objects
# ============================================================================
# Object-oriented programming in R with S3 and S4 classes

# ----------------------------------------------------------------------------
# 1. S3 CLASSES (Simple, Informal)
# ----------------------------------------------------------------------------

# Create S3 object
person <- list(
    name = "ABC",
    age = 25,
    occupation = "Engineer"
)

# Assign class
class(person) <- "Person"

# Check class
cat("Class:", class(person), "\n")
cat("Is Person:", inherits(person, "Person"), "\n")

# Print method for Person class
print.Person <- function(x) {
    cat("Person Information:\n")
    cat("Name:", x$name, "\n")
    cat("Age:", x$age, "\n")
    cat("Occupation:", x$occupation, "\n")
}

# Test print method
print(person)

# Constructor function
create_person <- function(name, age, occupation) {
    person <- list(
        name = name,
        age = age,
        occupation = occupation
    )
    class(person) <- "Person"
    return(person)
}

# Create objects using constructor
p1 <- create_person("XYZ", 30, "Doctor")
p2 <- create_person("PQR", 28, "Teacher")

print(p1)
print(p2)

# ----------------------------------------------------------------------------
# 2. S3 GENERIC FUNCTIONS
# ----------------------------------------------------------------------------

# Create generic function
summarize <- function(x) {
    UseMethod("summarize")
}

# Method for Person class
summarize.Person <- function(x) {
    cat(x$name, "is a", x$age, "year old", x$occupation, "\n")
}

# Method for default
summarize.default <- function(x) {
    cat("Summary not available for this class\n")
}

# Test generic
summarize(p1)
summarize(42) # Uses default method

# ----------------------------------------------------------------------------
# 3. S3 INHERITANCE
# ----------------------------------------------------------------------------

# Create derived class
employee <- create_person("LMN", 32, "Engineer")
employee$company <- "TechCorp"
employee$salary <- 75000
class(employee) <- c("Employee", "Person")

# Method for Employee
print.Employee <- function(x) {
    # Call parent print method
    NextMethod("print")
    cat("Company:", x$company, "\n")
    cat("Salary: $", x$salary, "\n")
}

print(employee)

# Check inheritance
cat("Is Employee:", inherits(employee, "Employee"), "\n")
cat("Is Person:", inherits(employee, "Person"), "\n")

# ----------------------------------------------------------------------------
# 4. PRACTICAL S3 EXAMPLE
# ----------------------------------------------------------------------------

# Bank Account class
create_account <- function(holder, balance = 0) {
    account <- list(
        holder = holder,
        balance = balance,
        transactions = c()
    )
    class(account) <- "BankAccount"
    return(account)
}

# Deposit method
deposit <- function(account, amount) {
    UseMethod("deposit")
}

deposit.BankAccount <- function(account, amount) {
    if (amount <= 0) {
        stop("Amount must be positive")
    }
    account$balance <- account$balance + amount
    account$transactions <- c(
        account$transactions,
        paste("Deposit:", amount)
    )
    return(account)
}

# Withdraw method
withdraw <- function(account, amount) {
    UseMethod("withdraw")
}

withdraw.BankAccount <- function(account, amount) {
    if (amount <= 0) {
        stop("Amount must be positive")
    }
    if (amount > account$balance) {
        stop("Insufficient funds")
    }
    account$balance <- account$balance - amount
    account$transactions <- c(
        account$transactions,
        paste("Withdraw:", amount)
    )
    return(account)
}

# Print method
print.BankAccount <- function(x) {
    cat("Bank Account\n")
    cat("Holder:", x$holder, "\n")
    cat("Balance: $", x$balance, "\n")
    if (length(x$transactions) > 0) {
        cat("Recent transactions:\n")
        for (t in tail(x$transactions, 5)) {
            cat("-", t, "\n")
        }
    }
}

# Test bank account
acc <- create_account("ABC", 1000)
acc <- deposit(acc, 500)
acc <- withdraw(acc, 200)
print(acc)

# ----------------------------------------------------------------------------
# 5. S4 CLASSES (Formal, Rigorous)
# ----------------------------------------------------------------------------

# Define S4 class
setClass("Student",
    slots = list(
        name = "character",
        age = "numeric",
        grades = "numeric",
        major = "character"
    )
)

# Create S4 object
student1 <- new("Student",
    name = "ABC",
    age = 20,
    grades = c(85, 90, 88),
    major = "Computer Science"
)

# Access slots
cat("Name:", student1@name, "\n")
cat("Age:", student1@age, "\n")
cat("Grades:", student1@grades, "\n")

# Show method for S4
setMethod(
    "show", "Student",
    function(object) {
        cat("Student:", object@name, "\n")
        cat("Age:", object@age, "\n")
        cat("Major:", object@major, "\n")
        cat("GPA:", mean(object@grades), "\n")
    }
)

# Test show
student1

# ----------------------------------------------------------------------------
# 6. S4 METHODS
# ----------------------------------------------------------------------------

# Define generic for S4
setGeneric("getGPA", function(object) standardGeneric("getGPA"))

# Define method
setMethod(
    "getGPA", "Student",
    function(object) {
        mean(object@grades)
    }
)

# Test method
cat("GPA:", getGPA(student1), "\n")

# Define method with parameters
setGeneric("addGrade", function(object, grade) standardGeneric("addGrade"))

setMethod(
    "addGrade", "Student",
    function(object, grade) {
        object@grades <- c(object@grades, grade)
        return(object)
    }
)

# Test
student1 <- addGrade(student1, 92)
cat("Updated GPA:", getGPA(student1), "\n")

# ----------------------------------------------------------------------------
# 7. S4 INHERITANCE
# ----------------------------------------------------------------------------

# Define parent class
setClass("Person_S4",
    slots = list(
        name = "character",
        age = "numeric"
    )
)

# Define child class
setClass("Student_S4",
    contains = "Person_S4",
    slots = list(
        studentID = "character",
        gpa = "numeric"
    )
)

# Create instance
student_s4 <- new("Student_S4",
    name = "XYZ",
    age = 21,
    studentID = "S12345",
    gpa = 3.8
)

# Access inherited and own slots
cat("Name:", student_s4@name, "\n")
cat("Student ID:", student_s4@studentID, "\n")

# ----------------------------------------------------------------------------
# 8. S4 VALIDATION
# ----------------------------------------------------------------------------

# Define class with validity check
setClass("Temperature",
    slots = list(
        value = "numeric",
        unit = "character"
    ),
    validity = function(object) {
        if (!object@unit %in% c("C", "F", "K")) {
            return("Unit must be C, F, or K")
        }
        if (object@unit == "K" && object@value < 0) {
            return("Kelvin cannot be negative")
        }
        return(TRUE)
    }
)

# Valid object
temp1 <- new("Temperature", value = 25, unit = "C")
cat("Temperature:", temp1@value, temp1@unit, "\n")

# Invalid object (will error)
# temp2 <- new("Temperature", value = -50, unit = "K")

# ----------------------------------------------------------------------------
# 9. PRACTICAL S4 EXAMPLE
# ----------------------------------------------------------------------------

# Rectangle class
setClass("Rectangle",
    slots = list(
        width = "numeric",
        height = "numeric"
    )
)

# Generic functions
setGeneric("area", function(object) standardGeneric("area"))
setGeneric("perimeter", function(object) standardGeneric("perimeter"))

# Methods
setMethod(
    "area", "Rectangle",
    function(object) {
        object@width * object@height
    }
)

setMethod(
    "perimeter", "Rectangle",
    function(object) {
        2 * (object@width + object@height)
    }
)

setMethod(
    "show", "Rectangle",
    function(object) {
        cat("Rectangle\n")
        cat("Width:", object@width, "\n")
        cat("Height:", object@height, "\n")
        cat("Area:", area(object), "\n")
        cat("Perimeter:", perimeter(object), "\n")
    }
)

# Test
rect <- new("Rectangle", width = 5, height = 3)
rect
cat("Area:", area(rect), "\n")
cat("Perimeter:", perimeter(rect), "\n")

# ----------------------------------------------------------------------------
# 10. S3 vs S4 COMPARISON
# ----------------------------------------------------------------------------

cat("\n=== S3 vs S4 ===\n")
cat("S3 Classes:\n")
cat("- Informal, flexible\n")
cat("- Easy to create\n")
cat("- No formal slots\n")
cat("- Used in base R\n\n")

cat("S4 Classes:\n")
cat("- Formal, rigorous\n")
cat("- Strict slot definitions\n")
cat("- Built-in validity checking\n")
cat("- Used in Bioconductor\n\n")

# ----------------------------------------------------------------------------
# 11. REFERENCE CLASSES (R5/RC)
# ----------------------------------------------------------------------------

# Define reference class
BankAccountRC <- setRefClass("BankAccountRC",
    fields = list(
        holder = "character",
        balance = "numeric"
    ),
    methods = list(
        deposit = function(amount) {
            balance <<- balance + amount
            cat("Deposited:", amount, "\n")
        },
        withdraw = function(amount) {
            if (amount > balance) {
                stop("Insufficient funds")
            }
            balance <<- balance - amount
            cat("Withdrawn:", amount, "\n")
        },
        getBalance = function() {
            return(balance)
        }
    )
)

# Create instance
acc_rc <- BankAccountRC$new(holder = "ABC", balance = 1000)

# Call methods
acc_rc$deposit(500)
acc_rc$withdraw(200)
cat("Balance:", acc_rc$getBalance(), "\n")

cat("\n=== Classes and Objects Complete ===\n")
