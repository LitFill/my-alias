alias tses='sesh connect "$(sesh list | fzf)"'
alias ls='ls --color'
alias lll='ls -alrt'

bindkey -s '^h' 'tses\n'
bindkey -s '^n' 'nvim .\n'

# tree
alias tree='erd --disk-usage line --icons --layout inverted'
alias treee='erd --long --disk-usage line --icons --time mod --layout inverted'
alias tree1='tree -L 1'
alias tree2='tree -L 2'

alias sysup='sudo -p "Key for system-upgrade: *****" \
  zypper dup \
  && echo \
  "\n\t┌─────────────────────────┐\
   \n\t│ System-upgrade success! │\
   \n\t└─────────────────────────┘\n"'

alias :q='exit'

alias n.='nvim .'

alias so='source ~/.zshrc'

alias algrep='alias | rg'

alias zy='zypper'
alias _zy='sudo zypper'
