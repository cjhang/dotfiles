# basic
HISTFILE=~/.histfile
setopt histignorespace
HISTSIZE=20000
SAVEHIST=20000
export CLICOLOR=1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# set the default editor
#export EDITOR='nvim'
#alias vi='nvim'
alias rm='rm -i'
alias ls='ls --color'

# for autocompletion
autoload -Uz compinit promptinit
compinit -i
promptinit

# prompt
PROMPT='%F{yellow}%n%f>>%f%F{green}%1~%f%# '
# prompt for server with the host name
#PROMPT='%F{blue}%n%f@%F{red}%m%f>>%f%F{green}%1~%f%# '

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "$terminfo[kcuu1]" history-beginning-search-backward-end
bindkey "$terminfo[kcud1]" history-beginning-search-forward-end

# MacOS special
# make system zsh use homebrew zsh site-functions
#if (( ! ${fpath[(I)/usr/local/share/zsh/site-functions]} )); then
  #FPATH=/usr/local/share/zsh/site-functions:$FPATH
#fi
# local software
#[ -f $HOME/.local/share/z.sh ] && source $HOME/.local/share/z.sh
#[ -f /usr/local/etc/profile.d/autojump.sh ] && source /usr/local/etc/profile.d/autojump.sh
#export PATH=$PATH:$HOME/.local/bin
# homebrew
#export HOMEBREW_CASK_OPTS='--appdir="/Users/cjhang/Applications"'
#export HOMEBREW_NO_ANALYTICS=1
#export HOMEBREW_NO_AUTO_UPDATE=1

# Miniconda setting
#export PATH="$PATH:$HOME/.local/miniconda3/bin"
#alias load='conda activate'
#alias quit='conda deactivate'

# python
#export PYTHONPATH="$HOME/.local/python"

