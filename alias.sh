# alias tses='sesh connect "$(sesh list | fzf)"'
alias ls='ls --color'
alias ll='ls -lh'
alias lll='ls -alrt'
alias ..='cd ..'
alias ...='cd ../..'

# bindkey -s '^h' 'tses\n'
# bindkey -s '^n' 'nvim .\n'

# tree
alias tree='erd --disk-usage line --icons --layout inverted'
alias treee='erd --long --disk-usage line --icons --time mod --layout inverted'
alias tree1='tree -L 1'
alias tree2='tree -L 2'

function sysup() {
    echo "[INFO] Memulai pembaruan sistem..."
    if command -v pacman &> /dev/null; then
        echo "[INFO] Terdeteksi distribusi Arch Linux."
        sudo pacman -Syu
        package_manager="pacman"
    elif command -v pkg &> /dev/null; then
        echo "[INFO] Terdeteksi distribusi Termux."
        pkg update && pkg upgrade
        package_manager="pkg"
    elif command -v apt-get &> /dev/null; then
        echo "[INFO] Terdeteksi distribusi Debian/Ubuntu."
        sudo apt update && sudo apt upgrade
        package_manager="apt"
    elif command -v dnf &> /dev/null; then
        echo "[INFO] Terdeteksi distribusi Fedora/CentOS/RHEL (dnf)."
        sudo dnf update
        package_manager="dnf"
    elif command -v yum &> /dev/null; then
        echo "[INFO] Terdeteksi distribusi CentOS/RHEL (yum)."
        sudo yum update
        package_manager="yum"
    elif command -v zypper &> /dev/null; then
        echo "[INFO] Terdeteksi distribusi openSUSE."
        sudo zypper dup
        package_manager="zypper"
    else
        echo "[WARN] Distribusi tidak dikenali atau manajer paket tidak didukung."
        echo "[WARN] Silakan jalankan perintah pembaruan secara manual."
        return 1
    fi

    if [ $? -eq 0 ]; then
        echo "[INFO] $(date) - Pembaruan sistem berhasil menggunakan $package_manager!" | tee -a ~/update.log
    else
        echo "[ERROR] $(date) - Pembaruan sistem gagal menggunakan $package_manager!" | tee -a ~/update.log
        echo "[ERROR] Terjadi kesalahan saat pembaruan. Silakan periksa output di atas."
    fi
}

alias :q='exit'

alias n.='nvim .'
alias mvim='NVIM_APPNAME=mini nvim'

alias so='source ~/.zshrc'

alias algrep='alias | rg'

# alias fmths='fourmolu -i --column-limit=80 --function-arrows=leading-args'

alias untar='tar -zxvf'

## create a new directory and move into it immediately
newdir() {
	mkdir -p "$1" && cd "$1" || exit
}

## Log the installed packages via zypper
# export LOG_ZYPPER=${LOG_ZYPPER:-./zypper-install-all.sh}

# Ensure log file exists and is initialized
# initialize_log_file() {
# 	if [ ! -f "$LOG_ZYPPER" ] || [ -s "$LOG_ZYPPER" ]; then
# 		echo "Creating or initializing log file: $LOG_ZYPPER"
# 		echo "#!/usr/bin/env sh" >"$LOG_ZYPPER"
# 		{
# 			echo ""
# 			echo "set -euxo pipefail"
# 			echo ""
# 			echo "sudo zypper install \\"
# 		} >> "$LOG_ZYPPER"
# 	fi
# }

# log-zypper() {
# 	initialize_log_file
#
# 	append_to_log() {
# 		# Append each argument to the log file
# 		for arg in "$@"; do
# 			echo -e "\t$arg \\" >>"$LOG_ZYPPER"
# 		done
# 	}
#
# 	# Run zypper and log installed packages if successful
# 	if sudo zypper install "$@"; then
# 		append_to_log "$@"
# 	else
# 		echo "Error: Failed to install packages: $*" >&2
# 	fi
# }

# alias zy='zypper'
# alias _zy='sudo zypper'
# alias zyin='log-zypper'

# scheme compile
function schemec() {
    echo "(compile-file \"$1\")" | scheme -q
}
