
function tn --description 'Daily notepad manager'
    argparse --name=tn 'h/help' 'q/quiet' 'd#' 'e/edit' -- $argv
    or return

    if set -q _flag_help
        echo "tn [-h|--help] [-q|--quiet] [-<days>]"
        return 0
    end

    set tn $TN

    if set -q _flag_d
        set -l past_date (command date -d "-$_flag_d days" +'%Y.%m.%d')
        set tn $HOME/notes/$past_date.md
        if test ! -f $tn
            if ! set -q _flag_quiet
                echo "No notes entry for $past_date"
            end
            return 1
        end
    else
        command ln -s -f -T $tn "$TD/NOTES.md"
    end

    mkdir -p (command dirname $tn)
    touch $tn

    if set -q _flag_edit
        command $EDITOR $td
        return
    end

    if ! set -q _flag_quiet
        less $tn
    end
end
