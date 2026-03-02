#!/bin/sh
input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.project_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Shorten cwd to last 2 path components, replacing $HOME prefix with ~
home="$HOME"
case "$cwd" in
  "$home"*) cwd="~${cwd#$home}" ;;
esac
# Extract last 2 slash-separated components (handles ~ prefix correctly)
short_cwd=$(printf '%s' "$cwd" | awk -F'/' '{
  n = NF
  if (n <= 2) { print $0 }
  else if ($1 == "~") {
    if (n == 3) { print "~/" $3 }
    else { print "/" $(n-1) "/" $n }
  }
  else { print "/" $(n-1) "/" $n }
}')

# Get git branch and status from project_dir, skipping optional locks to avoid contention
raw_dir=$(echo "$input" | jq -r '.workspace.project_dir // .cwd')
branch=$(git -C "$raw_dir" --no-optional-locks \
  symbolic-ref --short HEAD 2>/dev/null)

# Collect git status indicators when inside a repo, using a per-repo cache file.
# Cache file: /tmp/claude-statusline-git-<hash>.cache
# Format (3 lines): branch, porcelain output (newlines escaped as \n)
# Cache is refreshed when older than 5 seconds.
git_indicators=""
git_indicators_plain=""
if [ -n "$branch" ]; then
  # Derive a short hash of the repo path for a unique cache filename
  repo_hash=$(printf '%s' "$raw_dir" | cksum | awk '{print $1}')
  cache_file="/tmp/claude-statusline-git-${repo_hash}.cache"

  # Check cache mtime: use stat portably (Linux: stat -c %Y, fallback to 0)
  now=$(date +%s)
  cache_mtime=0
  if [ -f "$cache_file" ]; then
    cache_mtime=$(stat -c '%Y' "$cache_file" 2>/dev/null || echo 0)
  fi
  cache_age=$((now - cache_mtime))

  if [ "$cache_age" -lt 5 ] && [ -f "$cache_file" ]; then
    # Cache is fresh: read branch and porcelain output from it.
    # Line 1: branch name, Line 2: porcelain output (newlines stored as \n literals)
    cached_branch=$(sed -n '1p' "$cache_file")
    porcelain_escaped=$(sed -n '2p' "$cache_file")
    # Restore newlines so parsing below works identically to live output
    porcelain=$(printf '%s' "$porcelain_escaped" | sed 's/\\n/\n/g')
    # Use the cached branch name (keeps indicator display consistent mid-rename)
    branch="$cached_branch"
  else
    # Cache is stale or missing: run git and write cache atomically via tmp file
    porcelain=$(git -C "$raw_dir" --no-optional-locks status --porcelain 2>/dev/null)
    tmp_cache="${cache_file}.tmp.$$"
    # Escape newlines to store multi-line porcelain output on a single line
    porcelain_escaped=$(printf '%s' "$porcelain" | awk '{printf "%s\\n", $0}')
    printf '%s\n%s\n' "$branch" "$porcelain_escaped" > "$tmp_cache"
    mv -f "$tmp_cache" "$cache_file"
  fi

  staged=0
  modified=0
  untracked=0
  # Parse porcelain v1 output: two-char XY status codes per file
  # X = index (staged), Y = worktree (unstaged); '?' = untracked
  while IFS= read -r line; do
    [ -z "$line" ] && continue
    X=$(printf '%s' "$line" | cut -c1)
    Y=$(printf '%s' "$line" | cut -c2)
    case "$X" in
      A|M|D|R|C) staged=$((staged + 1)) ;;
    esac
    case "$Y" in
      M|D) modified=$((modified + 1)) ;;
    esac
    case "$X$Y" in
      \?\?) untracked=$((untracked + 1)) ;;
    esac
  done << EOF
$porcelain
EOF

  # Build colored indicator string: green staged, yellow modified, red untracked
  if [ $staged -gt 0 ]; then
    git_indicators="${git_indicators}$(printf "\033[01;32m+%d\033[00m" "$staged")"
    git_indicators_plain="${git_indicators_plain}+${staged}"
  fi
  if [ $modified -gt 0 ]; then
    [ -n "$git_indicators_plain" ] && git_indicators="${git_indicators} " && git_indicators_plain="${git_indicators_plain} "
    git_indicators="${git_indicators}$(printf "\033[01;33m~%d\033[00m" "$modified")"
    git_indicators_plain="${git_indicators_plain}~${modified}"
  fi
  if [ $untracked -gt 0 ]; then
    [ -n "$git_indicators_plain" ] && git_indicators="${git_indicators} " && git_indicators_plain="${git_indicators_plain} "
    git_indicators="${git_indicators}$(printf "\033[01;31m?%d\033[00m" "$untracked")"
    git_indicators_plain="${git_indicators_plain}?${untracked}"
  fi
fi

# Build the left section: green host, blue short cwd, magenta branch
host=$(hostname -s)
left=$(printf "\033[01;32m%s\033[00m:\033[01;34m%s\033[00m" "$host" "$short_cwd")
left_plain="${host}:${short_cwd}"
if [ -n "$branch" ]; then
  left="$left $(printf "\033[01;35m⎇ %s\033[00m" "$branch")"
  left_plain="$left_plain ⎇ $branch"
  # Append indicators after branch name if any exist
  if [ -n "$git_indicators_plain" ]; then
    left="$left $(printf "[%s]" "$git_indicators")"
    left_plain="$left_plain [${git_indicators_plain}]"
  fi
fi

# Build middle: context progress bar with dynamic color based on usage level
# Green < 70%, yellow 70-89%, red >= 90%
middle=""
middle_plain=""
if [ -n "$used" ]; then
  bar_width=10
  filled=$(printf "%.0f" "$(echo "$used $bar_width" | awk '{printf "%.0f", $1 * $2 / 100}')")
  empty=$((bar_width - filled))
  bar=""
  i=0
  while [ $i -lt $filled ]; do
    bar="${bar}█"
    i=$((i + 1))
  done
  i=0
  while [ $i -lt $empty ]; do
    bar="${bar}░"
    i=$((i + 1))
  done
  # Select color code based on integer percentage thresholds
  used_int=$(printf "%.0f" "$used")
  if [ "$used_int" -ge 90 ]; then
    bar_color="\033[01;31m"   # bold red
  elif [ "$used_int" -ge 70 ]; then
    bar_color="\033[01;33m"   # bold yellow
  else
    bar_color="\033[01;32m"   # bold green
  fi
  middle="$middle  $(printf "${bar_color}[%s] %s%%\033[00m" "$bar" "$used")"
  middle_plain="$middle_plain  [${bar}] ${used}%"
fi

# Right-align model name using terminal width
cols="${COLUMNS:-$(tput cols 2>/dev/null || echo 80)}"
model_len=${#model}
# Compute plain-text lengths, accounting for multi-byte chars in bar/branch (awk for safety)
left_len=$(printf '%s' "$left_plain" | awk '{print length}')
middle_len=$(printf '%s' "$middle_plain" | awk '{print length}')
pad=$((cols - left_len - middle_len - model_len))
[ $pad -lt 1 ] && pad=1
padding=$(printf '%*s' "$pad" '')

model_colored=$(printf "\033[00;33m%s\033[00m" "$model")

printf "%s%s%s%s" "$left" "$middle" "$padding" "$model_colored"
