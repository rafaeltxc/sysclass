# Aliases
# Zsh
alias refresh="source ~/.zshrc"

# Work
alias vpn="sudo openvpn --config ~/Documents/Work/vpn.ovpn"

alias cats="sudo /opt/tomcat/bin/startup-debug.sh"
alias catt="sudo /opt/tomcat/bin/shutdown.sh"

# System Defaults
alias sh0="shutdown 0"

alias ls="ls --color=auto"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"

alias gp="grep"
alias cl="clear"

# Custom
alias lg="lazygit"
alias pdf="mupdf"
alias bl="bluetoothctl"
alias spt="ncspot"
alias mx="alsamixer"
alias ai="llama ~/models/Nous-Hermes/Nous-Hermes-2-Mistral-7B-DPO.Q5_K_M.gguf"

# Binds
# Default writing
bindkey '^H'      backward-kill-word
bindkey '^[[H'    beginning-of-line
bindkey '^[[F'    end-of-line
bindkey '^[[3~'   delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Commands
bindkey -s '^o' 'lfcd\n'
bindkey -s '^F' 'fuzzy\n'
bindkey -s '^r' 'rec\n'
bindkey -s '^l' 'ai\n'
bindkey -s '^P' 'sh0\n'
