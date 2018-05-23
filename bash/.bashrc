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
alias telegram='.telegram/Telegram'
alias music='ncmpcpp'
alias usermount='sudo mount -o gid=users,fmask=113,dmask=002' 
alias pcache='sudo pacman -Sc'
alias porphan='sudo pacman -Rns $(pacman -Qtdq)'
alias rm='rm -i'
alias r='ranger'

# vi mode in bash
# set -o vi

extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1        ;;
             *.tar.gz)    tar xvzf $1        ;;
             *.bz2)       bunzip2 $1        ;;
             *.rar)       unrar x $1        ;;
             *.gz)        gunzip $1         ;;
             *.tar)       tar xvf $1         ;;
             *.tbz2)      tar xvjf $1        ;;
             *.tgz)       tar xvzf $1        ;;
             *.zip)       unzip $1          ;;
             *.Z)         uncompress $1     ;;
             *.7z)        7z x $1           ;;
             *.tar.xz)    tar xvJf $1        ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

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
