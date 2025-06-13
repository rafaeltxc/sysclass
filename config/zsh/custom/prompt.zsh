# Prompt Config
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS='--color=bg+:-1,bg:-1,border:#FFFFFF,spinner:#81A1C1,hl:#81A1C1,fg:#FFFFFF,header:#81A1C1,info:#FFFFFF,pointer:#81A1C1,marker:#81A1C1,fg+:-1,preview-bg:-1,prompt:#FFFFFF,hl+:#81A1C1,gutter:-1'

autoload -U colors && colors
PS1=' %B%F{blue}$(batt)% %F{white}- %F{white}$(date +"%a %d/%m - %H:%M") %F{blue}|%f%B%F{white}%(4~|...|) %3~%F{white}$(branch=$(git_branch_name) && [ -n "$branch" ] && echo " %F{white}${white}$branch${white}") %F{blue}> %b%f%k'
setopt prompt_subst
