# General Aliases
alias ls='ls --color'
alias ll='ls -lh'
alias ..='cd ..'
alias ...='cd ../..'
alias :q='exit'
alias n.='nvim .'
alias mvim='NVIM_APPNAME=mini nvim'
alias so='source ~/.zshrc'
alias algrep='alias | rg'
alias untar='tar -zxvf'

# Tree Aliases
alias tree='erd --disk-usage line --icons --layout inverted'
alias treel='erd --long --disk-usage line --icons --time mod --layout inverted'

# System Update Function
sysup() {
	echo "[INFO] Starting system update..."
	local pm_command
	local package_manager

	if command -v pacman &>/dev/null; then
		package_manager="pacman"
		echo "[INFO] Arch Linux distribution detected."
		pm_command="sudo pacman -Syu --noconfirm"
	elif command -v pkg &>/dev/null; then
		package_manager="pkg"
		echo "[INFO] Termux distribution detected."
		pm_command="pkg update && pkg upgrade -y"
	elif command -v apt-get &>/dev/null; then
		package_manager="apt"
		echo "[INFO] Debian/Ubuntu distribution detected."
		pm_command="sudo apt-get update && sudo apt-get upgrade -y"
	elif command -v dnf &>/dev/null; then
		package_manager="dnf"
		echo "[INFO] Fedora/CentOS/RHEL (dnf) distribution detected."
		pm_command="sudo dnf upgrade -y"
	elif command -v yum &>/dev/null; then
		package_manager="yum"
		echo "[INFO] CentOS/RHEL (yum) distribution detected."
		pm_command="sudo yum update -y"
	elif command -v zypper &>/dev/null; then
		package_manager="zypper"
		echo "[INFO] openSUSE distribution detected."
		pm_command="sudo zypper dup --non-interactive"
	else
		echo "[WARN] Unrecognized distribution or unsupported package manager."
		echo "[WARN] Please run the update command manually."
		return 1
	fi

	# Execute the command
	eval "$pm_command" | tee ~/latest-update.log
	local exit_code=${PIPESTATUS[0]}

	if [ $exit_code -eq 0 ]; then
		echo "[INFO] $(date) - System update successful using $package_manager!" | tee -a ~/update.log
	else
		echo "[ERROR] $(date) - System update failed using $package_manager!" | tee -a ~/update.log
		echo "[ERROR] An error occurred during the update. Please check the output above."
		return $exit_code
	fi
}

# Directory Management
newdir() {
	mkdir -p "$1" && cd "$1"
}

# Scheme Compilation
schemec() {
	echo "(compile-file \"$1\")" | scheme -q
}

# WiFi Management
wifi() {
	sudo iwctl station list
	sudo dhcpcd
}

# File & Content Search (requires fzf, ripgrep)
alias fv='fzf | xargs nvim'
alias rgv='rg --line-number --no-heading --smart-case "${1}" | fzf --ansi --delimiter : --preview "bat --color=always {1} --highlight-line {2}" --preview-window "up,60%,border-bottom,+{2}+3/3,~3" | cut -d: -f1,2 | xargs -r nvim +.'

# Network
alias myip='curl ifconfig.me || curl ifconfig.co'
alias ports='sudo netstat -tulpn'

# Process Management
alias psg='ps aux | grep -v grep | grep -i'
killf() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

# File & Content Search (requires fzf, ripgrep)
alias fv='fzf | xargs nvim'
alias rgv='rg --line-number --no-heading --smart-case "${1}" | fzf --ansi --delimiter : --preview "bat --color=always {1} --highlight-line {2}" --preview-window "up,60%,border-bottom,+{2}+3/3,~3" | cut -d: -f1,2 | xargs -r nvim +.'

# Network
alias myip='curl ifconfig.me || curl ifconfig.co'
alias ports='sudo netstat -tulpn'
