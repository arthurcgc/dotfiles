.PHONY: install
install:
	ln -s .alacritty.yml ~/.alacritty.yml
	ln -s .tmux.conf ~/.tmux.conf

.PHONY: bashrc
bashrc:
	cp .bashrc ~/.bashrc
