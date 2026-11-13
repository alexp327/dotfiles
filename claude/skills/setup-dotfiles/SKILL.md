---
name: setup-dotfiles
description: Clone/update the user's dotfiles repo (github.com/alexp327/dotfiles) on the current machine and symlink selected configs into place. Use when user wants to set up, install, sync, or bootstrap dotfiles on this machine, homelab, server, or new computer.
---

# Setup dotfiles

Runs on the current machine only. Repo: `https://github.com/alexp327/dotfiles.git` (public). Clone location: `~/dev/dotfiles`.

## 1. Gather facts

One command: `uname -s`, `hostname`, GUI present? (`$DISPLAY`/`$WAYLAND_DISPLAY`; macOS = yes), `command -v git zsh tmux starship btop jq claude brew`, whether `~/dev/dotfiles` exists.

## 2. Clone or update

- Missing: `git clone https://github.com/alexp327/dotfiles.git ~/dev/dotfiles`.
- Present: `git -C ~/dev/dotfiles status --porcelain`. Dirty → ask before touching. Clean → `git switch main && git pull --ff-only`.

## 3. List options, then ask

Re-scan the repo's top-level dirs first (`ls ~/dev/dotfiles`) — if a dir exists that's not in the table below, add it as an option and work out its target from the repo README.

Print the full list to the user BEFORE asking — every option, its links, and a note on whether it fits this machine (e.g. "headless — ghostty pointless", "tool not installed"):

| Option | Links (source in repo → target) | Notes |
| --- | --- | --- |
| zsh | `zsh/.zshrc` → `~/.zshrc` | Needs zsh + Oh My Zsh + zsh-syntax-highlighting (README steps 2–3) |
| bash | `bash/.bash_profile`, `.bashrc`, `.inputrc` → `~/`; `.bashrc_mac` → `~/` only on macOS | |
| tmux | `tmux/.tmux.conf` → `~/.tmux.conf` | |
| starship | `starship/starship.toml` → `~/.config/starship.toml` | Needs starship |
| btop | `btop/btop.conf` → `~/.config/btop/btop.conf` | |
| claude | `claude/settings.json`, `CLAUDE.md`, `statusline-command.sh` → `~/.claude/`; each dir in `claude/skills/` → `~/.claude/skills/<name>` | statusline needs `jq`. Optionally reinstall third-party skills from `claude/skill-lock.json` sources via `npx skills add <source>` — ask separately |
| ghostty | `ghostty/config` → `~/.config/ghostty/config` | GUI only |
| vscode | `vscode/settings.json` → macOS `~/Library/Application Support/Code/User/settings.json`, Linux `~/.config/Code/User/settings.json` | GUI only. Profiles (`*.code-profile`) are imported manually in VS Code |
| obsidian | `obsidian/` → `<vault>/.obsidian` | GUI only; ask vault path. Reinstall community plugins afterward |
| rh-homebrew | none — `brew bundle --file=~/dev/dotfiles/rh-homebrew/Brewfile` | RH work Mac only |

Then ask with AskUserQuestion, `multiSelect: true`. Limit is 4 options per question, 4 questions per call, so group them:
- Shell: zsh, bash, tmux, starship
- CLI tools: btop, claude
- GUI apps: ghostty, vscode, obsidian
- Other: rh-homebrew
Leave out options that can't work on this machine (e.g. GUI on headless), but say which ones you left out and why. If a question would have 0–1 options, merge it into another. Treat anything not selected as unwanted.

## 4. Apply

For each selected link:
- `mkdir -p` parent dir.
- Target is already a symlink into `~/dev/dotfiles` → skip.
- Target exists (file/dir/other symlink) → move to `<target>.bak-<YYYYmmdd-HHMMSS>`; never delete.
- `ln -s ~/dev/dotfiles/<src> <target>`.

Don't install packages (apt/brew/Oh My Zsh) without asking; list missing deps and offer.

## 5. Report

Concise table: option → linked / skipped (already linked) / backed up + linked / failed. List backups made and missing deps. Remind to restart the shell / `tmux source ~/.tmux.conf` if relevant.
