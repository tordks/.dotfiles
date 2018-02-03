
IDIR =../include
CC=gcc
CFLAGS=-I$(IDIR)

ODIR=obj
LDIR =../lib

LIBS=-lm

link: 
	ln -s ${PWD}/.tmux.conf ${PWD}/../.tmux.conf
	ln -s ${PWD}/.gitconfig ${PWD}/../.gitconfig
	ln -s ${PWD}/bash/.bashrc ${PWD}/../.bashrc
	ln -s ${PWD}/bash/.bash_profile ${PWD}/../.bash_profile
	ln -s ${PWD}/nvim/init.vim ${PWD}/../.config/nvim/init.vim
	#ln -s ${PWD}/


update:
	ln -snf ${PWD}/.tmux.conf ${PWD}/../.tmux.conf
	ln -snf ${PWD}/.gitconfig ${PWD}/../.gitconfig
	ln -snf ${PWD}/bash/.bashrc ${PWD}/../.bashrc
	ln -snf ${PWD}/bash/.bash_profile ${PWD}/../.bash_profile
	ln -snf ${PWD}/nvim/init.vim ${PWD}/../.config/nvim/init.vim
	
