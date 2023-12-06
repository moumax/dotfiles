############
## .zshrc ##
############
# by Marco
# ~/.zshrc

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="marco"

plugins=(
	git
	command-not-found
	zsh-autosuggestions
	zsh-syntax-highlighting
	rust
)

source $ZSH/oh-my-zsh.sh

# Add ctrl+space to autocomplete in prompt.
bindkey '^ ' autosuggest-accept

# Remove all unnecessary aliases created by oh-my-zsh
unalias ${(k)aliases}
unalias "..."
unalias "...."
unalias "....."
unalias "......"

# Clear the terminal
alias c="clear"

# Change directory aliases
alias d="cd $HOME"
alias dev="cd $HOME/dev"
alias dot="cd $HOME/dotfiles"

# List aliases
alias la="ls -lAh"
alias ll="ls -l"
alias ls="ls --color=tty"

# TMUX aliases
alias tm="tmux -f $HOME/dotfiles/tmux/.tmux.conf new -s"
alias tma="tmux attach-session" # The last session.
alias tman="tmux attach-session -t"
alias tmls="tmux ls"
alias tmk="tmux kill-session -t"

# Git aliases
alias gs='git status'
alias gaa='git add .'
alias gc='git commit -m'
alias gpo='git pull origin'
alias gp='git push'

# Launch lazygit
alias laz="lazygit"

alias n="nvim"
alias vim="nvim"

# Colored man
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Add ~/.local/bin directory to the PATH
export PATH="/home/.local/bin:$PATH"

# Add ~/.config as XDG_CONFIG_HOME
export XDG_CONFIG_HOME=$HOME/.config

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Every time I open a new terminal.
tmux has-session -t Marco || \
	tmux -f $HOME/.tmux.conf new -s Marco -n server \; \
	new-window -c ~/ -n nvim1 \; \
	new-window -c ~/ -n nvim2 \; \
	select-window -t 1 \; \
	select-pane -t 1 \; \
	resize-pane -t 1 -x 85 \; \
	send-keys 'clear' Enter \; \

# Starship
eval "$(starship init zsh)"
