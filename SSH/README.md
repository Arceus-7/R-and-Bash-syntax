# SSH & Remote Access

Secure Shell (SSH) guide for connecting to and managing remote servers.

## Basic Connection

```bash
# Basic connection
ssh username@hostname

# Using IP address
ssh username@192.168.1.100

# Specify port
ssh -p 2222 username@hostname

# Verbose output (debugging)
ssh -v username@hostname
ssh -vv username@hostname     # More verbose
ssh -vvv username@hostname    # Maximum verbosity

# Execute command on remote server
ssh username@hostname 'ls -la'
ssh username@hostname 'uptime && df -h'

# Exit SSH session
exit
# or press Ctrl+D
```

## SSH Keys

SSH keys provide secure, password-less authentication.

### Generate SSH Key Pair

```bash
# RSA key
ssh-keygen -t rsa -b NNNN -C "abc@xyz.com"

# Ed25519 key (recommended)
ssh-keygen -t ed25519 -C "abc@xyz.com"

# Follow prompts:
# - Location: Press Enter for default (~/.ssh/id_rsa)
# - Passphrase: Enter passphrase (recommended) or leave empty

# Generate key with custom name
ssh-keygen -t ed25519 -f ~/.ssh/custom_key_name
```

### Copy Public Key to Server

```bash
# Easy method (if ssh-copy-id is available)
ssh-copy-id username@hostname
ssh-copy-id -i ~/.ssh/custom_key.pub username@hostname

# Manual method
cat ~/.ssh/id_rsa.pub | ssh username@hostname "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

# Or manually copy and paste the public key
# On local machine:
cat ~/.ssh/id_rsa.pub

# On remote server:
mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo "paste_public_key_here" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

### Set Correct Permissions

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa         # Private key
chmod 644 ~/.ssh/id_rsa.pub     # Public key
chmod 644 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/config
```

### Use Specific Key

```bash
ssh -i ~/.ssh/custom_key username@hostname
```

## SSH Config File

Create `~/.ssh/config` for connection shortcuts and settings.

### Basic Configuration

```ssh-config
# Simple host
Host myserver
    HostName XXX.XXX.XXX.XXX
    User username
    Port NN
    IdentityFile ~/.ssh/id_rsa

# Now you can simply use: ssh myserver
```

### Advanced Examples

```ssh-config
# GitHub
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_key
    PreferredAuthentications publickey

# Multiple servers with same settings
Host web1 web2 web3
    User admin
    Port NNNN
    IdentityFile ~/.ssh/company_key
    ForwardAgent yes

# Wildcard patterns
Host *.example.com
    User admin
    IdentityFile ~/.ssh/example_key
    StrictHostKeyChecking no

# Jump/Bastion host
Host internal-server
    HostName XX.X.X.XX
    User admin
    ProxyJump bastion.example.com
    # Or use ProxyCommand:
    # ProxyCommand ssh bastion.example.com -W %h:%p

# Default settings for all hosts
Host *
    ServerAliveInterval NN
    ServerAliveCountMax N
    Compression yes
    ControlMaster auto
    ControlPath ~/.ssh/sockets/%r@%h-%p
    ControlPersist NNN
```

## File Transfer

### SCP (Secure Copy)

```bash
# Copy file to remote server
scp file.txt username@hostname:/remote/path/
scp -P NNNN file.txt username@hostname:/path/  # Custom port

# Copy file from remote server
scp username@hostname:/remote/file.txt /local/path/

# Copy directory recursively
scp -r local_directory/ username@hostname:/remote/path/

# Preserve timestamps and permissions
scp -p file.txt username@hostname:/path/

# Copy between two remote servers (via local machine)
scp user1@host1:/file.txt user2@host2:/path/

# Use specific SSH key
scp -i ~/.ssh/custom_key file.txt username@hostname:/path/

# Limit bandwidth (in KB/s)
scp -l NNNN largefile.zip username@hostname:/path/
```

### SFTP (Secure FTP)

```bash
# Connect to SFTP
sftp username@hostname
sftp -P NNNN username@hostname  # Custom port
```

**SFTP Commands:**
```bash
# Navigation
pwd                   # Print remote working directory
lpwd                  # Print local working directory
ls                    # List remote files
lls                   # List local files
cd /path              # Change remote directory
lcd /path             # Change local directory

# File operations
get file.txt          # Download file
get -r directory/     # Download directory
put file.txt          # Upload file
put -r directory/     # Upload directory
mget *.txt            # Download multiple files
mput *.txt            # Upload multiple files

# Directory operations
mkdir dirname         # Create remote directory
lmkdir dirname        # Create local directory
rmdir dirname         # Remove remote directory

# Delete
rm file.txt           # Delete remote file
lrm file.txt          # Delete local file

# Other
!command              # Execute local shell command
help                  # Show help
exit or bye           # Exit SFTP
```

### rsync (Better than SCP for large transfers)

