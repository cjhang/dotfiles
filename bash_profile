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

# Miniconda
export PATH="$PATH:$HOME/.local/miniconda3/bin"
alias load='source activate'
alias quit='source deactivate'

