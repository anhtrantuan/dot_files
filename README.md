# Installation
* Clone this repository into your home folder: `git clone git@github.com:anhtrantuan/dot_files.git`
* Install [Vundle](https://github.com/VundleVim/Vundle.vim)
* Make symbolic (soft) link to .vimrc: `ln -s ~/dot_files/.vimrc ~/.vimrc` 
* Install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
* Make symbolic link to .tmux.conf:
  * For Mac: `ln -s ~/dot_files/.tmux.conf.mac ~/.tmux.conf`
  * For Linux: `ln -s ~/dot_files/.tmux.conf.linux ~/.tmux.conf`
* Make symbolic link to .tmux directory:
  * For Mac: `ln -s ~/dot_files/.tmux.mac ~/.tmux`
  * For Linux: `ln -s ~/dot_files/.tmux.linux ~/.tmux`
* Make symbolic link to .gitconfig:
  * For Mac: `ln -s ~/dot_files/.gitconfig.mac ~/.gitconfig`
  * For Linux: `ln -s ~/dot_files/.gitconfig.linux ~/.gitconfig`
* Make symbolic link to .gitignore_global: `ln -s ~/dot_files/.gitignore_global ~/.gitignore_global`
* Create ftdetect directory: `mkdir -p ~/.vim/ftdetect`
* Make symbolic link to .vim/ftdetect directory: `ln -s ~/dot_files/.vim/ftdetect/* ~/.vim/ftdetect/`
* Install Yarn
* Install packages for vim-prettier: `cd ~/.vim/bundle/vim-prettier && yarn install`
