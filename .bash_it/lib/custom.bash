# Homebrew
export PATH="/usr/local/sbin:$PATH"

# GVM
[[ -s "/archie/.gvm/scripts/gvm" ]] && source "/archie/.gvm/scripts/gvm"

# locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# editor
export EDITOR=vim

# fzf
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# There are also _fzf_path_completion and _fzf_dir_completion
complete -F _fzf_file_completion -o default -o bashdefault doge

_fzf_compgen_path() {
  ag -g "" "$1"
}

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

###-begin-nps-completions-###
#
# yargs command completion script
#
# Installation: nps completion >> ~/.bashrc
#    or nps completion >> ~/.bash_profile on OSX.
#
_yargs_completions()
{
    local cur_word args type_list

    cur_word="${COMP_WORDS[COMP_CWORD]}"
    args=("${COMP_WORDS[@]}")

    # ask yargs to generate completions.
    type_list=$(nps --get-yargs-completions "${args[@]}")

    COMPREPLY=( $(compgen -W "${type_list}" -- ${cur_word}) )

    # if no match was found, fall back to filename completion
    if [ ${#COMPREPLY[@]} -eq 0 ]; then
      COMPREPLY=( $(compgen -f -- "${cur_word}" ) )
    fi

    return 0
}
complete -F _yargs_completions nps
###-end-nps-completions-###

# byobu
export BYOBU_PREFIX=/usr/local
