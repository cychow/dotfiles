#
# ~/.bashrc
#
# source aliases file

export PATH=/home/chris/WSL2-Linux-Kernel/tools/perf:$PATH

# shopts
shopt -s checkwinsize
shopt -s direxpand


if [[ "$TERM" =~ "screen".* ]]; then
  # echo "We are in TMUX!"
  # echo "launching tmux..."
  set aaa="0"
else
#  echo "We are not in TMUX :/  Let's get in!"
  # Launches tmux in a session called 'base'.
  tmux new 
fi

source ~/.bash_aliases
export DISPLAY=:0
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

complete -d cd
complete -Efd

alias ls='ls -v --color=auto'
alias la='ls -lauhv'
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
export PATH=$PATH:'/cygdrive/c/Program Files/Perforce'
export P4HOST='ue4jam/Spring_ue4jam_60'
export P4PORT='ssl:perforce-us-east.assembla.com:1667'
export P4USER='fenixfurion'
export P4CLIENT='ue4jam_stuckatwork'

alias tmux='tmux -u'
alias sl=ls

alias profile="python3 -m cProfile -s tottime"
export PS1="\\[\\e[34m\\][\\u]\\[\\e[94m\\][\\W]\\[\\e[36m\\]\\[\\e[0m\\]$ "


# prompt command
function prompt_command {
    export PS1=`~/scripts/bashprompt.py`
    # if workarea >/dev/null 2>&1 ; then
    #     if [[ "$PWD" =~ \._work ]]
    #     then
    #         export wa=`workarea ` 2>/dev/null
    #         export WA=$wa
    #         export workarea=$wa
    #         export dvtk=$wa/sys_dve_lib/modules/sys_dv/dvtk 2>/dev/null
    #     fi
    # fi
    # export directory to window title
    /bin/echo -ne "\033]0;`/bin/echo $PWD | tail -c 60`\007"
    qdbus org.kde.konsole $KONSOLE_DBUS_SESSION setTitle 1 $(/bin/echo  $PWD | tail -c 600 &>/dev/null)
    # then update tmux colors
    if [[ $PWD != $OLDPWD ]]; then
        ~/scripts/change_tmux_color.sh $PWD
    fi
}
# export PROMPT_COMMAND=prompt_command

# cd autoparent
function cd_autoparent {
    if [[ -f $@ ]]; then
        echo "$@ is a file - going to parent dir"
        'cd' `dirname $@`
        pwd
    else
        'cd' $@
        if [[ ( $@ != "-" ) ]]; then
            pwd
        fi
    fi
}

alias cd=cd_autoparent

alias cd..="cd .."

complete -d cd
complete -Efd


