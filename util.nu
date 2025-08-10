# create a directory and cd into it
def --env newdir [dir_name: string] {
    mkdir $dir_name
    cd $dir_name
}

# create a directory and cd into it using pipe
def --env newdirp []: string -> nothing {
    mkdir $in
    cd $in
}

# compile a .scheme file
def schemec [filepath: string] {
    '(compile-file "' ++ $filepath ++ '")' | scheme -q
}

# activate wifi system
def wifi [--sleep (-s) = 0s : duration] {
    sudo iwctl station list
    sleep $sleep
    sudo dhcpd
}

def bvim [...file_path: string] {
    NVIM_APPNAME=nvim12 bob run nightly $file_path
}

# search pattern inside files in this directory and open the line in nvim
def rgv [ pattern      = ""      : string
          --editor(-e) = neovide : string
        ] {
    let file_line: string = (
          rg --line-number --no-heading --smart-case $pattern
        | fzf --ansi --delimiter :
            --preview 'bat --color=always {1} --highlight-line {2}'
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
        )

    if ($file_line | is-empty) { return }

    let parts: list<string> = ($file_line | split row ":" | take 2)
    let file: string = $parts.0
    let line: string = $parts.1

    if not (($file | is-empty) or ($line | is-empty)) {
        do { ^$editor $"+($line)" $file }
    }
}
