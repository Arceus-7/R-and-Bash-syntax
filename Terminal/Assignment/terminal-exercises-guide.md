# Lab Exercises UNIX/LINUX - Solutions Guide

Complete solutions and explanations for all 35 terminal exercises.

---

## Exercise Solutions

### 1. Login to the system
**Command:**
```bash
# Local login: Use system login prompt
# Remote login:
ssh username@hostname
```

---

### 2. Find out the users currently logged in
**Commands:**
```bash
who                    # Show all logged in users
who | grep "username"  # Find specific user
w                      # Detailed information about users
users                  # Simple list of usernames
```

---

### 3. Display the calendar

**(i) Jan 2026**
```bash
cal 1 2026
```

**(ii) Feb 1999**
```bash
cal 2 1999
```

**(iii) 9th month of year 7 A.D**
```bash
cal 9 7
```

**(iv) For the current month**
```bash
cal
```

**(v) Current Date with abbreviations**
```bash
date +"%a, %b %Y"
# Output: Sat, Feb 2026
```

**Date Format Options:**
- `%a` - Abbreviated weekday (Mon, Tue, etc.)
- `%A` - Full weekday (Monday, Tuesday, etc.)
- `%b` - Abbreviated month (Jan, Feb, etc.)
- `%B` - Full month (January, February, etc.)
- `%Y` - Year (4 digits)
- `%y` - Year (2 digits)

---

### 4. Display time in 12-Hour and 24-Hour formats

**12-Hour format:**
```bash
date +"%I:%M:%S %p"
# Output: 09:30:45 AM
```

**24-Hour format:**
```bash
date +"%H:%M:%S"
# Output: 09:30:45
```

---

### 5. Display Current Date and Time
```bash
date
# Output: Sat Feb 08 09:30:45 IST 2026
```

---

### 6. Display "GOOD MORNING" in enlarged characters

**Using banner:**
```bash
banner GOOD MORNING
```

**Using figlet (more common):**
```bash
figlet GOOD MORNING
```

**Install if not available:**
```bash
sudo apt install figlet     # Debian/Ubuntu
sudo yum install figlet     # CentOS/RHEL
```

---

### 7. Display home directory name
```bash
echo $HOME
# or
echo ~
# or
pwd  # (if you're in home directory)
```

---

### 8. Create directory SAMPLE under home
```bash
mkdir ~/SAMPLE
# or
mkdir $HOME/SAMPLE
```

**Verify:**
```bash
ls -ld ~/SAMPLE
```

---

### 9. Create sub-directory TRIAL under SAMPLE
```bash
mkdir ~/SAMPLE/TRIAL
# or create parent and child together
mkdir -p ~/SAMPLE/TRIAL
```

---

### 10. Change to SAMPLE
```bash
cd ~/SAMPLE
# Verify
pwd
```

---

### 11. Change to home directory
```bash
cd
# or
cd ~
# or
cd $HOME
```

---

### 12. Change to TRIAL using absolute and relative paths

**Using absolute pathname:**
```bash
cd ~/SAMPLE/TRIAL
# or
cd /home/username/SAMPLE/TRIAL
```

**Using relative pathname (from home):**
```bash
cd SAMPLE/TRIAL
```

---

### 13. Remove directory TRIAL
```bash
cd ~/SAMPLE
rmdir TRIAL
```

**Note:** `rmdir` only works on empty directories.

---

### 14. Create TEST using absolute pathname
```bash
mkdir ~/TEST
# or
mkdir /home/username/TEST
```

---

### 15. Change to home using single command
```bash
cd
```

**Other options:**
```bash
cd ~
cd $HOME
```

---

### 16. Remove directory using absolute pathname
```bash
rmdir ~/TEST
# or
rmdir /home/username/TEST
```

---

### 17. Create files myfile and yourfile
```bash
cd ~/SAMPLE
touch myfile yourfile
```

**Alternatives:**
```bash
> myfile      # Create empty file
cat > myfile  # Create and add content (Ctrl+D to save)
```

---

### 18. Display files myfile and yourfile
```bash
cat myfile
cat yourfile
```

