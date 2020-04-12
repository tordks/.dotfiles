#####################
# custom settings
#####################


#####################
# sensible settings
#####################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# list directories before files (if installed version of ls allows this)
if man ls | grep group-directories-first >&/dev/null; then
    alias ls='ls --color=auto --group-directories-first'
fi

# Some commands are so common that they deserve one-letter shortcuts :)
compdef g='git'
alias L='less'

# Aliasing 'g' to 'git' wouldn't be useful without autocompletion.
#complete -o default -o nospace -F _git g
#. /usr/share/bash-completion/completions/git 2> /dev/null


# Show a desktop notification when a command finishes. Use like this:
#   sleep 5; alert
function alert() {
    if [ $? = 0 ]; then icon=terminal; else icon=error; fi
    last_cmd="$(history | tail -n1 | sed 's/^\s*[0-9]*\s*//' | sed 's/;\s*alert\s*$//')"
    notify-send -i $icon "$last_cmd"
}

# SETTINGS
#
# let Ctrl-O open ranger, a console file manager (http://nongnu.org/ranger/):
zle -N ranger
bindkey '^o' ranger

# let aliases work after sudo (see http://askubuntu.com/a/22043)
alias sudo='sudo '

# this wrapper lets bash automatically change current directory to the last one
# visited inside ranger.  (Use "cd -" to return to the original directory.)
function ranger {
    tempfile="$(mktemp)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" && cd -- "$(cat "$tempfile")"
    rm -f -- "$tempfile"
}




# PROMPT
# $(__git_ps1) displays git repository status in the prompt - very handy!
# Read more: https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
#GIT_PS1_SHOWDIRTYSTATE=1
#GIT_PS1_DESCRIBE_STYLE="branch"
#GIT_PS1_SHOWUPSTREAM="verbose git"

# we don't want "command not found" errors when __git_ps1 is not installed
#type __git_ps1 &>/dev/null || function __git_ps1 () { true; }

#export PS1="${usercolor}\u@\h${pathcolor} \w${resetcolors}\$(__git_ps1)\n\\$ "


