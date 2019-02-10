# locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# editor
export EDITOR=vim

# Go Version Manager
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# fnm
export PATH=$HOME/.fnm:$PATH
[[ -s "$HOME/.fnm/fnm" ]] && eval `fnm env`
