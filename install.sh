#!/bin/zsh

${0:a:h}/install/dotfiles.sh

#The main reason behind splitting things is having access to PATH from zshenv in setup script

if [[ `uname` = 'Darwin' ]]; then
	${0:a:h}/install/mac.sh
fi

if [[ `uname` = 'Linux' ]]; then
	if ! which locale-gen &>/dev/null; then
		echo "Locale-gen not installed, please install manually"
		echo "Then run sudo locale-gen en_US.UTF-8"
		exit 1
	fi
	if which apt-get &>/dev/null; then
		${0:a:h}/install/apt.sh
	fi
fi
