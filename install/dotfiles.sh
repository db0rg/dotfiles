#!/bin/zsh

function {
	local original_directory=`pwd`
	cd
	mkdir -p .config
	local to_link_home=(zshrc zshenv tmux.conf)
	local to_link_config=(kak kak-lsp lf)
	for file in $to_link_home $to_link_config
	do
		local target=".$file"
		local source="dotfiles/$file"
		if [[ ${to_link_config[(ie)$file]} -le ${#to_link_config} ]]; then
			local target=".config/$file"
			local source="../dotfiles/$file"
		fi
		## need to check this first b'c otherwise get problem
		#with files in subdirectories or pointing to non-existing
		#files registering as nonexisting
		if [[ -L "$target" ]]
		then
			rm "$target"
		elif [[ -e "$target" ]]
		then
			mv "$target" "$target.backup$(date +'%Y%m%dT%H%M')"
		fi
		ln -s "$source" "$target"
	done
	cd "$original_directory"
}

