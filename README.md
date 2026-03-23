# R and Bash Learning Repository

Programming scripts and documentation for R statistical computing and Bash shell scripting.

## Overview

Educational repository covering R programming, Bash scripting, terminal commands, Vim, and SSH.

## Contents

### R Programming

Statistical computing, data analysis, and mathematical scripts.

| Directory | Contents |
|-----------|----------|
| `Basics/` | Variables, operators, loops, conditionals, sequences, user input, calculator |
| `Data-Structures/` | Vectors, lists, matrices, data frames, strings |
| `Functions/` | Custom functions, closures, functional programming |
| `Data-Visualization/` | Base R plots, ggplot2, 3D graphics |
| `Algorithms/` | Sorting (quicksort), searching (binary search), dynamic programming (Fibonacci), numerical methods, statistical algorithms (k-means, linear regression, hypothesis testing) |
| `Advanced/` | Linear algebra, basis & dimension, eigenvalues, linear transformations, differential equations, differentiation, integration, non-linear equations, system of equations, OOP |
| `Statistics/` | Descriptive stats, ANOVA, statistical inference |
| `Assignment/` | Problem set and solutions |

[View R Directory](./R/)

### Bash Scripting

Shell automation, system administration, and algorithm implementations.

| Directory | Contents |
|-----------|----------|
| `Basics/` | Variables, control flow, loops, number theory, arithmetic, unit conversion, statistics |
| `Text-Processing/` | grep/sed/awk, CSV parsing, log analysis, word frequency, pattern extraction |
| `File-Operations/` | Batch operations, duplicate finder, log rotator, integrity checker, file organizer |
| `System-Administration/` | Disk monitor, health dashboard, backup rotation, network monitor, user audit |
| `Algorithms/` | Bubble sort, string algorithms, merge sort, binary search, GCD/LCM, sieve, Tower of Hanoi |
| `Assignment/` | 22 UNIX shell script problems with solutions |

[View Bash Directory](./Bash/)

### Terminal Commands

Essential Linux command reference and usage guides.

[View Terminal Directory](./Terminal/)

### Vim Editor

Vim commands, configuration, workflow documentation, and assignments.

[View Vim Directory](./Vim/)

### SSH and Remote Access

SSH configuration, file transfer, and security practices.

[View SSH Directory](./SSH/)

## Usage

### R Scripts
```bash
Rscript script.r
# or interactively
R
> source("script.r")
```

### Bash Scripts
```bash
chmod +x script.sh
./script.sh

# Source to use individual functions
source script.sh && function_name
```

## Repository Structure
```
.
├── R/                      # R programming
│   ├── Basics/
│   ├── Data-Structures/
│   ├── Functions/
│   ├── Data-Visualization/
│   ├── Algorithms/
│   ├── Advanced/
│   ├── Statistics/
│   └── Assignment/
├── Bash/                   # Bash scripting
│   ├── Basics/
│   ├── Text-Processing/
│   ├── File-Operations/
│   ├── System-Administration/
│   ├── Algorithms/
│   └── Assignment/
├── Terminal/               # Terminal commands reference
├── Vim/                    # Vim documentation
└── SSH/                    # SSH guides
```

## License

Educational use. Free to use and modify.
