
source ~/.zsh/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle vi-mode
antigen bundle zsh-autosuggestions
#antigen bundle heroku
#antigen bundle pip
#antigen bundle lein
#antigen bundle command-not-found

# other bundles
antigen bundle djui/alias-tips # gives tips if alias for a command exist
antigen bundle zdharma/fast-syntax-highlighting #syntax highlighting in shell


antigen bundle junegunn/fzf # fuzzy file finder
antigen bundle andrewferrier/fzf-z # combines fzf and z/fasd/autojump
antigen bundle hschne/fzf-git # enables fzf fuzzy search with git

antigen bundle clvv/fasd # fuzzy file search inspired by z, autojump, v
source $ZSH/plugins/fasd/fasd.plugin.zsh
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

# cd into recent directories ala z
# TODO: might be redundant with z above...
zd() {
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}
alias j=zd

# TODO: look into these
## View recent f files
#v() {
#    local file
#    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && $EDITOR "${file}" || return 1
#}

## cd into the directory containing a recently used file
 #vd() {
    #local dir
    #local file
    #file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && dir=$(dirname "$file") && cd "$dir"
#}


antigen bundle aperezdc/zsh-notes # access markdown notes remember to est EDITOR/VISUAL
#antigen bundle chipsenkbeil/zsh-notes # alternate note manager
antigen bundle jsahlen/tmux-vim-integration.plugin.zsh # open file in vim in adjecent tmux pane

#antigen bundle rupa/z # fuzzy file search
antigen bundle zsh-users/zsh-completions

# Load the theme.
antigen theme candy


# Settings
FZFZ_RECENT_DIRS_TOOL=fasd # set fasd to be the fuzzy file finder

# Tell Antigen that you're done.
antigen apply
