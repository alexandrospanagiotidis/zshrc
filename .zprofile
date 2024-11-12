typeset -Ux path
typeset -Ux fpath

path=(
"$HOME/.local/bin"

# Krew
"$HOME/.krew/bin"

# use mise shims as fallback
# see https://github.com/jdx/mise/issues/325#issuecomment-1475072742
# and https://mise.jdx.dev/ide-integration.html
"$HOME/.local/share/mise/shims"

$path
)


fpath=(
"$HOME/.local/share/zsh/site-functions"

$fpath
)
