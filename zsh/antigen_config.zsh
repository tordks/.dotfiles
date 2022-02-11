source ~/.zsh/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# TODO: test that fzf-tab works
# fzf-tab need to be loaded BEFORE plugins that will wrap widgets AND AFTER
# compinit. https://github.com/Aloxaf/fzf-tab#install
antigen bundle Aloxaf/fzf-tab # tab completion using fzf.
antigen bundle zdharma/fast-syntax-highlighting #syntax highlighting in shell
antigen bundle zsh-autosuggestions # fish like autosuggestions

antigen bundle aliases # defines acs command that lists all aliaeses
# antigen bundle colorize  # syntax highlighting via chroma or pygments
antigen bundle colored-man-pages
antigen bundle command-not-found
antigen bundle copyfile # copies absolute path to file
antigen bundle copydir # copies $PWD
antigen bundle copybuffer # ctrl-o to copy current written text
antigen bundle docker # docker autocomplete
antigen bundle docker-compose # docker-compose autocomplete and aliases
# antigen bundle dotenv # automatically load .env when cd into directory
antigen bundle dirhistory # alt-arrows to navigate in terminal dirs
antigen bundle fasd # fast navigation in the shell
# TODO: need to set fzf env variables? https://github.com/junegunn/fzf
antigen bundle fzf # fuzzy file finder
# antigen bundle kubectl # kubectl alias and autocomplete
antigen bundle poetry  # poetry autocomplete
antigen bundle pip  # pip autocomplete
antigen bundle pyenv  # loads pyenv and pyenv-virtualenv
antigen bundle rsync # rsync convenience commands
antigen bundle vi-mode  # vi like terminal editing

# TODO: fzf fasd vs fzf-tab? Do they work togheter?
# antigen bundle wookayin/fzf-fasd # tab completion of z with fzf
antigen bundle thuandt/zsh-pipx
antigen bundle jsahlen/tmux-vim-integration.plugin.zsh # open file in vim in adjecent tmux pane

# zsh-completions need to be run BEFORE compinit
antigen bundle zsh-users/zsh-completions # additional completion definitions

# Load the theme.
antigen theme candy

# Tell Antigen that you're done.
antigen apply


# Plugin settings
# FZFZ_RECENT_DIRS_TOOL=fasd # set fasd to be the fuzzy file finder

# source "$ZSH/plugins/fasd/fasd.plugin.zsh"
# source "/home/tordks/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/fasd/fasd.plugin.zsh"
