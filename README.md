# Dotfiles
This repo is a centralized place for all of my configuration files. This will make it easy to get up and running on any new machine I use much quicker.

## Directory structure

| Directory | Symlink target | Description |
|-----------|----------------|-------------|
| `bash/` | `~/` | Bash startup files (`.bash_profile`, `.bashrc`, `.bashrc_mac`, `.inputrc`) |
| `btop/` | `~/.config/btop/` | btop system monitor config |
| `ghostty/` | `~/.config/ghostty/` | Ghostty terminal emulator config |
| `oh-my-zsh/` | `~/.oh-my-zsh/` | Oh My Zsh custom plugins (as git submodules) |
| `starship/` | `~/.config/` | Starship prompt config (`starship.toml`) |
| `vscode/` | `~/Library/Application Support/Code/User/` | VS Code user settings |
| `zsh/` | `~/` | Zsh config (`.zshrc`, `.zshrc.pre-oh-my-zsh`) |

## Setup on a new machine

### 1. Clone with submodules

```sh
git clone --recurse-submodules https://github.com/alexp327/dotfiles.git ~/dev/dotfiles
```

### 2. Install Oh My Zsh

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 3. Symlink configs

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

# Oh My Zsh custom plugins (symlink each submodule)
ln -sf ~/dev/dotfiles/oh-my-zsh/custom/plugins/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
ln -sf ~/dev/dotfiles/oh-my-zsh/custom/plugins/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# VS Code
ln -sf ~/dev/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
```

### 4. Install tools

- [Ghostty](https://ghostty.org) — terminal emulator
- [Starship](https://starship.rs) — `brew install starship`
- [btop](https://github.com/aristocratos/btop) — `brew install btop`
- [eza](https://github.com/eza-community/eza) — `brew install eza` (used in `.zshrc` aliases)
- [zoxide](https://github.com/ajeetdsouza/zoxide) — `brew install zoxide` (used in `.zshrc`)
