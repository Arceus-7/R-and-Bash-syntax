# 1
vol <- 2 * pi * integrate(function(r) (5 - 5 * r) * r, 0, 1)$value
print(vol)

# 2
f2 <- function(x) { x^15 - 17*x + 1 }
sol <- uniroot(f2, interval = c(0, 1))$root
print(sol)

# 3
expr <- expression(exp(x^2) * sin(y))
dx <- D(expr, "x")
dy <- D(expr, "y")
x <- 3
y <- pi/4
print(c(eval(dx), eval(dy)))

# 4
x_vals <- seq(0, 5, length.out = 30)
y_vals <- seq(0, 5, length.out = 30)
z_vals <- outer(x_vals, y_vals, function(x, y) sqrt(x * y))
persp(x_vals, y_vals, z_vals, theta = 15, phi = 30, col = "lightblue", main = "Graph of z^2 = xy")

# 5
rat_data <- list(A = c(2, 5, 9, 1, 7), B = c(3, 3, 1), C = c(5, 7, 3, 8))
print(rat_data$B)
print(mean(rat_data$A))
print(sd(rat_data$C))

# 6
X_vals <- c(80, 95, 120, 145, 165, 180, 190)
Y_vals <- c(5, 6, 8, 7, 11, 9, 10)
model <- lm(Y_vals ~ X_vals)
prediction <- predict(model, newdata = data.frame(X_vals = 130))
print(unname(prediction))

# 7
decimal_representation <- function(p, q) {
  if (p <= 0 || p >= q) return(list(non_recurring = "", recurring = ""))
  rem <- p
  rem_dict <- new.env(hash = TRUE, parent = emptyenv())
  result <- c()
  pos <- 1
  while (rem != 0 && is.null(rem_dict[[as.character(rem)]])) {
    rem_dict[[as.character(rem)]] <- pos
    rem <- rem * 10
    result <- c(result, rem %/% q)
    rem <- rem %% q
    pos <- pos + 1
  }
  if (rem == 0) {
    non_recurring <- paste(result, collapse = "")
    recurring <- ""
  } else {
    repeat_start <- rem_dict[[as.character(rem)]]
    non_recurring <- paste(result[1:max(1, repeat_start - 1)], collapse = "")
    if (repeat_start == 1) non_recurring <- ""
    recurring <- paste(result[repeat_start:length(result)], collapse = "")
  }
  list(non_recurring = non_recurring, recurring = recurring)
}
print(decimal_representation(1, 7))

# 8
mat2 <- cbind(c(2, 3), c(3, 2))
is_basis2 <- det(mat2) != 0
print(is_basis2)

mat3 <- cbind(c(1, 2, 4), c(1, 3, 9), c(1, 4, 16))
is_basis3 <- det(mat3) != 0
print(is_basis3)

T_map <- function(v) {
  c(2*v[1] + 3*v[2], v[1] + 11*v[2], -5*v[1] + 3*v[2])
}
Tv1 <- T_map(c(2, 3))
Tv2 <- T_map(c(3, 2))
T_matrix <- cbind(solve(mat3, Tv1), solve(mat3, Tv2))
print(T_matrix)

# 9
collatz <- function(a) {
  v <- c(a)
  while (tail(v, 1) != 1) {
    last <- tail(v, 1)
    if (last %% 2 == 0) {
      v <- c(v, last / 2)
    } else {
      v <- c(v, 3 * last + 1)
    }
  }
  return(v)
}
print(collatz(217))
print(collatz(115))
print(collatz(317))
