function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

	# Just calculate these once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		switch (uname)
			case 'CYGWIN_NT*'
				set -g __fish_prompt_hostname (hostname.exe | cut -d . -f 1 | sed '1s/^\s*./\U&\E/g')

			case '*'
				set -g __fish_prompt_hostname (hostname | sed '1s/^\s*./\U&\E/g')
		end
	end

	# Set User
	if not set -q __fish_prompt_username
		set -g __fish_prompt_username (whoami | sed '1s/^\s*./\U&\E/g')
	end

	# Set color of username based of last exit status
	set user_color (set_color cyan)
	if test $last_status -gt 0
		set user_color (set_color red)
	end

	# Print user@hostname
	printf '%s%s%s@%s%s' "$user_color" (echo -n $__fish_prompt_username) (set_color yellow) (set_color green) (echo -n $__fish_prompt_hostname)

	# Print pwd
	if test -w "."
		printf ': %s%s ' (set_color green) (prompt_pwd)
	else
		printf ': %s%s ' (set_color red) (prompt_pwd)
	end
end
