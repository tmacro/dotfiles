function _ssh_agent_is_started -d "check if ssh agent is already started"
    if test -z "$SSH_AGENT_PID" -a -f $SSH_ENV
		source $SSH_ENV > /dev/null
	end

	if test -z "$SSH_AGENT_PID"
		return 1
	end

	ssh-add -l 2>/dev/null 1>/dev/null
	if test $status -eq 2
		return 1
	end
end
