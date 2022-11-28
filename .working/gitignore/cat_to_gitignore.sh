#!/bin/sh

_error ()
{
    echo "${@:?Need error message}" 1>&2;
    return 1
}
_ifok ()
{
    local previous_status=$?;
    : "$@:?Need command to run if previous was ok}";
    if [ "$?" -eq 0 ]; then
        "$@";
        return $?;
    else
        _message "previous status $previous_status, skipping command $*";
        return "$previous_status";
    fi
}
_message ()
{
    echo "${@:?Need message}" 1>&2
}
cat_to_gitignore ()
{
    : "${@:?Need files to add}";
    : "${date:=`date +%Y-%m-%d`}";
    : "${repo?Need base URL of source repo or empty string}";
    : "${gitignore_file:=gitignore}";
    : "${gitignore_yaml:=$gitignore_file.yaml}";
    case "$repo" in
        http:* | https:* | ssh:* | *:*)

        ;;
        "")

        ;;
        *)
            repo="https://$repo"
        ;;
    esac;
    for file in "$@";
    do
        if [ -n "$repo" ]; then
            location="$file from $repo";
        else
            location="$file";
        fi;
        _message "processing $location...";
        {
            if [ -s "$gitignore_file" ]; then
                echo;
                echo;
            fi;
            echo "### === Begin $location === ###";
            echo "### From file: $file";
            echo "###      date: $date";
            if [ -n "$repo" ]; then
                echo "###      repo: $repo";
            fi;
            cat "$file";
            echo "### === End $location === ###"
        } >> "$gitignore_file";
        {
            echo "  - file: $file";
            if [ -n "$repo" ]; then
                echo "    repo: $repo";
            fi
        } >> "$gitignore_yaml";
    done
}

if [ -n "$*" ]; then
    cat_to_gitignore "$@"
fi
