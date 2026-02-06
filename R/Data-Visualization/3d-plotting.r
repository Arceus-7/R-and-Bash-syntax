# ============================================================================
# R 3D Plotting: Comprehensive Guide
# ============================================================================
# Complete guide to 3D plotting in R from basic shapes to complex structures
# Covers angles, rotation, colors, lighting, and all parameters

# Load required packages
if (!require(plot3D)) install.packages("plot3D")
if (!require(rgl)) install.packages("rgl")
if (!require(plotly)) install.packages("plotly")

library(plot3D)
library(rgl)
library(plotly)

# ============================================================================
# PART 1: plot3D PACKAGE - Static 3D Plots
# ============================================================================

cat("\n========== BASIC 3D SCATTER PLOT ==========\n")

# Simple 3D scatter
x <- rnorm(50)
y <- rnorm(50)
z <- x^2 + y^2 + rnorm(50, 0, 0.1)

scatter3D(x, y, z,
    col = "blue", pch = 19, cex = 1.5,
    theta = 30, phi = 20, # Viewing angles
    main = "Basic 3D Scatter Plot",
    xlab = "X axis", ylab = "Y axis", zlab = "Z axis"
)

cat("theta: azimuthal angle (rotation around z-axis), default = 40\n")
cat("phi: colatitude angle (vertical tilt), default = 20\n")

# ----------------------------------------------------------------------------
# VIEWING ANGLES AND PERSPECTIVE
# ----------------------------------------------------------------------------

cat("\n========== VIEWING ANGLES ==========\n")

# Create data
x <- 1:10
y <- 1:10
z <- outer(x, y, function(x, y) sin(x / 2) * cos(y / 2))

# Different viewing angles
par(mfrow = c(2, 2))

persp3D(x, y, z, theta = 30, phi = 30, main = "theta=30, phi=30")
persp3D(x, y, z, theta = 45, phi = 45, main = "theta=45, phi=45")
persp3D(x, y, z, theta = 120, phi = 15, main = "theta=120, phi=15")
persp3D(x, y, z, theta = 270, phi = 60, main = "theta=270, phi=60")

par(mfrow = c(1, 1))

cat("theta ranges: 0-360 (full rotation)\n")
cat("phi ranges: 0-90 (typical viewing angles)\n")

# ----------------------------------------------------------------------------
# 3D SURFACE PLOTS
# ----------------------------------------------------------------------------

cat("\n========== 3D SURFACE PLOTS ==========\n")

# Create grid
M <- mesh(1:20, 1:20)
x_grid <- M$x
y_grid <- M$y
z_grid <- sin(x_grid / 3) * cos(y_grid / 3)

# Basic surface
surf3D(x_grid, y_grid, z_grid,
    colkey = TRUE, # Show color legend
    box = TRUE, # Draw bounding box
    bty = "b2", # Box type
    main = "3D Surface Plot"
)

cat("bty options: 'b', 'b2', 'f', 'g', 'bl', 'bl2', 'u', 'n'\n")

# Surface with custom colors
surf3D(x_grid, y_grid, z_grid,
    col = ramp.col(c("blue", "white", "red")),
    colvar = z_grid,
    theta = 45, phi = 20,
    expand = 0.7, # Expand axes
    ticktype = "detailed", # Axis tick style
    main = "Custom Color Ramp"
)

cat("expand: scale factor for axes (0.5 = compressed, 1.5 = stretched)\n")
cat("ticktype: 'simple' or 'detailed'\n")

# ----------------------------------------------------------------------------
# CONTOUR PLOTS IN 3D
# ----------------------------------------------------------------------------

cat("\n========== 3D CONTOUR PLOTS ==========\n")

# 3D contour with filled contours
contour3D(x_grid, y_grid, z_grid,
    colkey = TRUE,
    col = jet.col(100),
    nlevels = 20,
    main = "3D Contour Plot"
)

# Contour lines on surface
surf3D(x_grid, y_grid, z_grid,
    col = "lightblue",
    colkey = FALSE,
    main = "Surface with Contours"
)
contour3D(x_grid, y_grid, z_grid,
    col = "black", lwd = 2,
    add = TRUE, # Add to existing plot
    nlevels = 10
)

cat("nlevels: number of contour levels\n")
cat("add = TRUE: overlay on existing plot\n")

# ----------------------------------------------------------------------------
# COLOR PALETTES AND CUSTOMIZATION
# ----------------------------------------------------------------------------

