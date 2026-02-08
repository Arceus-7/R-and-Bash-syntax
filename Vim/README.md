# Vim Editor Quick Reference

Master the powerful modal text editor.

## Modes

Vim operates in different modes:

- **Normal Mode** - Default mode for navigation and commands (press `Esc`)
- **Insert Mode** - For typing text (press `i` from Normal)
- **Visual Mode** - For selecting text (press `v` from Normal)
- **Command Mode** - For saving, quitting, etc. (press `:` from Normal)

---

## Quick Reference Card

### Mode Switching
| Command | Description |
|---------|-------------|
| `i` | Insert before cursor |
| `I` | Insert at beginning of line |
| `a` | Append after cursor |
| `A` | Append at end of line |
| `o` | Open new line below |
| `O` | Open new line above |
| `Esc` | Return to normal mode |

### Saving and Quitting
| Command | Description |
|---------|-------------|
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:x` | Save and quit |
| `ZZ` | Save and quit |
| `:q!` | Quit without saving |
| `:w filename` | Save as filename |

### Navigation
| Command | Description |
|---------|-------------|
| `h` | Left |
| `j` | Down |
| `k` | Up |
| `l` | Right |
| `gg` | First line |
| `G` | Last line |
| `0` | Beginning of line |
| `$` | End of line |
| `w` | Next word |
| `b` | Previous word |

### Editing
| Command | Description |
|---------|-------------|
| `x` | Delete character |
| `dd` | Delete line |
| `yy` | Yank (copy) line |
| `p` | Paste below |
| `P` | Paste above |
| `u` | Undo |
| `Ctrl+r` | Redo |
| `cw` | Change word |

### Search and Replace
| Command | Description |
|---------|-------------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `:s/old/new/` | Replace on current line |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace with confirmation |

### Other
| Command | Description |
|---------|-------------|
| `:set nu` | Show line numbers |
| `:set nonu` | Hide line numbers |
| `.` | Repeat last command |
| `v` | Visual mode |
| `V` | Visual line mode |

---

## Getting Started

```bash
# Open file in Vim
vim filename.txt

# Open at specific line
vim +42 filename.txt

