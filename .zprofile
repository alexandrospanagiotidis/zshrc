# shellcheck disable=SC2148  # zsh not supported by ShellCheck

# Setting PATH could be done ~/.zshenv but /etc/zprofile on macOS prepends to
# PATH and we want our entries to be first, so they need to be in ~/.zprofile

typeset -Ux path

# Add Homebrew early, so later entries have higher priority
[[ -f "/opt/homebrew/bin/brew" ]] && {
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

__extra_paths=(
~/.local/bin
~/.krew/bin

# use mise shims as fallback
# see https://github.com/jdx/mise/issues/325#issuecomment-1475072742
# and https://mise.jdx.dev/ide-integration.html
~/.local/share/mise/shims
)

# Prepend only existing directories in-order, following symlinks
# shellcheck disable=SC2296,SC1036  # ignore zsh-specific syntax
path=(
"${^__extra_paths[@]}"(N-/)
"${path[@]}"
)

unset __extra_paths

# Additional environment variables

export DO_NOT_TRACK=true
export GH_TELEMETRY=false
export HOMEBREW_NO_ANALYTICS=1
