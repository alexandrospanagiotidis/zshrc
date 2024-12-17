# shellcheck disable=SC2148

typeset -Ux path
typeset -Ux fpath

# shellcheck disable=SC2206
path=(
~/.local/bin

# Krew
~/.krew/bin

# use mise shims as fallback
# see https://github.com/jdx/mise/issues/325#issuecomment-1475072742
# and https://mise.jdx.dev/ide-integration.html
~/.local/share/mise/shims

${path}
)


# shellcheck disable=SC2206
fpath=(
~/.local/share/zsh/site-functions

${fpath}
)
