alias gotest="fswatch -o . | xargs -n1 -I{} go test ./..."
alias curl_json="curl -H'Content-Type: application/json'"
alias curl_form="curl -H'Content-Type: application/x-www-form-urlencoded'"
alias curl_data="curl -H'Content-Type: multipart/form-data'"
alias dl="aria2c --max-concurrent-downloads=50 --continue=true --max-connection-per-server=16 --min-split-size=10M --split=50"

# npm-quick-run
function __nr() {
  executor="`npm bin -g`/nr"

  if [[ -z "$@" ]]; then
    "$executor" -i
  else
    "$executor" $@
  fi
}

alias nr="__nr"

# general
alias cdc="cd ~ && clear"

# Sublime Text
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# gb
alias gogb="$GOPATH/bin/gb"

# git
alias gdt="git difftool"
alias gdtc="git difftool --cached"
alias gmt="git mergetool"
alias rmorig="ag -i -g \"\.orig$\" | xargs -I _ rm -v \"_\""
alias rmswp="ag -i -g \"\.swp$\" | xargs -I _ rm -v \"_\""
alias gub='git remote update ${GIT_REMOTE:-origin} --prune'
alias gd="git dsf"
alias gfp="git checkout develop && git push && git checkout master && git push && git push --tag"
alias gcom="git checkout master"
alias gcop="git checkout develop"

# silver searcher
alias search="ag --literal --hidden"
alias ff="search --filename-pattern"

