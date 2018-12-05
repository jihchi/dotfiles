# fasd & fzf change directory - open best matched file using `fasd` if given argument, filter output of `fasd` using `fzf` else
[[ $(type -t v) == "alias" ]] && unalias v
v() {
  [ $# -gt 0 ] && fasd -f -e ${EDITOR} "$*" && return
  local file
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vi "${file}" || return 1
}

# fasd & fzf change directory - jump using `fasd` if given argument, filter output of `fasd` using `fzf` else
[[ $(type -t z) == "alias" ]] && unalias z
z() {
  [ $# -gt 0 ] && fasd_cd -d "$*" && return
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

# https://github.com/dutchcoders/transfer.sh/
transfer() {
    # write to output to tmpfile because of progress bar
    tmpfile=$( mktemp -t transferXXX )
    curl --progress-bar --upload-file $1 https://transfer.sh/$(basename $1) >> $tmpfile;
    cat $tmpfile;
    rm -f $tmpfile;
}

alias transfer=transfer

# https://github.com/lf94/peek-for-tmux
# Run peek a_file_you_really_want_to_look_at.txt
# PS! Make sure you have set export EDITOR=<your editor of choice>, otherwise the split window will just open then close.
peek() { tmux split-window -p 33 "$EDITOR" "$@" || exit; }
