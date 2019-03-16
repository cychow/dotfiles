#
# ~/.bashrc
#
# source aliases file
source ~/.bash_aliases
export DISPLAY=:0
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

complete -d cd
complete -Efd

alias ls='ls --color=auto'
alias la='ls -lauh'
alias sourcerc='source ~/.bashrc'

# PS1='[\u@\h \W]\$ '
# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}


export PS1="\[\e[34m\][\u@\h]\[\e[94m\][\W]\[\e[36m\]\`parse_git_branch\`\[\\e[0m\]\$ "
export PS1="\[\e[34m\][\u@\h]\[\e[94m\][\W]\[\e[36m\]\\[\\e[0m\]\$ "

trap 'echo -ne "\033]0;$BASH_COMMAND\007"' DEBUG
function show_name(){ 
    if [[ -n "$BASH_COMMAND" ]]; 
    then 
    echo -en "\033]0;`pwd`\007"; 
    else 
    echo -en "\033]0;$BASH_COMMAND\007"; 
    fi 
}
export PROMPT_COMMAND='show_name'

export PATH=$PATH:'/cygdrive/c/Program Files (x86)/Zandronum'

alias tmux='tmux -u'
