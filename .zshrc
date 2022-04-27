if [[ -f "$HOME/.aliases" ]]; then
    source $HOME/.aliases
fi

unsetopt ALWAYS_LAST_PROMPT

# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

setopt HIST_EXPIRE_DUPS_FIRST  # if history needs to be trimmed, evict dups first
setopt HIST_IGNORE_SPACE       # don't add commands starting with space to history
setopt HIST_REDUCE_BLANKS      # remove junk whitespace from commands before adding to history
setopt HIST_VERIFY             # if a cmd triggers history expansion, show it instead of running
setopt SHARE_HISTORY           # write and import history on every command
setopt EXTENDED_HISTORY        # write timestamps to history

export HISTFILESIZE=1000000000
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000

export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'

autoload -Uz compinit
compinit

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

##bindkey "\e[A" up-line-or-beginning-search
##bindkey "\e[B" down-line-or-beginning-search

#bindkey "^[b" backward-word
#bindkey "^[f" forward-word
#bindkey "^E" end-of-line
#bindkey "^A" beginning-of-line
#bindkey "^[[A" history-beginning-search-backward
#bindkey "^[[B" history-beginning-search-forward

#bindkey "\e[A" history-beginning-search-backward
#bindkey "\e[B" history-beginning-search-forward

bindkey '^[[A'    up-line-or-beginning-search-local   # up         previous command in local history
bindkey '^[[B'    down-line-or-beginning-search-local # down       next command in local history
bindkey '^[[1;5A' up-line-or-beginning-search         # ctrl+up    prev command in global history
bindkey '^[[1;5B' down-line-or-beginning-search       # ctrl+down  next command in global history

typeset -g __local_searching __local_savecursor

# The same as up-line-or-beginning-search but restricted to local history.
up-line-or-beginning-search-local() {
  emulate -L zsh
  local last=$LASTWIDGET
  zle .set-local-history 1
  if [[ $LBUFFER == *$'\n'* ]]; then
    zle .up-line-or-history
    __local_searching=''
  elif [[ -n $PREBUFFER ]] && zstyle -t ':zle:up-line-or-beginning-search' edit-buffer; then
    zle .push-line-or-edit
  else
    [[ $last = $__local_searching ]] && CURSOR=$__local_savecursor
    __local_savecursor=$CURSOR
    __local_searching=$WIDGET
    zle .history-beginning-search-backward
    zstyle -T ':zle:up-line-or-beginning-search' leave-cursor && zle .end-of-line
  fi
  zle set-local-history 0
}
zle -N up-line-or-beginning-search-local

# The same as down-line-or-beginning-search but restricted to local history.
down-line-or-beginning-search-local() {
  emulate -L zsh
  local last=$LASTWIDGET
  zle .set-local-history 1
  function impl() {
    if [[ ${+NUMERIC} -eq 0 && ( $last = $__local_searching || $RBUFFER != *$'\n'* ) ]]; then
      [[ $last = $__local_searching ]] && CURSOR=$__local_savecursor
      __local_searching=$WIDGET
      __local_savecursor=$CURSOR
      if zle .history-beginning-search-forward; then
        if [[ $RBUFFER != *$'\n'* ]]; then
          zstyle -T ':zle:down-line-or-beginning-search' leave-cursor && zle .end-of-line
        fi
        return
      fi
      [[ $RBUFFER = *$'\n'* ]] || return
    fi
    __local_searching=''
    zle .down-line-or-history
  }
  impl
  zle .set-local-history 0
}
zle -N down-line-or-beginning-search-local
