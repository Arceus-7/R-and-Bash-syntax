# Bash Scripting

Shell scripting for automation, text processing, and system administration.

## Directory Structure

### Basics
Variables, arrays, strings, arithmetic, control flow, number theory.

| Script | Description |
|--------|-------------|
| `variables.sh` | Variables, arrays, strings, arithmetic, special variables |
| `control-flow.sh` | Time greetings, string comparison, multiplication table, odd/even list, loop patterns, case statements |
| `number-theory.sh` | Perfect numbers, number reversal, prime factors, Armstrong numbers, digital root, neon numbers |
| `advanced-arithmetic.sh` | Compound interest, quadratic solver, unit converter, statistics, base converter, EMI calculator |

### Text-Processing
String manipulation, grep, sed, awk, CSV parsing, log analysis.

| Script | Description |
|--------|-------------|
| `grep-examples.sh` | grep patterns, regex, filtering |
| `advanced-text-processing.sh` | CSV tools, word frequency, log analyzer, search-replace, pattern extractor |

### File-Operations
Batch file operations, search utilities, backup scripts, integrity checking.

| Script | Description |
|--------|-------------|
| `batch-rename.sh` | Batch file renaming |
| `advanced-file-ops.sh` | Directory tree, duplicate finder, log rotator, integrity checker, file organizer |

### System-Administration
Disk monitoring, process management, health dashboards, user auditing.

| Script | Description |
|--------|-------------|
| `disk-monitor.sh` | Disk usage monitoring and alerts |
| `advanced-system-admin.sh` | System health, backup rotation, network monitor, service checker, user audit |

### Algorithms
Sorting, searching, string manipulation, mathematical algorithms.

| Script | Description |
|--------|-------------|
| `Sorting/bubble-sort.sh` | Bubble sort implementation |
| `String-Manipulation/string-algorithms.sh` | String manipulation algorithms |
| `advanced-algorithms.sh` | Merge sort, binary search, GCD/LCM, sieve of Eratosthenes, tower of Hanoi, matrix operations |

### Assignment
UNIX shell script assignment — 22 questions covering arithmetic, file ops, system tools, sorting, and more.

| Script | Description |
|--------|-------------|
| `assignment-solutions.sh` | All 22 assignment solutions as callable functions |

## Usage

```bash
# Make executable
chmod +x script.sh

# Execute
./script.sh

# Source and call individual functions
source assignment-solutions.sh && q1_odd_even
source number-theory.sh && is_perfect
source control-flow.sh && multiplication_table 7
```

## Script Conventions

All scripts use `#!/bin/bash` and define functions that can be sourced independently.

## Learning Path

1. Basics — Core syntax, control flow, number operations
2. Text-Processing — Text manipulation tools
3. File-Operations — File system operations
4. Algorithms — Algorithm implementations
5. System-Administration — System management tasks
6. Assignment — Practice problems with solutions
