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

# set by `brew shellenv` in .zprofile
[[ -n "${HOMEBREW_PREFIX}" ]] && {
# shellcheck disable=SC2206
  fpath=(
    "${HOMEBREW_PREFIX}/share/zsh-completions"
    "${HOMEBREW_PREFIX}/share/zsh/site-functions"
    ${fpath}
  )
}

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

(( ${+commands[starship]} )) && {
  eval "$(starship init zsh)"
}

(( ${+commands[yazi]} )) && {
# This has to be a function or the directory of the calling shell cannot be changed
# https://yazi-rs.github.io/docs/quick-start
  y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
  }
}

# aliases
alias ls="ls --color=auto"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

[[ -n "${KITTY_PID}" ]] && {
  alias ssh="kitten ssh"
}

if [[ -n "${TMUX}" ]]
then
  bindkey '^[[1~' beginning-of-line # home
  bindkey '^[[4~' end-of-line # end
  bindkey '^[[1;3C' forward-word # alt left
  bindkey '^[[1;3D' backward-word # alt right
else
  bindkey '^[[F' end-of-line # end
  bindkey '^[[H' beginning-of-line # home
fi


# Ensure local bin and completions are first
# shellcheck disable=SC2206
path=(~/.local/bin ${path})
# shellcheck disable=SC2206,SC2128
fpath=(~/.local/share/zsh/site-functions ${fpath})

# call after all changes to fpath are done
typeset -Ux fpath
autoload -Uz compinit && compinit
