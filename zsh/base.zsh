## TODO: Most of this is copied from different places. Get an overview!

# Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return

# Completion system
autoload -Uz compinit
compinit

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

# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=30

# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT


# Enable color support of ls
if [[ "$TERM" != "dumb" ]]; then
    if [[ -x `which dircolors 2> /dev/null` ]]; then
    eval `dircolors -b`
    alias 'ls=ls --color=auto'
    fi
fi


# Why is the date American even when the locale is en_GB?  Choose ISO form anyway.
export TIME_STYLE="long-iso"

# Commas in ls, du, df output
export BLOCK_SIZE="'1"

# No quoting spaces in newer coreutils
export QUOTING_STYLE=literal

# Short command aliases
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

# Global aliases (expand whatever their position)
#  e.g. find . E L

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

# # TODO: this does not what it says...
# Change terminal title
#title() {
#    echo -ne "\033]30;$*\007"
#}

# mkcd -- mkdir and cd at once
mkcd() { mkdir -p -- "$1" && cd -- "$1" }
compdef mkcd=mkdir


## Use cache
# Some functions, like _apt and _dpkg, are very slow. You can use a cache in
# order to proxy the list of results (like the list of available debian
# packages)
zstyle ':completion:*' use-cache c n
zstyle ':completion:*' cache-path ~/.zsh/cache

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


# xargs but zargs
autoload -U zargs

# Calculator
autoload zcalc

# Line editor
autoload zed

# Renaming with globbing
autoload zmv


# Various reminders of things I forget...
# (Mostly useful features that I forget to use)
# vared
# =ls turns to /bin/ls
# =(ls) turns to filename (which contains output of ls)
# <(ls) turns to named pipe
# ^X* expand word
# ^[^_ copy prev word
# ^[A accept and hold
# echo $name:r not-extension
# echo $name:e extension
# echo $xx:l lowercase
# echo $name:s/foo/bar/

# Quote current line: M-'
# Quote region: M-"

# Up-case-word: M-u
# Down-case-word: M-l
# Capitilise word: M-c

# kill-region

# expand word: ^X*
# accept-and-hold: M-a
# accept-line-and-down-history: ^O
# execute-named-cmd: M-x
# push-line: ^Q
# run-help: M-h
# spelling correction: M-s

# echo ${^~path}/*mous*
