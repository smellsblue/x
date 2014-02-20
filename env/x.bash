function x() {
    if [[ -s "$HOME/.x_to_source" ]]
    then
        rm "$HOME/.x_to_source"
    fi

    command x "$@"
    local result=$?

    if [[ -s "$HOME/.x_to_source" ]]
    then
        source "$HOME/.x_to_source"
        rm "$HOME/.x_to_source"
    fi

    if [ $result -ne 0 ]
    then
        false
    fi
}

function _x_complete() {
    COMPREPLY=($(command x bash_completion "${COMP_WORDS[@]}"))
    return 0
}

complete -F _x_complete x
