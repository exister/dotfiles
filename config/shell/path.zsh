typeset -U path PATH

path=(
  "$HOME/.local/bin"
  "/opt/homebrew/bin"
  "/opt/homebrew/sbin"
  "/Applications/Obsidian.app/Contents/MacOS"
  $path
)

export PATH
