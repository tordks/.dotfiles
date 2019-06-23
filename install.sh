
# NOTE: This is currently only a collection of steps and will be sewed togheter when time
# Should install both bash/zsh settings and nvim settings on a new computer
# move to Makefile



# Autoinstall vim-plug
# TODO: Make this work
#if empty(glob('~/.nvim/autoload/plug.vim')) ; then
  #silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    #\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  #autocmd VimEnter * PlugInstall
#endif


# TODO: Fix python setup given a virtual environment
# Setting up python
# https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
pip3 install --user neovim


# deoplete install
pip3 install --user pynvim
pip3 install --user --upgrade pynvim

# jedi install
pip3 install jedi

# black install
pip3 install black


# fasd
# Make sure the fasd.plugin.zsh is sourced correctly from the fasd plugin!
# currently set .zshrc_antigen

# ag install 
apt-get install silversearcher-ag
