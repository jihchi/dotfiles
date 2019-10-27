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
alias gmt="git mergetool"

alias youtube-dl="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
