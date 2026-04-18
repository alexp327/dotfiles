# Copilot Instructions

## Repository shape

This repository is a small dotfiles collection, not an application. The top-level directories are independent config bundles:

- `bash/` contains shell startup and Readline dotfiles intended to live in `$HOME`
- `vscode/` contains the user's VS Code settings

The README only establishes the repo's purpose: a centralized place for machine setup and personal configuration.

## Validation commands

There is no project-specific build, test, or lint toolchain. The practical validation commands in this repo are file-level syntax and parse checks:

```bash
# Check all shell startup files
bash -n bash/.bash_profile bash/.bashrc bash/.bashrc_mac

# Check a single shell file
bash -n bash/.bashrc

# Validate VS Code settings JSON
python3 -m json.tool vscode/settings.json >/dev/null
```

## High-level architecture

`bash/.bash_profile` is the login-shell entry point and should stay thin; it only sources `~/.bashrc`.

The real shell configuration lives in two parallel files:

- `bash/.bashrc` for Linux-style environments that load system bash completion from `/usr/share` or `/etc`
- `bash/.bashrc_mac` for macOS/Homebrew environments that load bash completion from `$(brew --prefix)/etc/bash_completion`

Aside from completion loading, those two files are intentionally aligned. Shared behavior includes:

- interactive-shell guard at the top
- history settings and prompt setup
- aliases and optional `~/.bash_aliases` loading
- `__git_ps1` prompt integration
- NVM initialization

`bash/.inputrc` is separate from shell startup and only adjusts Readline behavior.

`vscode/settings.json` is a personal editor profile rather than a project-local config. It mixes global editor preferences with formatter and language-specific defaults.

## Key conventions

- Treat files under `bash/` as home-directory dotfiles stored in a subdirectory for version control. Preserve the leading-dot filenames and their startup roles.
- Keep `bash/.bashrc` and `bash/.bashrc_mac` in sync whenever a change is not OS-specific. If a change only affects completion or platform-specific paths, isolate it to the appropriate file instead of letting the files drift.
- Keep `bash/.bash_profile` minimal. New shell behavior should usually go in the relevant `.bashrc` file, not in `.bash_profile`.
- Preserve the interactive-shell early return in the bash configs; aliases, prompts, and completion are meant for interactive shells only.
- When editing `vscode/settings.json`, keep the existing formatting/style conventions already encoded there: 2-space indentation, Prettier as the default formatter for web languages, `singleQuote: true`, `jsxSingleQuote: true`, and `prettier.endOfLine: "crlf"`.
