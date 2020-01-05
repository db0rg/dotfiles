export PATH=/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:~/.bin:~/go/bin:~/.local/bin
export EDITOR=vim
export SUDO_EDITOR="vim -Z"
export LC_ALL=en_US.UTF-8
if [[ -e $HOME/dotfiles/zshenv.local ]]; then
	source $HOME/dotfiles/zshenv.local
fi

