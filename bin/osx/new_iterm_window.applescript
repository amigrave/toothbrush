on run argv
    set _command to item 1 of argv
    tell application "iTerm"
        activate
        -- Create a new terminal window...
        set myterm to (make new terminal)
        tell myterm
             launch session "Default Session"
             tell the last session
                write text _command
             end tell
        end tell
    end tell

end run
