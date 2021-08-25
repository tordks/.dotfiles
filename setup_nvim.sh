sudo apt install neovim
# install plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Setup venv for use in neovim
pyenv virtualenv 3.8.5 neovim
# Install python dependencies
pyenv activate neovim && pip install --upgrade pip
pyenv activate neovim && pip install wheel
pyenv activate neovim && pip install neovim jedi python-language-server flake8 flake8-black isort pylint sqlint mypy
# Install all plugins
nvim +PlugInstall +qall
