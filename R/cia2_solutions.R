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
x <- seq(0, 5, length.out = 30)
y <- seq(0, 5, length.out = 30)
z <- outer(x, y, function(x, y) sqrt(x * y))
persp(x, y, z, theta = 15, phi = 30, col = "lightblue", main = "Graph of z^2 = xy")

# 5
rat_data <- list(A = c(2, 5, 9, 1, 7), B = c(3, 3, 1), C = c(5, 7, 3, 8))
print(rat_data$B)
print(mean(rat_data$A))
print(sd(rat_data$C))

# 6
X <- c(80, 95, 120, 145, 165, 180, 190)
Y <- c(5, 6, 8, 7, 11, 9, 10)
model <- lm(Y ~ X)
prediction <- predict(model, newdata = data.frame(X = 130))
print(unname(prediction))

# 7
decimal_representation <- function(p, q) {
  rem <- p; rems <- c(); res <- c()
  while (rem != 0 && !(rem %in% rems)) {
    rems <- c(rems, rem)
    res <- c(res, (rem * 10) %/% q)
    rem <- (rem * 10) %% q
  }
  idx <- match(rem, rems)
  non_rec <- if (is.na(idx)) res else res[seq_len(idx - 1)]
  rec <- if (is.na(idx)) c() else res[idx:length(res)]
  list(non_recurring = paste0("0.", paste(non_rec, collapse = "")), recurring = paste(rec, collapse = ""))
}
print(decimal_representation(1, 7))

# 8
mat2 <- matrix(c(2, 3, 3, 2), ncol = 2)
is_basis2 <- det(mat2) != 0
print(is_basis2)

mat3 <- matrix(c(1, 2, 4, 1, 3, 9, 1, 4, 16), ncol = 3)
is_basis3 <- det(mat3) != 0
print(is_basis3)

T_map <- function(v) {
  c(2*v[1] + 3*v[2], v[1] + 11*v[2], -5*v[1] + 3*v[2])
}
Tv1 <- T_map(c(2, 3))
Tv2 <- T_map(c(3, 2))
T_matrix <- matrix(c(solve(mat3, Tv1), solve(mat3, Tv2)), ncol = 2)
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
