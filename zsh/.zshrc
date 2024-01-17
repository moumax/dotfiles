############
## .zshrc ##
############
# by Marco
# ~/.zshrc

ZSH_THEME="marco"

plugins=(
	git
	command-not-found
	zsh-autosuggestions
	zsh-syntax-highlighting
	rust
)

# Add ctrl+space to autocomplete in prompt.
bindkey '^ ' autosuggest-accept

alias c="clear"

# Change directory aliases
alias d="cd $HOME"
alias dev="cd $HOME/dev"
alias dot="cd $HOME/dev/dotfiles"

# List aliases
alias ld="eza -lD"
alias lf="eza -lF --color=always | grep -v /"
alias lh="eza -dl .* --group-directories-first"
alias ll="eza -al --group-directories-first"
alias ls="eza -alF --color=always --sort=size | grep -v /"
alias lt="eza -al --sort=modified"

# Git aliases
alias gs='git status'
alias gaa='git add .'
alias gc='git commit -m'
alias gpo='git pull origin'
alias gp='git push'

# Launch gitui app.
alias laz="lazygit"

# Set VIM as default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

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

# Keyboard speed
xset r rate 250 70