**Other display commands:**
```bash
more myfile   # Page-by-page view
less myfile   # Better pager
head myfile   # First 10 lines
tail myfile   # Last 10 lines
```

---

### 19. Append lines to files
```bash
echo "Line 1" >> myfile
echo "Line 2" >> myfile
cat >> yourfile << EOF
Line 1
Line 2
EOF
```

**Note:** 
- `>` overwrites file
- `>>` appends to file

---

### 20. Create a hidden file
```bash
touch .hiddenfile
```

**View hidden files:**
```bash
ls -a      # Show all including hidden
ls -la     # Long format with hidden
```

**Rule:** Files starting with `.` are hidden in Linux.

---

### 21. Copy myfile to emp
```bash
cp myfile emp
```

**Options:**
```bash
cp -i myfile emp   # Interactive (prompt before overwrite)
cp -v myfile emp   # Verbose (show what's being done)
```

---

### 22. Create alias for a command
```bash
alias ll='ls -la'
alias cls='clear'
alias ..='cd ..'
```

**Make permanent (add to ~/.bashrc):**
```bash
echo "alias ll='ls -la'" >> ~/.bashrc
source ~/.bashrc
```

**View all aliases:**
```bash
alias
```

**Remove alias:**
```bash
unalias ll
```

---

### 23. Move yourfile to dept
```bash
mv yourfile dept
```

**Note:** `mv` is used for both moving and renaming files.

---

### 24. Copy emp and dept to TRIAL
```bash
cp emp dept ~/SAMPLE/TRIAL/
# or
cp emp ~/SAMPLE/TRIAL/
cp dept ~/SAMPLE/TRIAL/
```

---

### 25. Compare a file with itself
```bash
cmp myfile myfile
```

**Result:** No output (files are identical). Exit code 0.

---

### 26. Compare myfile and emp
```bash
cmp myfile emp
```

**Alternative:**
```bash
diff myfile emp
```

---

### 27. Append lines to emp in TRIAL
```bash
echo "New line 1" >> ~/SAMPLE/TRIAL/emp
echo "New line 2" >> ~/SAMPLE/TRIAL/emp
```

---

### 28. Compare emp files
```bash
cmp emp ~/SAMPLE/TRIAL/emp
```

**Output:** Shows first byte and line where files differ.

---

### 29. Find difference between files
```bash
diff emp ~/SAMPLE/TRIAL/emp
```

**Useful diff options:**
```bash
diff -u file1 file2    # Unified format (like git diff)
diff -y file1 file2    # Side-by-side comparison
diff -c file1 file2    # Context format
```

---

### 30. Remove files in TRIAL directory
```bash
rm ~/SAMPLE/TRIAL/*
```

**Caution:** This deletes all files in TRIAL!

**Safer alternatives:**
```bash
rm -i ~/SAMPLE/TRIAL/*    # Interactive (prompt for each file)
rm ~/SAMPLE/TRIAL/file1   # Remove specific file
```

---

### 31. Remove directory with files in single command
```bash
rm -r ~/SAMPLE/TRIAL
# or force remove without confirmation
rm -rf ~/SAMPLE/TRIAL
```

**Options:**
- `-r` or `-R` : Recursive (remove directories)
- `-f` : Force (no confirmation)
- `-i` : Interactive (prompt before deletion)

**Warning:** `rm -rf` is dangerous! Double-check before using.

---

### 32. Recover deleted files
**Answer:** No built-in Linux command to recover deleted files.

**Options:**
1. **Prevention is best:**
   - Use version control (git)
   - Regular backups
   - Use trash instead of rm: `trash-cli`, `gvfs-trash`

2. **Recovery tools (if file just deleted):**
   - `extundelete` - For ext3/ext4 filesystems
   - `testdisk` - Partition recovery
   - `photorec` - File recovery
   - `foremost` - File carving

3. **From backups:**
   - Restore from backup/snapshot
   - Check cloud sync services

---

### 33. Rename TRIAL to DATA
```bash
mv ~/SAMPLE/TRIAL ~/SAMPLE/DATA
```

---

### 34. Copy DATA to new directory TRIAL
```bash
cp -r ~/SAMPLE/DATA ~/SAMPLE/TRIAL
```