# Open multiple files
vim file1.txt file2.txt
```

## Essential Commands

| Command | Description | Mode |
|---------|-------------|------|
| `vim file.txt` | Open file | Shell |
| `i` | Enter Insert mode | Normal |
| `Esc` | Return to Normal mode | Any |
| `:w` | Save file | Command |
| `:q` | Quit Vim | Command |
| `:wq` or `:x` | Save and quit | Command |
| `:q!` | Quit without saving | Command |
| `:w filename` | Save as | Command |

## Navigation (Normal Mode)

### Basic Movement
| Key | Action |
|-----|--------|
| `h` | Left |
| `j` | Down |
| `k` | Up |
| `l` | Right |
| `w` | Next word |
| `b` | Previous word |
| `e` | End of word |
| `0` | Start of line |
| `$` | End of line |
| `gg` | First line |
| `G` | Last line |
| `:n` or `nG` | Go to line n |

### Advanced Movement
| Key | Action |
|-----|--------|
| `Ctrl+f` | Page down |
| `Ctrl+b` | Page up |
| `Ctrl+d` | Half page down |
| `Ctrl+u` | Half page up |
| `{` | Previous paragraph |
| `}` | Next paragraph |
| `%` | Jump to matching bracket |

## Editing (Normal Mode)

### Insert Text
| Key | Action |
|-----|--------|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `I` | Insert at start of line |
| `A` | Insert at end of line |
| `o` | New line below |
| `O` | New line above |

### Delete
| Key | Action |
|-----|--------|
| `x` | Delete character under cursor |
| `X` | Delete character before cursor |
| `dd` | Delete line |
| `dw` | Delete word |
| `d$` or `D` | Delete to end of line |
| `d0` | Delete to start of line |

### Copy & Paste
| Key | Action |
|-----|--------|
| `yy` or `Y` | Copy (yank) line |
| `yw` | Copy word |
| `y$` | Copy to end of line |
| `p` | Paste after cursor |
| `P` | Paste before cursor |

### Undo & Redo
| Key | Action |
|-----|--------|
| `u` | Undo |
| `Ctrl+r` | Redo |
| `.` | Repeat last command |

### Change
| Key | Action |
|-----|--------|
| `r` | Replace single character |
| `R` | Replace mode |
| `cw` | Change word |
| `cc` | Change entire line |
| `C` | Change to end of line |
| `~` | Toggle case |

## Search & Replace

### Search
```vim
/pattern         " Search forward
?pattern         " Search backward
n                " Next result
N                " Previous result
*                " Search word under cursor forward
#                " Search word under cursor backward
```

### Replace
```vim
:s/old/new/              " Replace first on line
:s/old/new/g             " Replace all on line
:%s/old/new/g            " Replace all in file
:%s/old/new/gc           " Replace all with confirmation
:'<,'>s/old/new/g        " Replace in visual selection
:5,10s/old/new/g         " Replace in lines 5-10
```

### Search Options
```vim
:set hlsearch            " Highlight search
:set incsearch           " Incremental search
:noh                     " Clear highlighting
:set ignorecase          " Case-insensitive
:set smartcase           " Smart case
```

## Visual Mode

| Key | Action |
|-----|--------|
| `v` | Character-wise visual |
| `V` | Line-wise visual |
| `Ctrl+v` | Block-wise visual |
| `o` | Move to other end of selection |
| `d` | Delete selection |
| `y` | Copy selection |
| `c` | Change selection |
| `>` | Indent selection |
| `<` | Unindent selection |
| `~` | Toggle case |

## Multiple Files & Buffers

### Buffers
```vim
:ls                     " List buffers
:bn                     " Next buffer
:bp                     " Previous buffer
:b3                     " Go to buffer 3
:bd                     " Delete buffer
:e filename             " Edit file
```

### Windows (Splits)
```vim
:split file            " Horizontal split
:vsplit file           " Vertical split
Ctrl+w w               " Switch windows
Ctrl+w h/j/k/l         " Navigate splits
Ctrl+w q               " Close window
Ctrl+w =               " Equal size windows
Ctrl+w _               " Maximize height
Ctrl+w |               " Maximize width
```

### Tabs
```vim
:tabnew file           " New tab
:tabn                  " Next tab
:tabp                  " Previous tab
gt                     " Next tab
gT                     " Previous tab
:tabclose              " Close tab
```

## Configuration (~/.vimrc)

```vim
" Basic settings
set number              " Show line numbers
set relativenumber      " Relative line numbers
set tabstop=4           " Tab width
set shiftwidth=4        " Indent width
set expandtab           " Use spaces instead of tabs
set autoindent          " Auto-indent
set smartindent         " Smart indentation

" Search settings
syntax on               " Syntax highlighting
set hlsearch            " Highlight search
set incsearch           " Incremental search
set ignorecase          " Case-insensitive search
set smartcase           " Case-sensitive if uppercase

" UI settings
set cursorline          " Highlight current line
set showmatch           " Highlight matching brackets
set wildmenu            " Command completion
set ruler               " Show cursor position
set laststatus=2        " Always show status line

" Color scheme
colorscheme desert      " Set color scheme
```

## Tips & Tricks

### Useful Combinations
```vim
:w !sudo tee %         " Save file with sudo
:earlier 15m           " Revert to 15 minutes ago
:later 5m              " Go forward 5 minutes
:%!sort                " Sort all lines
:retab                 " Convert tabs to spaces
ggVG                   " Select all
```

### Marks
```vim
ma                     " Set mark 'a'
`a                     " Jump to mark 'a'
'a                     " Jump to line of mark 'a'
:marks                 " List all marks
```

### Macros
```vim
qa                     " Start recording macro 'a'
q                      " Stop recording
@a                     " Execute macro 'a'
@@                     " Repeat last macro
```

### Fold ing
```vim
zf                     " Create fold
zo                     " Open fold
zc                     " Close fold
za                     " Toggle fold
zR                     " Open all folds
zM                     " Close all folds
```

## Tips and Best Practices

1. **Always check your mode** - Look at the bottom of the screen
2. **Practice navigation** - Use `hjkl` instead of arrow keys for speed
3. **Use counts** - Commands like `3dd` (delete 3 lines) or `5yy` (copy 5 lines)
4. **Search efficiently** - Use `/` for forward search, `?` for backward
5. **Save frequently** - Use `:w` often to avoid losing work
6. **Learn modes** - Normal, Insert, Visual, Command
7. **Escape often** - Press `Esc` to return to normal mode when unsure

---

## Learn More

- `:help` - Built-in help
- `:help topic` - Help on specific topic
- `vimtutor` - Interactive tutorial (run in terminal)

---

**Practice makes perfect!** Use Vim daily to build muscle memory.
