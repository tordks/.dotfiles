curl https://pyenv.run | bash
sudo apt-get install libffi-dev
pyenv install 3.8.5
pyenv global 3.8.5
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
