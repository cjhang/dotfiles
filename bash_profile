# basic
export HISTSIZE=20000
if hash nvim 2>/dev/null; then
    export EDITOR='nvim'
    alias vi='nvim'
fi
export CLICOLOR=1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
alias rm='rm -i'
alias ls='ls --color=auto'

# change the color of full-accessible directories
export LS_COLORS=$LS_COLORS:'tw=01;35:ow=01;35:'

# PS1 promp
PS1="[\[\e[34m\]\u\[\e[m\]@\[\e[31m\]\h\[\e[m\] \[\e[32m\]\w\[\e[m\]]\n\\$ "

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Searching forward and back
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# allow completion ignore the cases
bind "set completion-ignore-case on"

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "/usr/local/share/bash-completion/bash_completion" ]; then
	source "/usr/local/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# local software
export PATH=$PATH:$HOME/.local/bin

# Miniconda
export PATH="$PATH:$HOME/.local/miniconda3/bin"
alias load='conda activate'
alias quit='conda deactivate'

# python
export PYTHONPATH="$HOME/.local/python"

alias run='just --justfile ~/.justfile --working-directory $HOME'

# local compiled software
#export PATH="$HOME/apps/bin:$PATH"
#export LDFLAGS="-L$HOME/apps/lib $LDFLAGS"
#export CPPFLAGS="-I$HOME/apps/include $CPPFLAGS"
#export MANPATH="$HOME/apps/share/man/:$MANPATH"
#export INFOPATH="$HOME/apps/share/info/:$INFOPATH"
#export LD_LIBRARY_PATH="$HOME/apps/lib:$LD_LIBRARY_PATH"
#export CC=gcc-11.4
#export CXX=c++-11.4
#export CPP=cpp-11.4
#export FC=gfortran-11.4
#export PKG_CONFIG_PATH="$HOME/applications/lib/pkgconfig:$PKG_CONFIG_PATH"
