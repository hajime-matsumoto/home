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

#
# prompt
#
#
PROMPT='%(!,[ADMIN],[%n]) at %m %(?!(^_^)/!(T_T%)?) '
#RPROMPT='[%~]'
#
# alias
#
alias vi=vim
alias virc="vim ~/.vimrc"
alias vish="vim +VimShell"
alias vizshrc="vim ~/.zshrc"
