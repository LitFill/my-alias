alias tses='sesh connect "$(sesh list | fzf)"'
alias ls='ls --color'
alias ll='ls -lh'
alias lll='ls -alrt'

bindkey -s '^h' 'tses\n'
bindkey -s '^n' 'nvim .\n'

# tree
alias tree='erd --disk-usage line --icons --layout inverted'
alias treee='erd --long --disk-usage line --icons --time mod --layout inverted'
alias tree1='tree -L 1'
alias tree2='tree -L 2'

alias sysup='sudo -p "Key for system-upgrade: ***** " \
  zypper dup \
  && echo \
  "\n\t┌─────────────────────────┐\
   \n\t│ System-upgrade success! │\
   \n\t└─────────────────────────┘\n"'

alias :q='exit'

alias n.='nvim .'

alias so='source ~/.zshrc'

alias algrep='alias | rg'

# alias fmths='fourmolu -i --column-limit=80 --function-arrows=leading-args'

alias untar='tar -zxvf'

## create a new directory and move into it immediately
newdir() {
	mkdir -p "$1" && cd "$1"
}

## Log the installed packages via zypper
export LOG_ZYPPER=${LOG_ZYPPER:-./zypper-install-all.sh}

# Ensure log file exists and is initialized
initialize_log_file() {
	if [ ! -f "$LOG_ZYPPER" -o ! -s "$LOG_ZYPPER" ]; then
		echo "Creating or initializing log file: $LOG_ZYPPER"
		echo "#!/usr/bin/env sh" >"$LOG_ZYPPER"
		echo "" >>"$LOG_ZYPPER"
		echo "set -euxo pipefail" >>"$LOG_ZYPPER"
		echo "" >>"$LOG_ZYPPER"
		echo "sudo zypper install \\" >>"$LOG_ZYPPER"
	fi
}

log-zypper() {
	initialize_log_file

	append_to_log() {
		# Append each argument to the log file
		for arg in "$@"; do
			echo -e "\t$arg \\" >>"$LOG_ZYPPER"
		done
	}

	# Run zypper and log installed packages if successful
	if sudo zypper install "$@"; then
		append_to_log "$@"
	else
		echo "Error: Failed to install packages: $@" >&2
	fi
}

alias zy='zypper'
alias _zy='sudo zypper'
alias zyin='log-zypper'
