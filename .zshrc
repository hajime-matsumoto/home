# 
# .zshrc
#
# this file is loaded when user logined.
# if want to be loaded whenever zsh running.
# then add to .zshenv
#
# key bind
bindkey -v # binding as vi style


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
setopt hist_ignore_all_dups # no duplication 

