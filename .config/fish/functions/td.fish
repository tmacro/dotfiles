function td --description 'Daily scratch directory manager'
    if test (count $argv) -eq 0
        set target_dir (command td show)
        mkdir -p "$target_dir"
        cd "$target_dir"
        return
    end

    if test (count $argv) -eq 1 && string match --quiet --regex '^\-?\d+' -- "$argv";
        set target_dir (command td show -- $argv)
        mkdir -p "$target_dir"
        cd "$target_dir"
        return
    end
    command td $argv
end
