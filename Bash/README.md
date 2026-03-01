# Bash Scripting

Shell scripting for automation, text processing, and system administration.

## Directory Structure

### Basics
Variables, arrays, control structures, functions, command-line arguments. Advanced arithmetic with compound interest, quadratic equations, unit converters, and statistical calculations.

| Script | Description |
|--------|-------------|
| `variables.sh` | Variables, arrays, strings, arithmetic, special variables |
| `advanced-arithmetic.sh` | Compound interest, quadratic solver, unit converter, statistics, EMI calculator |

### Text-Processing
String manipulation, grep, sed, awk examples. CSV parsing, log analysis, pattern extraction.

| Script | Description |
|--------|-------------|
| `grep-examples.sh` | grep patterns, regex, filtering |
| `advanced-text-processing.sh` | CSV tools, word frequency, log analyzer, search-replace, pattern extractor |

### File-Operations
Batch file operations, search utilities, backup scripts. Duplicate detection, integrity checking.

| Script | Description |
|--------|-------------|
| `batch-rename.sh` | Batch file renaming |
| `advanced-file-ops.sh` | Directory tree, duplicate finder, log rotator, integrity checker, file organizer |

### System-Administration
Disk monitoring, process management, log processing. Health dashboards, backups, network monitoring.

| Script | Description |
|--------|-------------|
| `disk-monitor.sh` | Disk usage monitoring and alerts |
| `advanced-system-admin.sh` | System health, backup rotation, network monitor, service checker, user audit |

### Algorithms
String manipulation algorithms, sorting implementations, search algorithms, mathematical computations.

| Script | Description |
|--------|-------------|
| `Sorting/bubble-sort.sh` | Bubble sort implementation |
| `String-Manipulation/string-algorithms.sh` | String manipulation algorithms |
| `advanced-algorithms.sh` | Merge sort, binary search, GCD/LCM, sieve, tower of Hanoi, matrix operations |

### Assignment
UNIX shell script assignment solutions — 22 questions covering arithmetic, file operations, system tools, sorting, and more.

| Script | Description |
|--------|-------------|
| `assignment-solutions.sh` | All 22 assignment solutions as callable functions |

## Usage

```bash
# Make executable
chmod +x script.sh

# Execute
./script.sh

# Direct execution
bash script.sh

# Source and call individual functions
source assignment-solutions.sh && q1_odd_even
```

## Script Conventions

All scripts include `#!/bin/bash` shebang for portability.

## Learning Path

1. Basics — Core shell scripting syntax
2. Text-Processing — Text manipulation tools
3. File-Operations — File system operations
4. Algorithms — Algorithm implementations
5. System-Administration — System management tasks
6. Assignment — Practice problems and solutions
