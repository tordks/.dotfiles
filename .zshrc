
# TODO: CLEAN and ORGANIZE

# keyboard settings
# remove caps and set it to ctrl
setxkbmap -option ctrl:nocaps

# enable caps by double pressing shift
setxkbmap -option shift:both_capslock

xcape -e 'Control_L=Escape'

#zmodload zsh/zprof

source ~/.zsh/env.zsh
source ~/.zsh/antigen_config.zsh
source ~/.zsh/base.zsh

#
# TODO: Need cleanup
source ~/.zsh/from_bashrc.zsh


# Python venv management
export VENVFOLDER="$HOME/code/venvs/"
activate() {
    source $VENVFOLDER$1"/bin/activate"
}
mkvenv() {
    local D=$VENVFOLDER$1
    local P=$1
    shift
    python -m venv  $D --prompt $P $@
}
rmvenv() {
    local D=$VENVFOLDER$1
    shift
    rm $D $@
}

#fuzzy file completion
eval "$(fasd --init auto)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# rust stuff
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=/.cargo/bin:$PATH
source ~/.cargo/env

# exports
export XDG_CONFIG_HOME=~/.config

#
# TODO: This messes up the zsh theme
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/tordks/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/tordks/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/tordks/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/tordks/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
CONDA_AUTO_ACTIVATE_BASE=false

# <<< conda initialize <<<

#zprof
