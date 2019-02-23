# basic
HISTFILE=~/.histfile
setopt histignorespace
HISTSIZE=20000
SAVEHIST=20000
export EDITOR='nvim'
export CLICOLOR=1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
alias vi='nvim'
alias rm='rm -i'

# for autocompletion
autoload -Uz compinit promptinit
compinit -i
promptinit
# make system zsh use homebrew zsh site-functions
if (( ! ${fpath[(I)/usr/local/share/zsh/site-functions]} )); then
  FPATH=/usr/local/share/zsh/site-functions:$FPATH
fi

# prompt
PROMPT='%F{yellow}%n%f>>%f%F{green}%1~%f%# '
# prompt for server with the host name
#PROMPT='%F{blue}%n%f@%F{red}%m%f>>%f%F{green}%1~%f%# '

# history search
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

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


