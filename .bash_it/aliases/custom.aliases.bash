# general
if [ -x "$(command -v exa)" ]; then
  alias ls='exa'
fi

alias cdc="cd ~ && clear"
alias rmorig="ag -i -g \"\.orig$\" | xargs -I _ rm -v \"_\""
alias rmswp="ag -i -g \"\.swp$\" | xargs -I _ rm -v \"_\""

# git
alias gdt="git difftool"
alias gdtc="git difftool --cached"
alias gdc="git diff --cached"
alias gmt="git mergetool"

alias youtube-dl="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
alias dl="aria2c --max-connection-per-server=16 --max-concurrent-downloads=8 --file-allocation=none"

# brew install cliclick
alias brb="while true; do cliclick m:100,100 m:150,150 w:500; done"
