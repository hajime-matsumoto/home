# 
# .zshrc
#
# this file is loaded when user logined.
# if want to be loaded whenever zsh running.
# then add to .zshenv
#

export EDITOR=vim # Editor is vim
#export LANG=ja_JP.URF8 # japanese
#export KCODE=u # KanjiCode is UTF8


#bindkey -v # key binding as vi style
bindkey -e # key binding as emacs style
bindkey "^R" history-incremental-search-backward # form <C-r> start history search

umask 022 # default umask
setopt no_beep # kill beep


#
# about cd
#

# type directory = cd directory
setopt auto_cd

# cd = pushd
setopt auto_pushd
setopt pushd_ignore_dups # no duplications

#
# about history
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt bang_hist # history expendable whin using "!"
setopt extended_history # save registerd time
setopt share_history # share history log with onather processes
setopt hist_ignore_all_dups # no duplication 

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#
# Look And Feel
#
autoload -U colors; colors
export LSCOLORS=exgxfxdxcxdxdxbxadacec
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true

## Prompt
setopt prompt_subst # evaluate $PROMPT every time 

## use zsh typo currect
setopt correct


function get-branch-info {
	if [[ "$PWD" =~ '/\.git(/.*)?%' ]]; then
		return
	fi

	local branchname=`get-branch-name`
	if [[ -z $branchname ]] then
		return
	fi
	echo " %F{6}|%f %F{2}git%f %F{6}|%f $branchname %F{6}|%f `get-branch-status` %F{6}|%f"
}

function get-branch-name {
	echo `git rev-parse --abbrev-ref HEAD 2> /dev/null`
}
function get-branch-status {
	local res
	output=`git status 2> /dev/null`
	if [[ -n `echo $output | grep "^nothing to commit"` ]]; then
		res='%F{2}*%f' # status Clean
	elif [[ -n `echo $output | grep "^# Untracked files:"` ]]; then
		res='%F{5}Untracked%f' # Untracked
	elif [[ -n `echo $output | grep "^# Changes not staged for commit:"` ]]; then
		res='%F{5}Modified%f' # Modified
	else
		res='%F{1}Added%f' # Added to commit
	fi
	echo ${res}
}
	

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats ':(%s)%b'
zstyle ':vcs_info:*' actionformats ':(%s)%b|%a'

# 0:black、1:red、2:green、3:yellow、4:blue、5:magenta、6:cyan、7:white
local p_info="%B%F{2}%n at %m%f%b"
local p_dir_info=$'(`pwd`)%F{6}%d%f$(`get-branch-info`) %D %T'
local p_char='%F{6}%(?!(^_^)/!(T_T%)?)%f'
local p_admin_char='%F{6}%(?!(%F{1}o%f%F{6}_%f%F{1}o%f%F{6})/!(T_T%)?)%f'
local p_mark=" %(!,$p_admin_char,$p_char) <%(!,%B%F{1}root%B%f,%F{3}%n%f)> %(!,#,$)"

PROMPT='$p_info %d`get-branch-info`'$'\n'
PROMPT+='=$p_mark '
RPROMPT+='%D %T'
PROMPT2='=>'

# もしかして時のプロンプト指定
SPROMPT='=%F{3}(o_o)!%f < %Bdid you mean %B%r%b? [yes(y), no(n)]%b'


#
# functions
#

# When cd, show list.
function cd() {
    builtin cd $@ && ls;
}

# add
source ~/.zsh/gitflow-completion.sh

# alias
#alias su='sudo -H -s'
alias su='sudo -s' 

# rbenv
eval "$(rbenv init -)"

