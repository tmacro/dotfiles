if test -z "$SSH_ENV"
    set -xg SSH_ENV $HOME/.ssh/environment
end

if not _ssh_agent_is_started
    _ssh_agent_start
end

ssh-add -l 2>&1 1>/dev/null
if test $status -eq 1
    command ssh-add ~/.ssh/tmac@cloud
    command ssh-add ~/.ssh/tmacro@scality
end
