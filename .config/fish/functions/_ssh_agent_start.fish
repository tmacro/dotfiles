function _ssh_agent_start -d "start a new ssh agent"
  ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
  # Convert the environment file to systemd env format
  cat $SSH_ENV | grep -v '#' | sed 's/^setenv \(SSH_AUTH_SOCK\|SSH_AGENT_PID\) \(.*\);/\1=\2/' > $SSH_ENV.env
  chmod 600 $SSH_ENV
  chmod 600 $SSH_ENV.env
  source $SSH_ENV > /dev/null
end
