#!/bin/zsh

# zmodload zsh/zprof


#Options

setopt extendedglob #Allows extended regexp
setopt interactivecomments #Allow commenting out WIP in command line
setopt nobgnice #Dont run background jobs with lower priority
setopt nohup #Dont quit background jobs when exit the shell
setopt nobeep

export KEYTIMEOUT=1 #Don't wait for stuff after esc too long
umask 022
tabs -4

WORDCHARS='*?-.[]~=&;!#$%^(){}<>' #Back kill
export BAT_THEME="OneHalfLight"

##History
# should hold about 2 years of daily use about 1M
export HISTSIZE=32768
export HISTFILE="$HOME/.zhist"
export SAVEHIST=$HISTSIZE
setopt sharehistory #Share hist between sessions of zsh
setopt histignorealldups #Ignore duplicate commands in history
setopt histreduceblanks #Removes all unimportant blanks


#Aliases
alias source_config="source ~/dotfiles/zshenv && source ~/dotfiles/zshrc"
alias edit_config="kak ~/dotfiles/zshrc"
alias grep='grep --colour=auto'
qvim() {
	vim -u NONE $@
}


# Mac specific options
if [[ `uname` == 'Darwin' ]]; then
	#Aliases#
	alias vpbcopy="tee /dev/stderr | pbcopy"


	alias ls='ls -G'
else
	alias ls='ls --color=auto'
fi

# Use if available
function {
	local installed_to=/usr
	if [[ `uname` == 'Darwin' ]]; then
		local installed_to="$(brew --prefix)"
		if [[ -e ${installed_to}/share/zsh/site-functions/ ]]; then
			fpath=(${installed_to}/share/zsh/site-functions $fpath)
		fi
	fi
	if [[ -e ${installed_to}/share/zsh-completions ]]; then
		fpath=(${installed_to}/share/zsh-completions $fpath)
	fi
	if [[ -e ${installed_to}/opt/zsh-fast-syntax-highlighting/ ]]; then
		source ${installed_to}/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
	fi
	if [[ -e ${installed_to}/share/zsh-syntax-highlighting/ ]]; then
		source ${installed_to}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	fi
	if [[ -e ${installed_to}/share/zsh-autosuggestions/ ]]; then
		source ${installed_to}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	fi
}

#oh-my-zsh-replacement
# ZSH_COMPDUMP is set by oh-my-zsh, so if not do replacement
if [ ! $ZSH_COMPDUMP ]; then
	autoload -Uz compinit
	## Checks if zcompdump older than 24 hours
	if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]
	then
		compinit
		touch ${HOME}/.zcompdump
		zcompile ${HOME}/.zcompdump
	else
		compinit -C
	fi
	zmodload -i zsh/complist

	##stuff from oh-my-zsh/lib/completion.zsh
	unsetopt menu_complete   # do not autoselect the first completion entry
	unsetopt flowcontrol
	setopt auto_menu         # show completion menu on successive tab press
	setopt complete_in_word
	setopt always_to_end
	zstyle ':completion:*:*:*:*:*' menu select
  zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
	zstyle ':completion:*' special-dirs true
	zstyle ':completion:*' list-colors ''
	zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
  zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
	zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
	zstyle ':completion::complete:*' use-cache 1
	mkdir -p $HOME/.cache/zsh
	zstyle ':completion::complete:*' cache-path $HOME/.cache/zsh
	# Don't complete uninteresting users
	zstyle ':completion:*:*:*:users' ignored-patterns \
	        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
	        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
	        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
	        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
	        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
	        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
	        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
	        usbmux uucp vcsa wwwrun xfs '_*'

	# ... unless we really want to.
	zstyle '*' single-ignored show

	##Prompt
	autoload -Uz vcs_info
	zstyle ':vcs_info:*' enable git
	zstyle ':vcs_info:*' check-for-changes 'true'
	zstyle ':vcs_info:*' stagedstr '%F{green}✓%f'
	zstyle ':vcs_info:*' unstagedstr '%F{red}✗%f'
	zstyle ':vcs_info:*' formats ' %F{blue}%b%f %c%u'
	zstyle ':vcs_info:*' actionformats ' %F{blue}%b%F{red}[%a]%f%c%u'
	precmd() { vcs_info }
	setopt prompt_subst
	PROMPT=`printf '%%F{green}%%U%%~%%u$vcs_info_msg_0_\n%%F{cyan}➤%%f '`
	RPROMPT='%(?..%F{red}%?⏎%f )%*'
	if [ -n "$TMUX" ]
	then
		ZLE_RPROMPT_INDENT=0
	fi

	#automatic pushd
	setopt auto_pushd
	setopt pushd_ignore_dups
	setopt pushdminus
	alias 1='cd -'
	alias 2='cd -2'
	alias 3='cd -3'
	alias 4='cd -4'
	alias 5='cd -5'
	alias 6='cd -6'
	alias 7='cd -7'
	alias 8='cd -8'
	alias 9='cd -9'
fi

autoload zrecompile
zrecompile -p $HOME/.zshrc -- $HOME/.zshenv

#Keybindings#
bindkey -v
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history

bindkey '^[[3~' delete-char            # Del
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^R' history-incremental-search-backward
bindkey -M viins '^S' history-incremental-search-forward
bindkey -M vicmd '^S' history-incremental-search-forward

bindkey -M viins '^f' forward-char
bindkey -M viins '^a' vi-beginning-of-line
bindkey -M viins '^b' backward-char
bindkey -M viins '^e' vi-end-of-line
bindkey -M viins '^k' kill-line


function zle-keymap-select zle-line-init {
	case $KEYMAP$TMUX in
		vicmd)      print -n -- "\E]50;CursorShape=0\C-G";; # block cursor
		vicmd/*)      print -n -- "\EPtmux;\E\E]50;CursorShape=0\C-G\E\\";; # block cursor
		viins|main) print -n -- "\E]50;CursorShape=1\C-G";; # line cursor
		viins/*|main/*) print -n -- "\EPtmux;\E\E]50;CursorShape=1\C-G\E\\";; # line cursor
	esac
	zle -R
}

zle-line-finish() {
	case $TMUX in
		"")      print -n -- "\E]50;CursorShape=0\C-G";; # block cursor
		/*)      print -n -- "\EPtmux;\E\E]50;CursorShape=0\C-G\E\\";; # block cursor
	esac
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
bindkey -M viins '^j' autosuggest-execute
bindkey -M viins '^z' autosuggest-clear
bindkey -M viins '^ ' vi-forward-word

function lfcd() {
	local tmp="$(mktemp)"
	lf -last-dir-path="$tmp" "$@"
	if test -f "$tmp"
	then
		local dir="$(cat "$tmp")"
		rm -f "$tmp"
		if test -d "$dir" -a "$dir" != "$(pwd)"
		then
			cd "$dir"
		fi
	fi
}
# Need to be carefule to not let bad auto-suggestions get in the way here
bindkey -s '^o' '\eI#^z\nlfcd^z\n'


#Local zshrc
if [[ -e $HOME/dotfiles/zshrc.local ]]; then
	source $HOME/dotfiles/zshrc.local
	zrecompile -p $HOME/dotfiles/zshrc.local
fi
if [[ -e $HOME/dotfiles/zshenv.local ]]; then
	zrecompile -p $HOME/dotfiles/zshenv.local
fi

# zprof
# zmodload -u zsh/zprof
