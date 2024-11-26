# History

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# https://zsh.sourceforge.io/Doc/Release/Options.html#History
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
unsetopt HIST_VERIFY
setopt INC_APPEND_HISTORY
unsetopt SHARE_HISTORY

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
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# call after all changes to fpath are done
autoload -Uz compinit && compinit
