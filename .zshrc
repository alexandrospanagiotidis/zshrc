# shellcheck disable=SC2148  # zsh not supported by ShellCheck

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

  # Update mise completions:
  # - mise use -g usage
  # - mise completion zsh > .local/share/zsh/site-functions/_mise 
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
    local tmp cwd
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      # Ignore if cd fails so we delete the temp file later anyway
      builtin cd -- "$cwd" || true
    fi
    rm -f -- "$tmp"
  }
}


# Aliases

alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."

alias ls="ls --color=auto"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"


# Key Bindings

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
path=(~/.local/bin "${path[@]}")
fpath=(~/.local/share/zsh/site-functions "${fpath[@]}")

typeset -Ux fpath
# Call compinit after all changes to fpath are done
autoload -Uz compinit && compinit


# Additional environment variables relevant for interactive sessions

export COLORTERM=truecolor
export PODMAN_COMPOSE_WARNING_LOGS=false

# Fix tab completion issues in IntelliJ with RPROMPT, https://superuser.com/questions/655607/removing-the-useless-space-at-the-end-of-the-right-prompt-of-zsh-rprompt
export ZLE_RPROMPT_INDENT=0
