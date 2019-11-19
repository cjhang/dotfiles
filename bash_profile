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

# PS1 promp
PS1="\[\e[34m\]\u\[\e[m\]@\[\e[31m\]\h\[\e[m\]>>\[\e[32m\]\w\[\e[m\]\\$ "

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Searching forward and back
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "/usr/local/share/bash-completion/bash_completion" ]; then
	source "/usr/local/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# local software
[ -f $HOME/.local/share/z.sh ] && source $HOME/.local/share/z.sh
export PATH=$PATH:$HOME/.local/bin
# homebrew
export HOMEBREW_CASK_OPTS='--appdir="/Users/cjhang/Applications"'
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1

# Miniconda
export PATH="$PATH:$HOME/.local/miniconda3/bin"
alias load='conda activate'
alias quit='conda deactivate'

