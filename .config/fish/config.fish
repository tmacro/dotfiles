#!/usr/bin/fish

# TODO Think of better shell greeting
set fish_greeting # Disable shell greeting

direnv hook fish | source

set -l config_dir (dirname (status --current-filename))

alias gs "git status"

# If this is an interactive shell
if status --is-interactive
	# Do some stuff
	today dir create
	today note create
end