cat("\n========== COLOR PALETTES AND CUSTOMIZATION ==========\n")

# Available color ramps
palette_demo <- function(x, y, z, title) {
    surf3D(x, y, z,
        colkey = TRUE, theta = 30, phi = 30,
        main = title, cex.main = 1.2
    )
}

par(mfrow = c(2, 3))
palette_demo(x_grid, y_grid, z_grid, "Default")
surf3D(x_grid, y_grid, z_grid, col = jet.col(100), main = "jet.col")
surf3D(x_grid, y_grid, z_grid, col = jet2.col(100), main = "jet2.col")
surf3D(x_grid, y_grid, z_grid, col = rainbow(100), main = "rainbow")
surf3D(x_grid, y_grid, z_grid, col = heat.colors(100), main = "heat.colors")
surf3D(x_grid, y_grid, z_grid, col = terrain.colors(100), main = "terrain.colors")
par(mfrow = c(1, 1))

cat("Color palettes: jet.col, jet2.col, ramp.col, rainbow, heat.colors, terrain.colors, topo.colors\n")

# Custom color ramp
my_colors <- ramp.col(c("darkblue", "cyan", "yellow", "red"))
surf3D(x_grid, y_grid, z_grid,
    col = my_colors,
    main = "Custom Color Gradient"
)

# ----------------------------------------------------------------------------
# LIGHTING AND SHADING
# ----------------------------------------------------------------------------

cat("\n========== LIGHTING AND SHADING ==========\n")

par(mfrow = c(2, 2))

# Different shading options
surf3D(x_grid, y_grid, z_grid,
    shade = 0.1, lighting = TRUE,
    main = "shade = 0.1"
)
surf3D(x_grid, y_grid, z_grid,
    shade = 0.5, lighting = TRUE,
    main = "shade = 0.5"
)
surf3D(x_grid, y_grid, z_grid,
    shade = 0.9, lighting = TRUE,
    main = "shade = 0.9"
)
surf3D(x_grid, y_grid, z_grid,
    shade = NA, lighting = FALSE,
    main = "No shading"
)

par(mfrow = c(1, 1))

cat("shade: controls shading intensity (0-1, or NA for none)\n")
cat("lighting: TRUE/FALSE for lighting effects\n")

# Light parameters
surf3D(x_grid, y_grid, z_grid,
    shade = 0.5,
    lighting = TRUE,
    lphi = 90, # Light angle phi
    ltheta = 0, # Light angle theta
    main = "Custom Light Position"
)

cat("lphi, ltheta: control light source position\n")

# ----------------------------------------------------------------------------
# 3D LINES AND RIBBONS
# ----------------------------------------------------------------------------

cat("\n========== 3D LINES AND RIBBONS ==========\n")

# 3D line plot
t <- seq(0, 10 * pi, length.out = 200)
x_line <- sin(t)
y_line <- cos(t)
z_line <- t

lines3D(x_line, y_line, z_line,
    col = "red", lwd = 3,
    theta = 30, phi = 20,
    main = "3D Parametric Curve"
)

# Ribbon plot
ribbon3D(x_line, y_line, z_line,
    col = jet.col(100),
    along = z_line,
    width = 0.2,
    main = "3D Ribbon"
)

cat("along: variable determining color along ribbon\n")
cat("width: ribbon width\n")

# ----------------------------------------------------------------------------
# 3D ARROWS AND SEGMENTS
# ----------------------------------------------------------------------------

cat("\n========== 3D ARROWS AND VECTORS ==========\n")

# Vector field
x_vec <- seq(-5, 5, length.out = 10)
y_vec <- seq(-5, 5, length.out = 10)
grid <- mesh(x_vec, y_vec)

u <- -grid$y # X component
v <- grid$x # Y component
w <- rep(0, length(u)) # Z component

arrows3D(grid$x, grid$y, 0,
    grid$x + u * 0.3, grid$y + v * 0.3, w,
    col = "blue", lwd = 2,
    length = 0.1, # Arrow head length
    angle = 20, # Arrow head angle
    main = "2D Vector Field in 3D"
)

cat("length: arrow head length\n")
cat("angle: arrow head angle in degrees\n")

# ----------------------------------------------------------------------------
# GEOMETRIC SHAPES
# ----------------------------------------------------------------------------

cat("\n========== 3D GEOMETRIC SHAPES ==========\n")

