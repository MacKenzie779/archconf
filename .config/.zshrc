if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx
fi

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
bindkey -v

setopt autocd
setopt interactivecomments
setopt extended_glob
setopt HIST_FIND_NO_DUPS

bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey '\e[H' beginning-of-line
bindkey ";5H" beginning-of-line
bindkey '\e[F' end-of-line
bindkey ";5F" end-of-line
bindkey "\e[3~" delete-char
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export DISPLAY=:1
export MANPAGER=less

echo 1/4: Loading zstyle, compinit...

zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit && compinit

echo 2/4: Initializing dependencies with zplug...

if [[ ! -d ~/.zplug ]];then
    git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug "mafredri/zsh-async", from:github
zplug "lib/completion", from:oh-my-zsh
zplug "themes/agnoster", use:agnoster.zsh, from:oh-my-zsh, as:theme
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3
zplug "MichaelAquilina/zsh-you-should-use"
zplug "zsh-users/zsh-autosuggestions", from:github
zplug "zsh-users/zsh-history-substring-search", as:plugin

echo 3/4: Loading zplug dependencies...

zplug load

if ! zplug check --verbose; then
    printf "Install zplug plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

echo 4/4: Setting aliases...

# ================================================================================================
# Aliases
#
#AOC
export AOC="~/Documents/other/aoc"
export AOC_COOKIE="53616c7465645f5f990568c8f7069b5ef9a85dca6109bb336c520d1fd5b7fce1d75edcad11c144f145c12adabe495c8c72a0379d7478e45012ca31b97c7ef073"

alias aos="cd $AOC; python3 solution.py < in.txt"
alias aot="cd $AOC; echo -ne '\\e[0;34m'; python3 solution.py < test.txt; echo -ne '\\e[0m'"
alias aoc "aot; echo; aos"

function aoc-load () {
	if [ $1 ]
	then
		curl --cookie "session=$AOC_COOKIE" https://adventofcode.com/$1/day/$2/input > in.txt
	else
		curl --cookie "session=$AOC_COOKIE" `date +https://adventofcode.com/%Y/day/%d/input` > in.txt
	fi
}

#
#
#
#
alias timesync="sudo timedatectl set-ntp true"
alias timesync2="sudo timedatectl --adjust-system-clock"
# copy to clipboard
alias toclip="wl-copy"

# CLI Music player
#alias wtfmusic="mpc rescan && ncmpcpp"
#alias music="mpc rescan && ncmpcpp"

# YouTube video using mpv in terminal
alias ytmusic="mpv --no-video"

#file operations
alias rm='rm -I'
alias mv='mv -i'
alias cp='cp -i'
alias df='df -h'
alias size='du -hs'
alias tree='find . -print | sed -e '\''s;[^/]*/;|____;g;s;____|; |;g'\'''

# List
alias ls='ls --color=auto -h --group-directories-first'
alias ll='ls --color=auto -lh --group-directories-first --time-style=+"%d.%m.%Y %H:%M" -F'

# Grep
alias grep='grep --color=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

# Misc
alias genpw='pwgen -c -n -y 48 1'
alias genpws='pwgen -c -n 48 1'
alias mp3dl='youtube-dl -x --audio-format mp3 --metadata-from-title "%(artist)s - %(title)s" -o "%(title)s.%(ext)s"'
alias reload='source ~/.zshrc'

#spwan ssh agent
alias ssha='eval "$(ssh-agent -s)"'

#other
alias timel='timedatectl set-ntp 1'
alias wlan='nmtui'
alias audio='pavucontrol'
alias nightlight='wlsunset -T 5500 & disown'
alias blstart='sudo systemctl enable --now bluetooth.service; blueman-applet; blueman-manager'
alias blstop='sudo systemctl disable --now bluetooth.service'

# # ex - archive extractor
# # usage: ex <file>
ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.gz)	   tar xzf $1   ;;
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.jar)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
   fi
}

#settings environment variables..
#export TERM=xterm-256color
#export EDITOR=/usr/bin/nvim # TODO
#export BROWSER=/usr/bin/qutebrowser # TODO
#export PAGER=/usr/bin/vimpager # TODO
export LANG=en_US.utf8
#export SCRIPT_DIR=$HOME/scripts
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=setting'

# clear screen before showing shell prompt
clear

# opam configuration
[[ ! -r /home/user/.opam/opam-init/init.zsh ]] || source /home/user/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
