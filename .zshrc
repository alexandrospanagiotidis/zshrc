# shellcheck disable=SC2148

HISTFILE=~/.zsh_history
HISTSIZE=50000
# shellcheck disable=SC2034
SAVEHIST=50000

# https://zsh.sourceforge.io/Doc/Release/Options.html#History
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
unsetopt HIST_VERIFY
setopt INC_APPEND_HISTORY
unsetopt SHARE_HISTORY

# https://zsh.sourceforge.io/Doc/Release/Options.html#Changing-Directories
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

(( ${+commands[mise]} )) && {
  eval "$(mise activate zsh)"
}

(( ${+commands[direnv]} )) && {
  eval "$(direnv hook zsh)"
}

[[ -f ~/.fzf.zsh ]] && {
# shellcheck disable=SC1090
  source ~/.fzf.zsh
}

[[ -f "/opt/homebrew/bin/brew" ]] && {
  eval "$(/opt/homebrew/bin/brew shellenv)"

# shellcheck disable=SC2206
  fpath=(
    "${HOMEBREW_PREFIX}/share/zsh-completions"
    "${HOMEBREW_PREFIX}/share/zsh/site-functions"
    ${fpath}
  )
}

(( ${+commands[starship]} )) && {
  eval "$(starship init zsh)"
}

# aliases
alias ls="ls --color=auto"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# call after all changes to fpath are done
autoload -Uz compinit && compinit

[[ -n "${KITTY_PID}" ]] && {
  alias ssh="kitten ssh"
}

if [[ -n "${TMUX}" ]]
then
  bindkey '^[[1~' beginning-of-line # home
  bindkey '^[[4~' end-of-line # end
  bindkey '^[[1;3C' emacs-forward-word # alt left
  bindkey '^[[1;3D' emacs-backward-word # alt right
else
  bindkey '^[[F' end-of-line # end
  bindkey '^[[H' beginning-of-line # home
fi
