
#zmodload zsh/zprof

source ~/.zsh/.zshrc_antigen
source ~/.zsh/.zshrc_base
#
# TODO: Need cleanup
source ~/.zsh/.zshrc_from_bashrc

#fuzzy file completion
eval "$(fasd --init auto)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
#
# TODO: This messes up the zsh theme
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/tordks/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/tordks/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/tordks/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/tordks/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
## <<< conda initialize <<<

#zprof
