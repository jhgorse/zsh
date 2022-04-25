if [[ -f "$HOME/.aliases" ]]; then
    source $HOME/.aliases
fi

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

[[ -n "$terminfo[kich1]" ]] && key[Insert]=$terminfo[kich1]
[[ -n "$terminfo[kdch1]" ]] && key[Delete]=$terminfo[kdch1]
[[ -n "$terminfo[khome]" ]] && key[Home]=$terminfo[khome]
[[ -n "$terminfo[kend]" ]] && key[End]=$terminfo[kend]
[[ -n "$terminfo[kpp]" ]] && key[PageUp]=$terminfo[kpp]
[[ -n "$terminfo[knp]" ]] && key[PageDown]=$terminfo[knp]
[[ -n "$terminfo[kcuu1]" ]] && key[Up]=$terminfo[kcuu1]
[[ -n "$terminfo[kcub1]" ]] && key[Left]=$terminfo[kcub1]
[[ -n "$terminfo[kcud1]" ]] && key[Down]=$terminfo[kcud1]
[[ -n "$terminfo[kcuf1]" ]] && key[Right]=$terminfo[kcuf1]

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      history-beginning-search-backward
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    history-beginning-search-forward

#bindkey "^[b" backward-word
#bindkey "^[f" forward-word
#bindkey "^E" end-of-line
#bindkey "^A" beginning-of-line
#bindkey "^[[A" history-beginning-search-backward
#bindkey "^[[B" history-beginning-search-forward


unsetopt ALWAYS_LAST_PROMPT

# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000
setopt EXTENDED_HISTORY

