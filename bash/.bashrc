#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
#PS1='[\u@\h \W]\$ '
#PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h: \[\e[33m\]\w\[\e[0m\]\n\$ '
PS1='\[\e]0;\w\a\]\n\[\e[0;31m\][ \u@\h ]\[\e[1;32m\]$(parse_git_branch) \[\e[0;33m\]\w\[\e[0m\]\n\$ '

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

#Dark theme is broken :(
#alias firefox='env GTK_THEME=Adwaita:light firefox-nightly'

#Telegram
alias music='ncmpcpp'
alias usermount='sudo mount -o gid=users,fmask=113,dmask=002' 
alias pcache='sudo pacman -Sc'
alias porphan='sudo pacman -Rns $(pacman -Qtdq)'
alias rm='rm -i'
alias r='ranger'
alias censored='mpv --ytdl-raw-options=geo-bypass-country=US $1'
alias weather='curl wttr.in'

# vi mode in bash
# set -o vi

note ()
{
        #if file doesn't exist, create it
        [ -f ~/.notes ] || touch ~/.notes

        #no arguments, print file
        if [ $# = 0 ]
        then
                cat $HOME/.notes
        #clear file
        elif [ $1 = -c ]
        then
                > ~/.notes
        #add all arguments to file
        else
                echo "$@" >> ~/.notes
        fi
}

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
                echo " (${BRANCH})"
	else
		echo ""
	fi
}

#bu - Back Up a file. Usage "bu filename.txt"
bu () { 
    cp $1 ${1}-`date +%Y%m%d%H%M`.backup ;
}

# find and play audio from terminal
function mm() {
    mpv --ytdl-format=bestaudio ytdl://ytsearch:"$@"
}

function mv() {
    mpv --ytdl-format="bestvideo[height<=?1080]+bestaudio/best" ytdl://ytsearch:"$@"
}
