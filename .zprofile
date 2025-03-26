# shellcheck disable=SC2148

# These changes could be in ~/.zshenv but /etc/zprofile on macOS prepends to
# PATH and we want our entries to be first, so they need to be in ~/.zprofile

typeset -Ux path

# Add Homebrew early, so later entries have higher priority
[[ -f "/opt/homebrew/bin/brew" ]] && {
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

# shellcheck disable=SC2206
path=(
~/.local/bin
~/.krew/bin

# use mise shims as fallback
# see https://github.com/jdx/mise/issues/325#issuecomment-1475072742
# and https://mise.jdx.dev/ide-integration.html
~/.local/share/mise/shims

${path}
)
