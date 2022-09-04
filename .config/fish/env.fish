#
# Place environment variables here
#

# Set some standard vars
set -x VISUAL nano
set -x EDITOR $VISUAL
set -x SHELL /usr/bin/fish

# User scripts in ~/.toolbelt
set -x PATH $PATH $HOME/.toolbelt

# Locally compiled binaries in ~/.local/bin
set -x PATH $HOME/.local/bin $PATH

# Todays scratch dir and notes file
set -x TD $HOME/scratch/(command date +'%Y.%m.%d')
set -x TN $HOME/notes/(command date +'%Y.%m.%d.md')

# Set sentinel
set -x $__backpack_env "1"

# Scaling for Firefox
# set -x GDK_DPI_SCALE 2
