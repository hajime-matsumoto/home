# 
# .zshrc
#
# this file is loaded when user logined.
# if want to be loaded whenever zsh running.
# then add to .zshenv
#
export EDITOR=vim # Editor is vim

#
# setting
#
umask 022 # default umask
setopt no_beep # kill beep

#
# history setting
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt bang_hist # history expendable whin using "!"
setopt extended_history # save registerd time
setopt share_history # share history log with onather processes
setopt hist_ignore_all_dups # no duplication 
autoload history-search-end
#
# change directrory
#
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups 

function cd() {
    builtin cd $@ && ls;
}

#
# keybind
#
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey -e # key binding as emacs style
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:"

#
# prompt
#
#
#PROMPT='%(!,[ADMIN],[%n]) at %m %(?!(^_^)/!(T_T%)?) '
PROMPT='%(!,[ADMIN,[%n) at %m] %~'$'\n%(?!(^_^)/!(T_T%)?) '
#RPROMPT='[%~]'

# GIT
source ~/src/git-flow-completion/git-flow-completion.zsh
#
# alias
#
alias vi=vim
alias virc="vim ~/.vimrc"
alias vish="vim +VimShell"
alias vizshrc="vim ~/.zshrc"
alias ls="ls --color=auto"
alias ll="ls -l"
alias la="ls -la"
alias l="ls"

SSHAGENT=$(which ssh-agent)
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
	eval `$SSHAGENT $SSHAGENTARGS`
	trap "kill $SSH_AUTH_PID" 0
fi
