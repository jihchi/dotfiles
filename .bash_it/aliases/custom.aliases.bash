# general
alias ls="exa"
alias cdc="cd ~ && clear"
alias rmorig="ag -i -g \"\.orig$\" | xargs -I _ rm -v \"_\""
alias rmswp="ag -i -g \"\.swp$\" | xargs -I _ rm -v \"_\""
# git
alias gdt="git difftool"
alias gdtc="git difftool --cached"
alias gmt="git mergetool"
