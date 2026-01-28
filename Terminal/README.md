# Linux Terminal Commands Reference

Quick reference guide for essential Linux terminal commands.

## Navigation

| Command | Description | Example |
|---------|-------------|---------|
| `pwd` | Print working directory | `pwd` |
| `ls` | List directory contents | `ls -lah` |
| `cd` | Change directory | `cd /home/user` |
| `cd ..` | Go up one directory | `cd ..` |
| `cd ~` | Go to home directory | `cd ~` |
| `cd -` | Go to previous directory | `cd -` |

### ls Options
- `-l` - Long format with details
- `-a` - Show hidden files
- `-h` - Human-readable file sizes
- `-R` - Recursive listing
- `-t` - Sort by modification time
- `-S` - Sort by file size

## File Management

| Command | Description | Example |
|---------|-------------|---------|
| `touch` | Create empty file | `touch file.txt` |
| `mkdir` | Create directory | `mkdir -p dir/subdir` |
| `cp` | Copy files/directories | `cp -r src/ dest/` |
| `mv` | Move/rename files | `mv old.txt new.txt` |
| `rm` | Remove files | `rm file.txt` |
| `rm -r` | Remove directory | `rm -r directory/` |
| `rm -rf` | Force remove directory | `rm -rf directory/` |
| `rmdir` | Remove empty directory | `rmdir emptydir` |

## File Viewing

| Command | Description | Example |
|---------|-------------|---------|
| `cat` | Display file contents | `cat file.txt` |
| `less` | View file with pagination | `less file.txt` |
| `more` | View file page by page | `more file.txt` |
| `head` | View first 10 lines | `head -n 20 file.txt` |
| `tail` | View last 10 lines | `tail -n 20 file.txt` |
| `tail -f` | Follow file (live updates) | `tail -f log.txt` |

## Search & Find

| Command | Description | Example |
|---------|-------------|---------|
| `grep` | Search in files | `grep "pattern" file.txt` |
| `find` | Find files | `find . -name "*.txt"` |
| `locate` | Quick file search | `locate filename` |
| `which` | Find command location | `which python` |

### grep Options
- `-i` - Case-insensitive
- `-r` - Recursive search
- `-n` - Show line numbers
- `-v` - Invert match
- `-c` - Count matches

### find Examples
```bash
find . -name "*.pdf"              # Find PDF files
find . -type f -size +10M         # Files larger than 10MB
find . -type f -mtime -7          # Modified in last 7 days
find . -type f -exec chmod 644 {} \;  # Execute command on results
```

## Permissions

| Command | Description | Example |
|---------|-------------|---------|
| `chmod` | Change permissions | `chmod 755 script.sh` |
| `chown` | Change ownership | `chown user:group file.txt` |
| `chgrp` | Change group | `chgrp group file.txt` |

### Permission Numbers
- `7 = rwx` (read, write, execute)
- `6 = rw-` (read, write)
- `5 = r-x` (read, execute)
- `4 = r--` (read only)
- `0 = ---` (no permissions)

### chmod Examples
```bash
chmod 755 script.sh      # rwxr-xr-x
chmod +x script.sh       # Add execute permission
chmod u+w file.txt       # Add write for user
chmod go-w file.txt      # Remove write for group/others
chmod -R 644 dir/        # Recursive
```

## Process Management

| Command | Description | Example |
|---------|-------------|---------|
| `ps` | List processes | `ps aux` |
| `top` | Interactive process viewer | `top` |
| `htop` | Better process viewer | `htop` |
| `kill` | Terminate process | `kill -9 PID` |
| `pkill` | Kill by name | `pkill firefox` |
| `killall` | Kill all instances | `killall chrome` |
| `bg` | Send to background | `bg %1` |
| `fg` | Bring to foreground | `fg %1` |
| `jobs` | List background jobs | `jobs` |
| `nohup` | Run immune to hangups | `nohup command &` |

### Process Signals
- `-1 (HUP)` - Hang up
- `-2 (INT)` - Interrupt (Ctrl+C)
- `-9 (KILL)` - Force kill
- `-15 (TERM)` - Terminate gracefully

## Disk Usage

| Command | Description | Example |
|---------|-------------|---------|
| `df` | Disk space | `df -h` |
| `du` | Directory size | `du -sh *` |
| `du -h` | Human-readable sizes | `du -h --max-depth=1` |
| `ncdu` | Interactive disk usage | `ncdu` |

## Package Management

### Debian/Ubuntu (apt)
```bash
sudo apt update                    # Update package list
sudo apt upgrade                   # Upgrade packages
sudo apt install package          # Install
sudo apt remove package           # Remove
sudo apt search keyword          # Search
sudo apt autoremove              # Remove unused packages
```

### Red Hat/CentOS (yum/dnf)
```bash
sudo yum update                   # Update all
sudo yum install package         # Install
sudo yum remove package          # Remove
```

### Arch Linux (pacman)
```bash
sudo pacman -Syu                  # Update all
sudo pacman -S package           # Install
sudo pacman -R package           # Remove
```

## Networking

| Command | Description | Example |
|---------|-------------|---------|
| `ping` | Test connectivity | `ping google.com` |
| `curl` | Transfer data from URL | `curl https://api.example.com` |
| `wget` | Download files | `wget https://file.com/file.zip` |
| `ifconfig` | Network interfaces | `ifconfig` |
| `ip` | Show/manipulate routing | `ip addr` |
| `netstat` | Network statistics | `netstat -tuln` |
| `ss` | Socket statistics | `ss -tuln` |
| `nslookup` | DNS lookup | `nslookup domain.com` |
| `dig` | DNS information | `dig domain.com` |

## System Information

| Command | Description | Example |
|---------|-------------|---------|
| `uname -a` | System information | `uname -a` |
| `hostname` | Computer name | `hostname` |
| `whoami` | Current user | `whoami` |
| `who` | Logged in users | `who` |
| `uptime` | System uptime | `uptime` |
| `date` | Current date/time | `date` |
| `free -h` | Memory usage | `free -h` |
| `lscpu` | CPU information | `lscpu` |

## Shortcuts

| Shortcut | Description |
|----------|-------------|
| `Ctrl+C` | Kill current process |
| `Ctrl+Z` | Suspend process |
| `Ctrl+D` | Exit/logout |
| `Ctrl+L` | Clear screen |
| `Ctrl+A` | Move to beginning of line |
| `Ctrl+E` | Move to end of line |
| `Ctrl+U` | Clear line before cursor |
| `Ctrl+K` | Clear line after cursor |
| `Ctrl+R` | Search command history |
| `!!` | Repeat last command |
| `!$` | Last argument of previous command |

## Piping & Redirection

```bash
command > file.txt           # Redirect stdout to file (overwrite)
command >> file.txt          # Redirect stdout to file (append)
command 2> errors.txt        # Redirect stderr to file
command &> output.txt        # Redirect both stdout and stderr
command < input.txt          # Read from file
command1 | command2          # Pipe output to another command
command > /dev/null 2>&1    # Suppress all output
```

## Useful Combinations

```bash
# Find and delete files
find . -name "*.tmp" -delete

# Count files in directory
ls -1 | wc -l

# Find largest files
du -ah | sort -h | tail -20

# Monitor log file
tail -f /var/log/syslog | grep error

# Archive and compress
tar -czf archive.tar.gz directory/

# Extract archive
tar -xzf archive.tar.gz

# Find process and kill
ps aux | grep process_name | awk '{print $2}' | xargs kill
```

---

**Tip**: Use `man command` or `command --help` to learn more about any command.
