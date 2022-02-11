#zmodload zsh/zprof

# TODO: inline comments for cleaner setup
alias xo=xdg-open

# TODO: Don't set keyboard settings if on remote
# keyboard settings
# remove caps and set it to ctrl
setxkbmap -option ctrl:nocaps
# enable caps by double pressing shift
setxkbmap -option shift:both_capslock
xcape -e 'Control_L=Escape'

alias python=python3
export EDITOR=nvim

source ~/.zsh/antigen_config.zsh

# xargs but zargs
autoload -U zargs

# Calculator
autoload zcalc

# Line editor
autoload zed

# Renaming with globbing
autoload zmv

# Completion system
autoload -Uz compinit
compinit

## Use cache
# Some functions, like _apt and _dpkg, are very slow. You can use a cache in
# order to proxy the list of results (like the list of available debian
# packages)
zstyle ':completion:*' use-cache c n
zstyle ':completion:*' cache-path ~/.zsh/cache

# Zsh settings for history
HISTORY_IGNORE="(ls|[bf]g|exit|reset|clear|cd|cd ..|cd..)"
HISTSIZE=250000
HISTFILE=~/.zsh/.zsh_history
SAVEHIST=1000000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY


# Short command aliases
compdef g='git'
# Aliasing 'g' to 'git' wouldn't be useful without autocompletion.
#complete -o default -o nospace -F _git g
#. /usr/share/bash-completion/completions/git 2> /dev/null
alias L='less'

alias 'l=ls -l'
alias 'la=ls -FA'
alias 'll=ls -Flah'
alias 'llh=ls -l --si'
alias 'lq=ls -Q'
alias 'lr=ls -R'
alias 'lrs=ls -lrS'
alias 'lrt=ls -lrt'
alias 'lrta=ls -lrtA'
alias 'lrth=ls -lrth --si'
alias 'lrtha=ls -lrthA --si'
alias 'grep=grep --colour=always --line-number --devices=skip'

# Play safe!
alias 'rm=rm -i'
alias 'mv=mv -i'
alias 'cp=cp -i'

# For convenience
alias 'mkdir=mkdir -p'
alias 'cal=ncal -b' # Weeks start on Monday
alias 'dmesg=dmesg --ctime'

# Typing errors...
alias 'cd..= cd ..'

# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=30

# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT

export TIME_STYLE="long-iso"

# Commas in ls, du, df output
export BLOCK_SIZE="'1"

# No quoting spaces in newer coreutils
export QUOTING_STYLE=literal

# Set less options
if [[ -x $(which less 2> /dev/null) ]]; then
    export PAGER="less"
    export LESS="--ignore-case --LONG-PROMPT --QUIET --chop-long-lines -Sm --RAW-CONTROL-CHARS --quit-if-one-screen --no-init"
    export LESSHISTFILE='-'
    if [[ -x $(which lesspipe 2> /dev/null) ]]; then
    LESSOPEN="| lesspipe %s"
    export LESSOPEN
    fi
fi
# Enable color support of ls
if [[ "$TERM" != "dumb" ]]; then
    if [[ -x `which dircolors 2> /dev/null` ]]; then
    eval `dircolors -b`
    alias 'ls=ls --color=auto'
    fi
fi

# Quick find
qf() {
    echo "find . -iname \"*$1*\""
    find . -iname "*$1*"
}

# Quick regex history search
zh() {
    pattern=^$(echo '(?=.*'${^@}')' | tr -d ' ')
    grep --text ~/.zsh_history --perl-regexp --regexp $pattern
}

# mkcd -- mkdir and cd at once
mkcd() { mkdir -p -- "$1" && cd -- "$1" }
compdef mkcd=mkdir

# Quick ../../.. from https://github.com/blueyed/oh-my-zsh
resolve-alias() {
    # Recursively resolve aliases and echo the command.
    typeset -a cmd
    cmd=(${(z)1})
    while (( ${+aliases[$cmd[1]]} )) \
          && [[ ${aliases[$cmd[1]]} != $cmd ]]; do
    cmd=(${(z)aliases[${cmd[1]}]})
    done
    echo $cmd
}

rationalise-dot() {
    # Auto-expand "..." to "../..", "...." to "../../.." etc.
    # It skips certain commands (git, tig, p4).
    #
    # resolve-alias is defined in a separate function.

    local MATCH # keep the regex match from leaking to the environment.

    # Skip pasted text.
    if (( PENDING > 0 )); then
    zle self-insert
    return
    fi

    if [[ $LBUFFER =~ '(^|/| ||'$'\n''|\||;|&)\.\.$' ]] \
       && ! [[ $(resolve-alias $LBUFFER) =~ '(git|tig|p4)' ]]; then
    LBUFFER+=/
    zle self-insert
    zle self-insert
    else
    zle self-insert
    fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
bindkey -M isearch . self-insert 2>/dev/null


# list directories before files (if installed version of ls allows this)
if man ls | grep group-directories-first >&/dev/null; then
    alias ls='ls --color=auto --group-directories-first'
fi
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

#fuzzy file completion
eval "$(fasd --init auto)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_ALT_C_COMMAND="fd --type d . $HOME"

export XDG_CONFIG_HOME=~/.config


# TODO: should not always be here.
# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

#zprof
