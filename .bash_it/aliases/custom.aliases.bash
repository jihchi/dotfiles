alias watch="fswatch -o . | xargs -n1 -I%"
alias dl="aria2c --max-concurrent-downloads=50 --continue=true --max-connection-per-server=16 --min-split-size=10M --split=50"

# general
alias cdc="cd ~ && clear"
alias rmorig="ag -i -g \"\.orig$\" | xargs -I _ rm -v \"_\""
alias rmswp="ag -i -g \"\.swp$\" | xargs -I _ rm -v \"_\""

# Sublime Text
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# git
alias gdt="git difftool"
alias gdtc="git difftool --cached"
alias gmt="git mergetool"

