# TODO: make this more intelligent
# TODO: move .zsh to .config
# TODO: add installation of xcape (for mapping esc to ctrl)

link:
	make linkzsh
	#make linkbash
	make linkvim
	make linktmux
	make linkgit

linkzsh: 
	ln -s ${PWD}/zsh/.zshrc ${PWD}/../.zshrc
	ln -s ${PWD}/zsh/.zshrc_antigen ${PWD}/../.zsh/.zshrc_antigen
	ln -s ${PWD}/zsh/.zshrc_base ${PWD}/../.zsh/.zshrc_base
	ln -s ${PWD}/zsh/.zshrc_from_bashrc ${PWD}/../.zsh/.zshrc_from_bashrc
	curl -L git.io/antigen > zsh/antigen.zsh
	ln -s ${PWD}/zsh/antigen.zsh ${PWD}/../.zsh/antigen.zsh
linkvim:
	ln -s ${PWD}/nvim/init.vim ${PWD}/../.config/nvim/init.vim
	ln -s ${PWD}/nvim/init_settings.vim ${PWD}/../.config/nvim/init_settings.vim
	ln -s ${PWD}/nvim/init_mappings.vim ${PWD}/../.config/nvim/init_mappings.vim
	ln -s ${PWD}/nvim/init_funcs.vim ${PWD}/../.config/nvim/init_funcs.vim
	ln -s ${PWD}/nvim/init_plugins.vim ${PWD}/../.config/nvim/init_plugins.vim
linktmux:
	ln -s ${PWD}/.tmux.conf ${PWD}/../.tmux.conf
linkgit:
	ln -s ${PWD}/.gitconfig ${PWD}/../.gitconfig
linkbash:
	ln -s ${PWD}/bash/.bashrc ${PWD}/../.bashrc
	ln -s ${PWD}/bash/.bash_profile ${PWD}/../.bash_profile


update:
	ln -snf ${PWD}/.tmux.conf ${PWD}/../.tmux.conf
	ln -snf ${PWD}/.gitconfig ${PWD}/../.gitconfig
	ln -snf ${PWD}/bash/.bashrc ${PWD}/../.bashrc
	ln -snf ${PWD}/bash/.bash_profile ${PWD}/../.bash_profile
	ln -snf ${PWD}/zsh/.zshrc ${PWD}/../.zshrc
	ln -snf ${PWD}/zsh/.zshrc_antigen ${PWD}/../.zsh/.zshrc_antigen
	ln -snf ${PWD}/zsh/.zshrc_base ${PWD}/../.zsh/.zshrc_base
	ln -snf ${PWD}/zsh/.zshrc_bashrc ${PWD}/../.zsh/.zshrc_from_bashrc
	ln -snf ${PWD}/zsh/.antigen.zsh ${PWD}/../.zsh/antigen.zsh
	ln -snf ${PWD}/nvim/init.vim ${PWD}/../.config/nvim/init.vim
	ln -snf ${PWD}/nvim/init_settings.vim ${PWD}/../.config/nvim/init_settings.vim
	ln -snf ${PWD}/nvim/init_mappings.vim ${PWD}/../.config/nvim/init_mappings.vim
	ln -snf ${PWD}/nvim/init_funcs.vim ${PWD}/../.config/nvim/init_funcs.vim
	ln -snf ${PWD}/nvim/init_plugins.vim ${PWD}/../.config/nvim/init_plugins.vim
	
