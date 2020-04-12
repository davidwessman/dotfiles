for function in ~/.zsh/functions/*; do
  source $function
done

export PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%2~%f%b %# '

alias ..='cd ..'
alias gaa='git add -A'
alias gca='git commit --amend'
alias gs='git status'
alias gcm='git checkout master'
alias grm='git rebase master'
alias gba='git branch -a'

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
[[ -f ~/.aliases ]] && source ~/.aliases
