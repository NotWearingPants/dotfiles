function fish_prompt --description 'Write out the prompt'
    set_color normal
    set -l last_status $status

    # time
    printf '[%s] ' (date +%R)

    # user
    set_color --bold green
    echo -n "$USER"
    set_color normal

    # colon
    echo -n ':'

    # PWD
    set_color --bold yellow # $fish_color_cwd
    #echo -n (prompt_pwd)
    set -l realhome ~
    # TODO: put "..." if it is over a third of the screen width (tput cols)
    echo -n "$PWD" | sed -e "s|^$realhome|~|"
    set_color normal

    # git
    set_color --bold cyan
    echo -n (__fish_git_prompt)
    set_color normal

    # dollar
    if not test $last_status -eq 0
        set_color $fish_color_error
    end
    switch "$USER"
        case root
            echo -n '# '
        case '*'
            echo -n '$ '
    end
    set_color normal
end
