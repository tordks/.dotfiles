# TODO: some cleanup from moving to bash

source ~/.zsh/.zshrc_antigen
#source ~/.zsh/.zshrc_base
source ~/.zsh/.zshrc_from_bashrc


eval "$(fasd --init auto)"

#fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
