if test -z "$SSH_ENV"
    set -xg SSH_ENV $HOME/.ssh/environment
end

if not _ssh_agent_is_started
    _ssh_agent_start
end

if test ! -f ~/.ssh/agent.keys
    echo "No keys configured. Not starting agent."
    exit 0
end

ssh-add -l 2>&1 1>/dev/null
if test $status -eq 1
    for key in (cat ~/.ssh/agent.keys);
        ssh-add ~/.ssh/$key
    end
end
