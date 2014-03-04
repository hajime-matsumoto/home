if ( -x `which zsh` ) then
	exec zsh
else if ( -x `which bash` ) then
	exec bach
else
	if ( !$?SHELL ) then
		setenv SHELL /bin/csh
	endif
endif
