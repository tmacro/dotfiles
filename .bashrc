#
# ~/.bashrc
#

# start xorg if DISPLAY isn't set yet
if [ -z "${DISPLAY}" ] && [ -n "${XDG_VTNR}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
exec fish
