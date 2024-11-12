# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# mise
whence "mise" >/dev/null && {
  eval "$(mise activate zsh)"
}

# direnv
whence "direnv" >/dev/null && {
  eval "$(direnv hook zsh)"
}

# fzf
[ -f "${HOME}/.fzf.zsh" ] && {
  source "${HOME}/.fzf.zsh"
}

# Homebrew
[ -f "/opt/homebrew/bin/brew" ] && {
  eval "$(/opt/homebrew/bin/brew shellenv)"
  
  fpath=(
    "${HOMEBREW_PREFIX}/share/zsh-completions"
    "${HOMEBREW_PREFIX}/share/zsh/site-functions"
    $fpath
  )
}

# Starship
whence "starship" >/dev/null && {
  eval "$(starship init zsh)"
}

# aliases
alias ls="ls --color=auto"
alias rm="rm -ix"
alias cp="cp -i"
alias mv="mv -i"

# call after all changes to fpath are done
autoload -Uz compinit && compinit
