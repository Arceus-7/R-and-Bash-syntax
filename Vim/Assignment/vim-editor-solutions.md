# UNIX VI Editor - Assignment Solutions

Complete step-by-step solutions for all Vim tasks with commands and explanations.

---

## Task 1: Open and Create File

**Steps:**
1. Open terminal
2. Create a file named `vi_student.txt`:
   ```bash
   vi vi_student.txt
   ```
3. Enter **Insert Mode** and type:
   ```
   Name: Your Name
   Course: BSc Mathematics
   College: XYZ College
   ```
4. Save and exit

**Commands Used:**
- `i` - Enter insert mode
- `Esc` - Exit insert mode (return to normal mode)
- `:w` - Save the file
- `:q` - Quit vim
- `:wq` - Save and quit (combined)

**Alternative ways to save and exit:**
- `:x` - Save and exit (only saves if changes were made)
- `ZZ` - Save and exit (normal mode command)
- `:q!` - Quit without saving (force quit)

---

## Task 2: Append Text

**Steps:**
1. Open the same file:
   ```bash
   vi vi_student.txt
   ```
2. Add the following text:
   ```
   Subject: UNIX
   Editor: VI
   ```

**Command Used:**
- `A` - Append at end of line (capital A)

**Other append options:**
- `a` - Append after cursor
- `A` - Append at end of current line
- `o` - Open new line below and append
- `O` - Open new line above and append

---

## Task 3: Modify Text

**Goal:**
- Change "UNIX" to "UNIX/Linux"
- Change "VI" to "VIM"

**Commands:**

**Method 1: Using Search and Replace**
```vim
/word          " Search for 'word'
:s/old/new/    " Replace old with new on current line
```

**For this task:**
```vim
/UNIX          " Search for UNIX
n              " Go to next occurrence (if needed)
cw             " Change word
UNIX/Linux     " Type new text
Esc            " Exit insert mode

/VI            " Search for VI
cw             " Change word
VIM            " Type new text
Esc            " Exit insert mode
```

**Method 2: Using Global Replace**
```vim
:%s/UNIX/UNIX\/Linux/g    " Replace all UNIX with UNIX/Linux
:%s/VI/VIM/g              " Replace all VI with VIM
```

---

## Task 4: Delete and Undo

**Steps:**
1. Delete one full line
2. Undo the deletion

**Commands:**
- `dd` - Delete current line
- `u` - Undo last change

**Other delete commands:**
- `x` - Delete character under cursor
- `dw` - Delete word
- `D` - Delete from cursor to end of line
- `d$` - Delete to end of line
- `d0` - Delete to beginning of line
- `3dd` - Delete 3 lines

**Redo:**
- `Ctrl+r` - Redo (opposite of undo)

---

## Task 5: Copy and Delete Lines

**Add these 3 lines first:**
```
Linux is powerful.
Linux is secure.
Linux is open-source.
```

**Tasks:**
- Copy the first Linux line and paste it twice
- Delete one duplicate

**Commands:**
- `yy` - Yank (copy) current line
- `p` - Paste below current line
- `P` - Paste above current line
- `dd` - Delete line

**Step-by-step:**
```vim
yy    " Yank the first Linux line
p     " Paste below (first copy)
p     " Paste again (second copy)
dd    " Delete one duplicate
```

**Other copy commands:**
- `yw` - Yank word
- `y$` - Yank to end of line
- `3yy` - Yank 3 lines

---

## Task 6: Replace All Occurrences

**Goal:** Replace all "Linux" with "GNU/Linux"

**Command:**
```vim
:%s/Linux/GNU\/Linux/g
```

**Breakdown:**
- `:` - Enter command mode
- `%` - Apply to all lines (entire file)
- `s` - Substitute
- `/Linux/` - Pattern to find
- `/GNU\/Linux/` - Replacement (backslash escapes the forward slash)
- `/g` - Global flag (all occurrences on each line)

**Variations:**
```vim
:s/Linux/GNU\/Linux/       " Replace first occurrence on current line only
:%s/Linux/GNU\/Linux/      " Replace first occurrence on each line
:%s/Linux/GNU\/Linux/gc    " Replace all with confirmation for each
```

---

## Task 7: Navigation and Line Numbers

**Tasks:**
1. Go to first line
2. Go to last line
3. Show line numbers
4. Save file as `final.txt`

**Commands:**
- `gg` - Go to first line
- `G` - Go to last line
- `:set nu` - Show line numbers
- `:w final.txt` - Save as final.txt

**Additional navigation:**
- `1G` or `:1` - Go to line 1
- `50G` or `:50` - Go to line 50
- `$` - Go to end of current line
- `0` or `^` - Go to beginning of current line
- `w` - Move to next word
- `b` - Move to previous word
- `Ctrl+f` - Page down
- `Ctrl+b` - Page up

**Line number options:**
- `:set nu` - Show line numbers
- `:set nonu` - Hide line numbers
- `:set relativenumber` - Show relative line numbers

## Expected Final File Content (final.txt)

```
Name: Your Name
Course: BSc Mathematics
College: XYZ College
Subject: UNIX/Linux
Editor: VIM
GNU/Linux is powerful.
GNU/Linux is secure.
GNU/Linux is open-source.
```

