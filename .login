if ( -x `which zsh` ) then
	exec zsh
else if ( -x `which bash` ) then
	exec bach
end