**Note:** `-r` (recursive) is required for copying directories.

---

### 35. Create dummy and link to star

**Hard link:**
```bash
touch ~/SAMPLE/TRIAL/dummy
echo "Content" > ~/SAMPLE/TRIAL/dummy
ln ~/SAMPLE/TRIAL/dummy ~/SAMPLE/TRIAL/star
```

**Soft link (symbolic link):**
```bash
ln -s ~/SAMPLE/TRIAL/dummy ~/SAMPLE/TRIAL/star
```

**Differences:**
- **Hard link:** Same inode, same file content, deleting original keeps link
- **Soft link:** Different inode, pointer to original, deleting original breaks link

**Check links:**
```bash
ls -li ~/SAMPLE/TRIAL/dummy ~/SAMPLE/TRIAL/star
```

---

## Additional Practice Commands

### man - Manual pages
```bash
man ls          # Show manual for ls
man man         # Manual for man command
man -k search   # Search manuals
```

### ls - List directory contents
```bash
ls              # Basic list
ls -l           # Long format (permissions, size, date)
ls -a           # Show hidden files
ls -lh          # Human-readable sizes
ls -lt          # Sort by time (newest first)
ls -lS          # Sort by size (largest first)
ls -R           # Recursive (show subdirectories)
ls -i           # Show inode numbers
```

### pwd - Print working directory
```bash
pwd             # Show current directory
pwd -P          # Physical path (resolve symlinks)
```

### chmod - Change file permissions
```bash
chmod 755 file           # rwxr-xr-x
chmod 644 file           # rw-r--r--
chmod +x file            # Add execute for all
chmod u+w file           # Add write for user
chmod g-w file           # Remove write for group
chmod o+r file           # Add read for others
chmod -R 755 directory   # Recursive
```

**Permission numbers:**
- 4 = read (r)
- 2 = write (w)
- 1 = execute (x)

**Examples:**
- 7 (4+2+1) = rwx
- 6 (4+2) = rw-
- 5 (4+1) = r-x
- 4 = r--

### mv - Move or rename
```bash
mv oldname newname       # Rename
mv file /path/           # Move to directory
mv -i file /path/        # Interactive (prompt before overwrite)
mv -n file /path/        # No overwrite
mv *.txt /path/          # Move multiple files
```

### cp - Copy files
```bash
cp file1 file2           # Copy file
cp -r dir1 dir2          # Copy directory recursively
cp -i file1 file2        # Interactive
cp -u file1 file2        # Update (copy if newer)
cp -p file1 file2        # Preserve attributes
cp -v file1 file2        # Verbose
```

---

## Quick Command Reference

| Command | Purpose | Example |
|---------|---------|---------|
| `pwd` | Print working directory | `pwd` |
| `cd` | Change directory | `cd /home` |
| `ls` | List files | `ls -la` |
| `mkdir` | Create directory | `mkdir folder` |
| `rmdir` | Remove empty directory | `rmdir folder` |
| `touch` | Create empty file | `touch file.txt` |
| `cat` | Display file content | `cat file.txt` |
| `cp` | Copy file/directory | `cp -r dir1 dir2` |
| `mv` | Move/rename | `mv old new` |
| `rm` | Remove file/directory | `rm -rf folder` |
| `chmod` | Change permissions | `chmod 755 file` |
| `man` | Manual pages | `man ls` |
| `who` | Show logged users | `who` |
| `date` | Display date/time | `date` |
| `cal` | Display calendar | `cal 2 2026` |

---

## Tips and Best Practices

1. **Always double-check before using `rm -rf`** - No undo!
2. **Use tab completion** - Press Tab to autocomplete filenames
3. **Use up/down arrows** - Navigate command history
4. **Use `Ctrl+C`** - Cancel current command
5. **Use `Ctrl+L` or `clear`** - Clear screen
6. **Read man pages** - `man command` for detailed info
7. **Practice in test directory** - Don't experiment in important directories
8. **Use `-i` for destructive operations** - Prompts before overwriting/deleting

---

**Practice these commands regularly to build muscle memory!**
