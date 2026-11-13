#!/bin/bash
# Claude Code status line
# Shows: current directory, model name, effort level, and context token usage

input=$(cat)

# Current directory (prefer workspace.current_dir, fall back to cwd), abbreviate $HOME to ~
dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
[ -z "$dir" ] && dir="?"
dir="${dir/#$HOME/\~}"

# Model display name
model=$(echo "$input" | jq -r '.model.display_name // .model.id // "unknown-model"')

# Effort level (optional field)
effort=$(echo "$input" | jq -r '.effort.level // empty')

# Context window usage
used_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
max_tokens=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

format_tokens() {
  local n="$1"
  if [ -z "$n" ]; then
    echo ""
    return
  fi
  awk -v n="$n" 'BEGIN {
    if (n >= 1000) {
      printf "%.1fk", n/1000
    } else {
      printf "%d", n
    }
  }'
}

used_fmt=$(format_tokens "$used_tokens")
max_fmt=$(format_tokens "$max_tokens")

if [ -n "$used_fmt" ] && [ -n "$max_fmt" ]; then
  if [ -n "$used_pct" ] && [ "$used_pct" != "null" ]; then
    ctx=$(printf "%s/%s tokens (%.0f%%)" "$used_fmt" "$max_fmt" "$used_pct")
  else
    ctx="${used_fmt}/${max_fmt} tokens"
  fi
else
  ctx="ctx: n/a"
fi

# Colors (bright/bold for visibility in terminal status lines)
c_dir="\033[1;96m"     # bright cyan
c_model="\033[1;95m"   # bright magenta
c_effort="\033[1;93m"  # bright yellow
c_ctx="\033[1;92m"     # bright green
c_sep="\033[1;37m"     # bright white
c_reset="\033[0m"

parts=()
parts+=("${c_dir}${dir}${c_reset}")
parts+=("${c_model}${model}${c_reset}")
if [ -n "$effort" ] && [ "$effort" != "null" ]; then
  parts+=("${c_effort}effort:${effort}${c_reset}")
fi
parts+=("${c_ctx}${ctx}${c_reset}")

sep=" ${c_sep}|${c_reset} "
output="${parts[0]}"
for ((i = 1; i < ${#parts[@]}; i++)); do
  output="${output}${sep}${parts[$i]}"
done

printf "%b\n" "$output"
