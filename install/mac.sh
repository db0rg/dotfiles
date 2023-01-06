#!/bin/zsh
#

# build tools
function {
	if ! xcode-select --print-path &> /dev/null; then
		xcode-select --install

		until xcode-select --print-path &> /dev/null; do sleep 5; done

		echo "XCode installed, accept the license with the power of root!"
		sudo xcodebuild -license accept
	fi
	if ! which brew &> /dev/null; then
		echo "Installing brew"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
	brew tap homebrew/cask-fonts
	if [ $(brew --prefix) = /opt/homebrew ]; then
		brew shellenv >> ${0:a:h}/../zshenv.local
	fi
}

# brew casks
function {
	local casks_to_install=(font-firacode-nerd-font scroll-reverser dash iterm2 visual-studio-code slack)
	for cask in $casks_to_install; do
		if ! brew list --cask $cask &> /dev/null; then
			echo "Installing brew cask: $cask"
			brew install --cask "$cask"
		fi
	done
}

# brews
function {
	local brews_to_install=(kakoune tmux ripgrep bat lf graphviz zsh-autosuggestions zsh-fast-syntax-highlighting python)
	local brews_to_install=($brews_to_install coreutils entr exa findutils gawk go inetutils jq ul/kak-lsp/kak-lsp)
	local brews_to_install=($brews_to_install mawk rsync stdman tealdeer wget fd fzf zsh-completions)
	for brew in $brews_to_install; do
		if ! brew list $brew &> /dev/null; then
			echo "Installing brew: $brew"
			brew install "$brew"
		fi
	done
}

# language tools
function {
	if ! which go &> /dev/null; then
		echo "Error, go not installed"
		exit 1
	fi
	go install golang.org/x/tools/gopls@latest
	go install golang.org/x/tools/cmd/goimports@latest
	go install mvdan.cc/gofumpt@latest
	if ! which pip3 &> /dev/null; then
		echo "Error, python3 not installed (no pip3)"
		exit 1
	fi
	local py3_installed="$(pip3 list)"
	local py3_install=(pylint black 'python-language-server[all]' bpython numpy jupyter pandas matplotlib seaborn sklearn sqlparse)
	for pkg in $py3_install; do
		if ! (printf '%s' "$py3_installed" | grep $pkg &>/dev/null); then
			echo "pip3 install $pkg"
			pip3 install $pkg
		fi
	done
}

# Defaults
function {
	mkdir -p ~/Library/KeyBindings
	printf '{\n\t"^w" = "deleteWordBackward:";\n}' > ~/Library/KeyBindings/DefaultKeyBinding.dict

	defaults write com.apple.dock minimize-to-application -bool true
	defaults write com.apple.dock show-process-indicators -bool true
	defaults write com.apple.dock mru-spaces -bool false
	defaults write com.apple.dock autohide -bool true
	defaults write com.apple.dock show-recents -bool false
	killall Dock &> /dev/null

	defaults write com.apple.finder AppleShowAllFiles -bool true
	defaults write com.apple.finder NewWindowTarget PfHm
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true
	defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false 
	killall Finder &> /dev/null

	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

	# disable hot corners
	for corner in tl tr bl br; for mod in corner modifier; defaults write com.apple.dock "wvous-$corner-$mod" -int 0

	defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2"
	defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

}

