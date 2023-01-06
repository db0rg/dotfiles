#!/bin/zsh

${0:a:h}/install/dotfiles.sh

#The main reason behind splitting things is having access to PATH from zshenv in setup script

if [[ `uname` = 'Darwin' ]]; then
	${0:a:h}/install/mac.sh
fi
