#!/bin/zsh

# packages
function {
	# sudo apt-get update
	local packages_to_install=(kakoune tmux ripgrep bat zsh-autosuggestions zsh-syntax-highlighting)
	local packages_to_install=($packages_to_install golang jq entr tldr python3 python3-pip)
	local packages_to_install=($packages_to_install curl coreutils findutils awk mawk rsync wget)
	local installed_packages=$(dpkg --get-selections | cut -f1)
	for pkg in $packages_to_install; do
		if [[ ! $installed_packages =~ $pkg ]]; then
			sudo apt-get install $pkg
		fi
	done
}

## rust and kak-lsp
function {
	local PATH=~/.cargo/bin:$PATH
	if ! which cargo &>/dev/null; then
		echo "Installing rust"
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	fi

	mkdir -p ~/git-install/
	if [[ ! -e ~/.cargo/bin/kak-lsp ]]; then
		local original_directory=`pwd`
		cd ~/git-install/
		git clone https://github.com/ul/kak-lsp
		cd kak-lsp
		cargo install --locked --force --path .
		cd "$original_directory"
	fi
}

# go tools
function {
	local go_modules=(golang.org/x/tools/gopls mvdan.cc/gofumpt mvdan.cc/gofumpt/gofumports)
	local go_packages=(github.com/zmb3/gogetdoc golang.org/x/tools/cmd/goimports github.com/nsf/gocode github.com/gokcehan/lf)
	for pkg in $go_packages $go_modules; do
		if ! which $(basename $pkg) &>/dev/null; then
			local extra=""
			local modules="off"
			if [[ ${go_modules[(ie)$pkg]} -le ${#go_modules} ]]; then
				local extra="@latest"
				local modules="on"
			fi
			GO111MODULE=$modules go get ${pkg}${extra}
		fi
	done
}

# python tools
function {
	local py3_installed="$(pip3 list)"
	local py3_install=(pylint black pyls bpython numpy jupyter pandas matplotlib seaborn sklearn)
	for pkg in $py3_install; do
		if ! (printf '%s' "$py3_installed" | grep $pkg &>/dev/null); then
			echo "pip3 install $pkg"
			pip3 install $pkg
		fi
	done
}
