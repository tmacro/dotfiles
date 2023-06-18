function td --description 'Daily scratch directory manager'
    if test (count $argv) -eq 0
        cd (command td show)
        return
    end

    if test (count $argv) -eq 1 && string match --quiet --regex '^\-?\d+' -- "$argv";
        cd (command td show $argv)
        return
    end
    command td $argv    
end
