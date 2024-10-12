alias tses='sesh connect "$(sesh list | fzf)"'
alias ls='ls --color'
alias lll='ls -alrt'

bindkey -s '^h' 'tses\n'
bindkey -s '^n' 'nvim .\n'
