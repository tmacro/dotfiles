#!/bin/sh

source ~/.xprofile
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
exec /usr/bin/i3 --shmlog-size=26214400 -d all 1>~/.i3.log 2>&1 