# Sphere
n <- 50
u <- seq(0, 2 * pi, length.out = n)
v <- seq(0, pi, length.out = n)
sphere_mesh <- mesh(u, v)
x_sphere <- cos(sphere_mesh$x) * sin(sphere_mesh$y)
y_sphere <- sin(sphere_mesh$x) * sin(sphere_mesh$y)
z_sphere <- cos(sphere_mesh$y)

surf3D(x_sphere, y_sphere, z_sphere,
    col = "lightblue", border = NA,
    theta = 30, phi = 30,
    main = "Sphere"
)

# Cylinder
height <- seq(0, 2, length.out = 30)
angle <- seq(0, 2 * pi, length.out = 30)
cyl_mesh <- mesh(height, angle)
x_cyl <- cos(cyl_mesh$y)
y_cyl <- sin(cyl_mesh$y)
z_cyl <- cyl_mesh$x

surf3D(x_cyl, y_cyl, z_cyl,
    col = "coral", border = NA,
    main = "Cylinder"
)

# Torus
R <- 3 # Major radius
r <- 1 # Minor radius
u_tor <- seq(0, 2 * pi, length.out = 50)
v_tor <- seq(0, 2 * pi, length.out = 50)
tor_mesh <- mesh(u_tor, v_tor)
x_tor <- (R + r * cos(tor_mesh$y)) * cos(tor_mesh$x)
y_tor <- (R + r * cos(tor_mesh$y)) * sin(tor_mesh$x)
z_tor <- r * sin(tor_mesh$y)

surf3D(x_tor, y_tor, z_tor,
    col = "purple", border = NA,
    main = "Torus"
)

# Cone
h <- seq(0, 1, length.out = 30)
theta_cone <- seq(0, 2 * pi, length.out = 30)
cone_mesh <- mesh(h, theta_cone)
x_cone <- cone_mesh$x * cos(cone_mesh$y)
y_cone <- cone_mesh$x * sin(cone_mesh$y)
z_cone <- cone_mesh$x

surf3D(x_cone, y_cone, z_cone,
    col = "green", border = NA,
    main = "Cone"
)

cat("border = NA: removes mesh lines\n")
cat("border = 'black': shows mesh wireframe\n")

# ----------------------------------------------------------------------------
# IMAGE AND HISTOGRAM IN 3D
# ----------------------------------------------------------------------------

cat("\n========== 3D HISTOGRAMS AND IMAGES ==========\n")

# 3D histogram
x_hist <- rnorm(1000)
y_hist <- rnorm(1000)
hist3D(
    x = x_hist, y = y_hist,
    breaks = c(15, 15),
    col = jet.col(100),
    theta = 30, phi = 30,
    main = "3D Histogram"
)

cat("breaks: number of bins in each direction\n")

# Image in 3D
volcano_data <- volcano # Built-in dataset
image3D(
    z = volcano_data,
    col = terrain.colors(100),
    colkey = TRUE,
    main = "3D Image Plot"
)

# ============================================================================
# PART 2: rgl PACKAGE - Interactive 3D Graphics
# ============================================================================

cat("\n========== INTERACTIVE 3D WITH rgl ==========\n")

# Open new rgl window
open3d()
bg3d("white") # Background color

# 3D scatter with rgl
x_rgl <- rnorm(100)
y_rgl <- rnorm(100)
z_rgl <- rnorm(100)

plot3d(x_rgl, y_rgl, z_rgl,
    col = rainbow(100),
    size = 8,
    type = "s", # Spheres
    xlab = "X", ylab = "Y", zlab = "Z"
)

cat("rgl opens INTERACTIVE window - you can rotate, zoom with mouse\n")
cat("type options: 'p' (points), 's' (spheres), 'l' (lines), 'h' (line segments to xy plane)\n")

# Add surface to rgl
rgl.close() # Close previous
open3d()
bg3d("lightgray")

x_surf <- seq(-10, 10, length.out = 50)
y_surf <- seq(-10, 10, length.out = 50)
z_surf_grid <- outer(x_surf, y_surf, function(x, y) sin(sqrt(x^2 + y^2)) / sqrt(x^2 + y^2 + 1))

surface3d(x_surf, y_surf, z_surf_grid,
    col = "skyblue",
    alpha = 0.7 # Transparency
)

cat("alpha: transparency (0 = transparent, 1 = opaque)\n")

# Add axes
axes3d(col = "black", lwd = 2)
title3d(main = "Interactive Surface", xlab = "X", ylab = "Y", zlab = "Z")