```bash
# Sync directory to remote
rsync -avz local_dir/ username@hostname:/remote_dir/

# Sync from remote to local
rsync -avz username@hostname:/remote_dir/ local_dir/

# Show progress
rsync -avz --progress source/ dest/

# Dry run (see what would be transferred)
rsync -avz --dry-run source/ dest/

# Delete files on destination that don't exist in source
rsync -avz --delete source/ dest/

# Exclude files
rsync -avz --exclude '*.log' --exclude 'temp/' source/ dest/

# Use SSH on custom port
rsync -avz -e "ssh -p NNNN" source/ user@host:/dest/
```

**rsync options:**
- `-a` - Archive mode (preserves permissions, timestamps, etc.)
- `-v` - Verbose
- `-z` - Compress during transfer
- `-h` - Human-readable output
- `-P` - Show progress and keep partial files

## Port Forwarding

### Local Port Forwarding
Access remote service on local port:
```bash
ssh -L local_port:remote_host:remote_port username@ssh_server

# Example: Access remote database locally
ssh -L 3306:localhost:3306 username@dbserver
# Now connect to localhost:3306 to access remote MySQL

# Keep in background
ssh -fN -L NNNN:localhost:NN username@webserver
```

### Remote Port Forwarding
Make local service accessible remotely:
```bash
ssh -R remote_port:local_host:local_port username@ssh_server

# Example: Share local web server
ssh -R 8080:localhost:3000 username@remoteserver
# Now remoteserver:8080 connects to your local:3000
```

### Dynamic Port Forwarding (SOCKS Proxy)
```bash
ssh -D local_port username@ssh_server

# Example: Create SOCKS proxy on port NNNN
ssh -D NNNN username@proxyserver

# Then configure browser to use localhost:NNNN as SOCKS5 proxy
```

## SSH Agent

Manage SSH keys in memory to avoid entering passphrase repeatedly.

```bash
# Start SSH agent
eval "$(ssh-agent -s)"

# Add key to agent
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/custom_key

# Add with timeout (in seconds)
ssh-add -t NNNN ~/.ssh/id_rsa  # N hour

# List loaded keys
ssh-add -l

# List with fingerprints
ssh-add -L

# Remove specific key
ssh-add -d ~/.ssh/id_rsa

# Remove all keys
ssh-add -D
```

### Auto-start SSH Agent (.bashrc or .zshrc)
```bash
# Add to ~/.bashrc or ~/.zshrc
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa 2>/dev/null
fi
```

## Security Best Practices

### Server Configuration (/etc/ssh/sshd_config)

```bash
# Edit SSH daemon config (requires sudo)
sudo vim /etc/ssh/sshd_config

# Recommended settings:
Port NNNN                          # Change default port
PermitRootLogin no                # Disable root login
PasswordAuthentication no         # Force key-based authentication
PubkeyAuthentication yes          # Enable public key auth
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding no                  # Disable X11 unless needed
AllowUsers abc xyz                # Limit allowed users
MaxAuthTries N                    # Limit auth attempts
ClientAliveInterval NNN           # Timeout idle connections
ClientAliveCountMax N

# Restart SSH service after changes
sudo systemctl restart sshd
```

### Additional Security

```bash
# Install fail2ban to block brute-force attempts
sudo apt-get install fail2ban

# Check SSH logs for suspicious activity
sudo tail -f /var/log/auth.log        # Debian/Ubuntu
sudo tail -f /var/log/secure           # Red Hat/CentOS

# Use strong passphrases for SSH keys
# Enable two-factor authentication
# Regularly update SSH software
# Use VPN or IP whitelisting when possible
```

## Troubleshooting

```bash
# Test connection with verbose output
ssh -vvv username@hostname

# Check if SSH service is running
sudo systemctl status sshd

# Verify SSH port is open
nmap -p 22 hostname
nc -zv hostname 22

# Check SSH key permissions
ls -la ~/.ssh/

# Verify authorized_keys on server
cat ~/.ssh/authorized_keys

# Test specific key
ssh -i ~/.ssh/specific_key -vvv username@hostname

# Fix "Too many authentication failures"
ssh -o IdentitiesOnly=yes -i ~/.ssh/specific_key username@hostname

# Clear known_hosts for changed server key
ssh-keygen -R hostname

# Connection timeout issues (add to ~/.ssh/config)
ServerAliveInterval NN
ServerAliveCountMax N
TCPKeepAlive yes
```

## Useful Commands

```bash
# Show SSH server version
ssh -V

# Generate SSH key fingerprint
ssh-keygen -lf ~/.ssh/id_rsa.pub

# Test SSH connection without executing
ssh -T git@github.com

# Monitor active SSH connections
who
w
last

# Kill specific SSH session (on server)
pkill -u username

# Check SSH service status
sudo systemctl status sshd

# View SSH configuration
sshd -T

# Escape sequences (after pressing Enter, then ~)
~.    # Disconnect
~^Z   # Suspend SSH
~#    # List forwarded connections
~?    # Help
```

---

**Always use SSH keys instead of passwords for better security.**
