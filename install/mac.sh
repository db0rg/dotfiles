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
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
}

# brew casks
function {
	local casks_to_install=(r rstudio osxfuse karabiner-elements java font-firacode-nerd-font scroll-reverser dash iTerm2)
	for cask in $casks_to_install; do
		if ! brew cask list $cask &> /dev/null; then
			echo "Installing brew cask: $cask"
			brew cask install "$cask"
		fi
	done
}

# brews
function {
	local brews_to_install=(kakoune tmux ripgrep bat lf graphviz zsh-autosuggestions zsh-syntax-highlighting python)
	local brews_to_install=($brews_to_install coreutils entr exa findutils gawk go inetutils jq ul/kak-lsp/kak-lsp)
	local brews_to_install=($brews_to_install mawk rsync sshfs stdman tldr unrar wget)
	for brew in $brews_to_install; do
		if ! brew list $brew &> /dev/null; then
			echo "Installing brew: $brew"
			brew install "$brew"
		fi
	done
}

# language tools
function {
	if ! (echo 'library("languageserver")' | R --slave &> /dev/null) ; then
		echo 'install.packages("languageserver", repos="https://cloud.r-project.org")' | R --slave
	fi
	if ! which go &> /dev/null; then
		echo "Error, go not installed"
		exit 1
	fi
	GO111MODULE=on go get golang.org/x/tools/gopls@latest
	if ! which goimports &> /dev/null; then
		go get golang.org/x/tools/cmd/goimports
	fi
	if ! which pip3 &> /dev/null; then
		echo "Error, python3 not installed (no pip3)"
		exit 1
	fi
	local py3_installed="$(pip3 list)"
	local py3_install=(pylint black pyls bpython numpy jupyter pandas matplotlib seaborn sklearn)
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

	defaults write com.apple.dock tilesize -int 74
	defaults write com.apple.dock minimize-to-application -bool true
	defaults write com.apple.dock show-process-indicators -bool true
	defaults write com.apple.dock mru-spaces -bool false
	defaults write com.apple.dock autohide-delay -float 0
	defaults write com.apple.dock autohide-time-modifier -float 0.5
	defaults write com.apple.dock autohide -bool true
	defaults write com.apple.dock magnification -bool false
	killall Dock &> /dev/null

	defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

	defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2"
	defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
}