# ----------------------------------------------------------------------------
# rgl ANIMATION AND ROTATION
# ----------------------------------------------------------------------------

cat("\n========== rgl ROTATION AND ANIMATION ==========\n")

# Set viewing angle
rgl.viewpoint(theta = 30, phi = 30, fov = 60, zoom = 0.8)

cat("theta, phi: viewing angles\n")
cat("fov: field of view (smaller = more zoomed)\n")
cat("zoom: zoom factor\n")

# Animate rotation (run this to see animation)
# play3d(spin3d(axis = c(0, 0, 1), rpm = 10), duration = 6)

cat("spin3d: creates spinning animation\n")
cat("axis: rotation axis (x, y, z)\n")
cat("rpm: rotations per minute\n")

# ----------------------------------------------------------------------------
# rgl ADVANCED FEATURES
# ----------------------------------------------------------------------------

cat("\n========== rgl ADVANCED FEATURES ==========\n")

rgl.close()
open3d()
bg3d("white")

# Multiple surfaces with transparency
x1 <- seq(-2, 2, length.out = 30)
y1 <- seq(-2, 2, length.out = 30)
z1 <- outer(x1, y1, function(x, y) x^2 + y^2)
z2 <- outer(x1, y1, function(x, y) -(x^2 + y^2) + 8)

surface3d(x1, y1, z1, col = "red", alpha = 0.5)
surface3d(x1, y1, z2, col = "blue", alpha = 0.5)
title3d("Two Overlapping Paraboloids")

# Add spheres at specific points
spheres3d(c(0, 0), c(0, 0), c(0, 8),
    radius = 0.2,
    col = c("yellow", "green")
)

# Add lines
lines3d(c(-2, 2), c(0, 0), c(4, 4), col = "black", lwd = 3)

cat("spheres3d: add spheres at specific coordinates\n")
cat("lines3d: add lines connecting points\n")

# Add text
text3d(0, 0, 5, "Intersection", col = "purple", cex = 1.5)

cat("text3d: add 3D text labels\n")
cat("cex: text size\n")

# ============================================================================
# PART 3: plotly PACKAGE - Interactive Web-based 3D
# ============================================================================

cat("\n========== INTERACTIVE WEB 3D WITH plotly ==========\n")

# 3D scatter with plotly
plot_ly(
    x = ~ rnorm(100), y = ~ rnorm(100), z = ~ rnorm(100),
    type = "scatter3d", mode = "markers",
    marker = list(
        size = 5, color = ~ rnorm(100),
        colorscale = "Viridis", showscale = TRUE
    )
) %>%
    layout(title = "Plotly 3D Scatter")

cat("plotly creates interactive HTML plots viewable in browser\n")
cat("Features: rotate, pan, zoom, hover for values\n")

# 3D surface with plotly
z_plotly <- volcano
plot_ly(
    z = ~z_plotly, type = "surface",
    colorscale = "Earth"
) %>%
    layout(
        title = "Plotly 3D Surface",
        scene = list(
            camera = list(
                eye = list(x = 1.5, y = 1.5, z = 1.5)
            )
        )
    )

cat("camera$eye: sets viewing position (x, y, z)\n")
cat("colorscale options: 'Viridis', 'Earth', 'Jet', 'Hot', 'Bluered'\n")

# Multiple 3D traces
t <- seq(0, 10, length.out = 100)
plot_ly() %>%
    add_trace(
        x = ~ sin(t), y = ~ cos(t), z = ~t,
        type = "scatter3d", mode = "lines",
        line = list(color = "red", width = 3),
        name = "Helix 1"
    ) %>%
    add_trace(
        x = ~ sin(t + pi / 2), y = ~ cos(t + pi / 2), z = ~t,
        type = "scatter3d", mode = "lines",
        line = list(color = "blue", width = 3),
        name = "Helix 2"
    ) %>%
    layout(title = "Double Helix")

# ----------------------------------------------------------------------------
# COMPLEX STRUCTURES AND FRACTALS
# ----------------------------------------------------------------------------

cat("\n========== COMPLEX 3D STRUCTURES ==========\n")

