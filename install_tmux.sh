# TODO: currently not working to call from the commandline..

#Install
sudo apt install tmux

# Get tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#Install plugins
## start a server but don't attach to it
tmux start-server
## create a new session but don't attach to it either
tmux new-session -d
## install the plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh
## killing the server is not required, I guess
tmux kill-server
