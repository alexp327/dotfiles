# Dotfiles

This repo is a centralized place for all of my configuration files. This will make it easy to get up and running on any new machine I use much quicker.

## Directory structure

| Directory    | Symlink target                             | Description                                                                |
| ------------ | ------------------------------------------ | -------------------------------------------------------------------------- |
| `bash/`      | `~/`                                       | Bash startup files (`.bash_profile`, `.bashrc`, `.bashrc_mac`, `.inputrc`) |
| `btop/`      | `~/.config/btop/`                          | btop system monitor config                                                 |
| `ghostty/`   | `~/.config/ghostty/`                       | Ghostty terminal emulator config                                           |
| `starship/`  | `~/.config/`                               | Starship prompt config (`starship.toml`)                                   |
| `obsidian/`  | `<vault>/.obsidian/`                       | Obsidian app settings, community plugins, and themes                       |
| `vscode/`    | `~/Library/Application Support/Code/User/` | VS Code user settings                                                      |
| `zsh/`       | `~/`                                       | Zsh config (`.zshrc`, `.zshrc.pre-oh-my-zsh`)                              |

## Setup on a new machine

### 1. Clone

```sh
git clone https://github.com/alexp327/dotfiles.git ~/dev/dotfiles
```

### 2. Install Oh My Zsh

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 3. Install Zsh plugins

```sh
# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### 4. Symlink configs

Symlink each config to the expected location. Examples:

```sh
# Zsh
ln -sf ~/dev/dotfiles/zsh/.zshrc ~/.zshrc

# Ghostty
mkdir -p ~/.config/ghostty
ln -sf ~/dev/dotfiles/ghostty/config ~/.config/ghostty/config

# Starship
ln -sf ~/dev/dotfiles/starship/starship.toml ~/.config/starship.toml

# btop
mkdir -p ~/.config/btop
ln -sf ~/dev/dotfiles/btop/btop.conf ~/.config/btop/btop.conf

# VS Code
ln -sf ~/dev/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# Obsidian (replace ~/Notes with the path to your vault)
ln -sf ~/dev/dotfiles/obsidian ~/Notes/.obsidian
```

> **Note:** `workspace.json` and `workspace(n).json` files are written by Obsidian at runtime and are not tracked in this repo.

### 5. Install tools

| Tool | Category | What it does | Homebrew (macOS) | Ubuntu / Debian |
| ---- | -------- | ------------ | ---------------- | --------------- |
| `eza` | shell | Modern `ls` replacement with icons, git status, tree view | `brew install eza` | `sudo apt install eza` |
| `zoxide` | nav | Smarter `cd` — learns your most-used dirs, jump with `z` | `brew install zoxide` | `sudo apt install zoxide` |
| `fzf` | search | Fuzzy finder for files, history, anything piped into it | `brew install fzf` | `sudo apt install fzf` |
| `ripgrep` | search | Blazing-fast grep replacement (`rg`), respects `.gitignore` | `brew install ripgrep` | `sudo apt install ripgrep` |
| `fd` | search | Fast and friendly `find` alternative | `brew install fd` | `sudo apt install fd-find` |
| `bat` | shell | `cat` with syntax highlighting, line numbers, git diff | `brew install bat` | `sudo apt install bat` |
| `delta` | git | Syntax-highlighted diff pager for git | `brew install git-delta` | `cargo install git-delta` |
| `lazygit` | git | TUI for git — stage hunks, branch, rebase visually | `brew install lazygit` | `sudo add-apt-repository ppa:lazygit-team/release && sudo apt install lazygit` |
| `lazydocker` | tui | TUI dashboard for Docker containers, logs, stats | `brew install lazydocker` | `curl …/install_update_linux.sh \| bash` |
| `LazyVim` | dev | Neovim config distro — batteries-included IDE-like setup | `brew install neovim` + [lazyvim.org](https://lazyvim.org) | `sudo apt install neovim` + [lazyvim.org](https://lazyvim.org) |
| `neovim` | dev | Hyperextensible Vim-based text editor | `brew install neovim` | `sudo apt install neovim` |
| `tmux` | shell | Terminal multiplexer — panes, windows, sessions | `brew install tmux` | `sudo apt install tmux` |
| `starship` | shell | Cross-shell prompt — fast, configurable, git-aware | `brew install starship` | `curl -sS https://starship.rs/install.sh \| sh` |
| `zsh` | shell | Feature-rich shell (default on macOS, great on Linux) | `brew install zsh` | `sudo apt install zsh` |
| `atuin` | shell | Replaces shell history with a searchable, syncable SQLite DB | `brew install atuin` | `bash <(curl --proto '=https' -sSf https://setup.atuin.sh)` |
| `yazi` | nav | Terminal file manager with image preview, fuzzy search | `brew install yazi` | `cargo install --locked yazi-fm yazi-cli` |
| `htop` | sys | Interactive process viewer, better than `top` | `brew install htop` | `sudo apt install htop` |
| `btop` | sys | Beautiful resource monitor — CPU, mem, disk, net | `brew install btop` | `sudo apt install btop` |
| `gdu` | sys | Fast disk usage analyser with TUI | `brew install gdu` | `sudo snap install gdu-disk-usage-analyzer` |
| `dust` | sys | Intuitive `du` alternative — tree-style disk usage | `brew install dust` | `cargo install du-dust` |
| `procs` | sys | Modern `ps` replacement with color and search | `brew install procs` | `cargo install procs` |
| `httpie` | dev | Human-friendly `curl` alternative for APIs | `brew install httpie` | `sudo apt install httpie` |
| `jq` | dev | Lightweight JSON processor and query tool | `brew install jq` | `sudo apt install jq` |
| `yq` | dev | `jq` but for YAML, JSON, and TOML | `brew install yq` | `sudo snap install yq` |
| `gh` | git | GitHub CLI — PRs, issues, releases from terminal | `brew install gh` | `sudo apt install gh` |
| `tldr` | shell | Simplified man pages with practical examples | `brew install tlrc` | `sudo apt install tldr` |
| `chezmoi` | dev | Manage dotfiles across machines securely | `brew install chezmoi` | `sh -c "$(curl -fsLS get.chezmoi.io)"` |
| `nnn` | nav | Lightweight, blazing-fast terminal file manager | `brew install nnn` | `sudo apt install nnn` |
| `direnv` | dev | Load/unload env vars automatically per directory | `brew install direnv` | `sudo apt install direnv` |
| `broot` | nav | Navigate directory trees interactively with fuzzy search | `brew install broot` | `cargo install broot` |

On Ubuntu, `bat` installs as `batcat` and `fd` installs as `fdfind`. Add aliases in `.zshrc`:

```sh
alias bat='batcat'
alias fd='fdfind'
```