# 3D Mandelbrot-like structure
mandel_3d <- function(xlim = c(-2, 1), ylim = c(-1.5, 1.5), zlim = c(0, 2),
                      n = 50, max_iter = 20) {
    x <- seq(xlim[1], xlim[2], length.out = n)
    y <- seq(ylim[1], ylim[2], length.out = n)
    z <- seq(zlim[1], zlim[2], length.out = n)

    result <- array(0, dim = c(n, n, n))

    for (i in seq_along(x)) {
        for (j in seq_along(y)) {
            c_val <- complex(real = x[i], imaginary = y[j])
            z_val <- 0
            iter <- 0
            while (abs(z_val) < 2 && iter < max_iter) {
                z_val <- z_val^2 + c_val
                iter <- iter + 1
            }
            result[i, j, ] <- iter
        }
    }
    return(result)
}

# Knot structure
knot_3d <- function(n = 200) {
    t <- seq(0, 2 * pi, length.out = n)
    r <- cos(2 * t) + 2
    x <- r * cos(3 * t)
    y <- r * sin(3 * t)
    z <- sin(4 * t)
    return(data.frame(x = x, y = y, z = z))
}

knot_data <- knot_3d()
lines3D(knot_data$x, knot_data$y, knot_data$z,
    col = jet.col(200),
    colvar = seq_along(knot_data$x),
    lwd = 3,
    main = "3D Knot Structure"
)

# Lorenz attractor
lorenz <- function(a = 10, b = 28, c = 8 / 3, n = 5000, dt = 0.01) {
    x <- y <- z <- numeric(n)
    x[1] <- y[1] <- z[1] <- 1

    for (i in 2:n) {
        x[i] <- x[i - 1] + a * (y[i - 1] - x[i - 1]) * dt
        y[i] <- y[i - 1] + (x[i - 1] * (b - z[i - 1]) - y[i - 1]) * dt
        z[i] <- z[i - 1] + (x[i - 1] * y[i - 1] - c * z[i - 1]) * dt
    }

    return(data.frame(x = x, y = y, z = z))
}

attractor <- lorenz()
lines3D(attractor$x, attractor$y, attractor$z,
    col = rainbow(nrow(attractor)),
    colvar = seq_len(nrow(attractor)),
    lwd = 0.5,
    theta = 40, phi = 20,
    main = "Lorenz Attractor"
)

# ----------------------------------------------------------------------------
# SAVING 3D PLOTS
# ----------------------------------------------------------------------------

cat("\n========== SAVING 3D PLOTS ==========\n")

# Save plot3D output (standard R graphics)
# png("surface_plot.png", width = 800, height = 600)
# surf3D(x_grid, y_grid, z_grid)
# dev.off()

# Save rgl output
# rgl.snapshot("rgl_plot.png")
# rgl.postscript("rgl_plot.pdf", fmt = "pdf")

# Save plotly as HTML
# htmlwidgets::saveWidget(plotly_obj, "plotly_plot.html")

cat("plot3D: use standard png(), pdf(), etc.\n")
cat("rgl: use rgl.snapshot() or rgl.postscript()\n")
cat("plotly: use htmlwidgets::saveWidget()\n")

# ----------------------------------------------------------------------------
# PARAMETER SUMMARY
# ----------------------------------------------------------------------------

cat("\n========== COMPREHENSIVE PARAMETER REFERENCE ==========\n")
cat("\nVIEWING ANGLES:\n")
cat("  theta: 0-360, azimuthal rotation\n")
cat("  phi: 0-90, vertical tilt\n")
cat("  fov: field of view (rgl)\n")
cat("  zoom: zoom factor (rgl)\n")

cat("\nCOLORS:\n")
cat("  col: color specification\n")
cat("  colvar: variable determining color\n")
cat("  colkey: TRUE/FALSE show color legend\n")
cat("  alpha: 0-1, transparency\n")

cat("\nSHADING/LIGHTING:\n")
cat("  shade: 0-1 or NA, shading intensity\n")
cat("  lighting: TRUE/FALSE\n")
cat("  lphi, ltheta: light source angles\n")

cat("\nBOXES/AXES:\n")
cat("  box: TRUE/FALSE, bounding box\n")
cat("  bty: box type ('b', 'b2', 'g', 'f', etc.)\n")
cat("  ticktype: 'simple' or 'detailed'\n")

cat("\nSIZE/SCALE:\n")
cat("  cex: point/text size\n")
cat("  lwd: line width\n")
cat("  expand: axis scale factor\n")

cat("\nSPECIAL:\n")
cat("  border: mesh line color or NA\n")
cat("  add: TRUE to overlay on existing plot\n")
cat("  along: color variable for ribbons\n")

cat("\n========== 3D PLOTTING GUIDE COMPLETE ==========\n")
