function td --description 'Daily scratch directory manager'
    if test (count $argv) -eq 0
        cd (command today dir show)
        return
    end
    if test (count $argv) -eq 1 && string match --quiet --regex '^\-?\d+' -- "$argv";
        cd (command today dir show $argv)
        return
    end

    command today dir show $argv
end
