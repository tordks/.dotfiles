# Source files;
source ~/.zapp/z.sh

####################
#     Aliases      #
####################

alias python='python3'
#alias python='python2.7'
alias xo='xdg-open'
alias e='exit'
alias rb='sudo reboot'
alias po='sudo poweroff'
alias speak='speaker-test -c 2 -r 48000 -D hw:0,3'
alias paraview='~/programs/paraview-5.0.1/bin/paraview &'
alias gitstashdrop='git stash && git stash drop'

# Opening usefull stuff
alias paraview-doc='xo programs/paraview-5.0.1/doc/ParaViewGuide-CE.pdf'
alias trig='xo ~/git/post-install/usefull_pdfs/trig.pdf'
alias perf='sudo /usr/lib/linux-lts-utopic-tools-3.16.0-38/perf'

################
# Key bindings #
################

# swap Control with Caps Lock
setxkbmap -option ctrl:swapcaps

# disable Caps Lock
#xmodmap -e "keysym Caps_Lock = NoSymbol"


####################
#       Misc.      #
####################

set -o vi


####################
#      Exports     #
####################

# added by Anaconda3 2.5.0 installer
export PATH="/home/tordks/anaconda3/bin:$PATH"
