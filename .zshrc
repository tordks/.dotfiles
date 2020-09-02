
# TODO: CLEAN and ORGANIZE

alias xo=xdg-open

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

#fuzzy file completion
eval "$(fasd --init auto)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_ALT_C_COMMAND="fd --type d . $HOME"

# rust stuff
# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# export PATH=/.cargo/bin:$PATH
# source ~/.cargo/env
#export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# exports
export XDG_CONFIG_HOME=~/.config

#
# TODO: This messes up the zsh theme
#>>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/tordks/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/tordks/anaconda3/etc/profile.d/conda.sh" ]; then
## . "/home/tordks/anaconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
#    else
#        export PATH="/home/tordks/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
#CONDA_AUTO_ACTIVATE_BASE=false

#<<< conda initialize <<<


# Pyenv
export PATH="/home/tordks/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


#zprof
