# To disable greeting
set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_user_key_bindings
    bind \t accept-or-complete
end

function accept-or-complete
    # Save current commandline
    set -l before (commandline)

    # Try to accept an autosuggestion
    commandline -f accept-autosuggestion

    # Compare to see if anything changed
    set -l after (commandline)

    if test "$before" = "$after"
        # No autosuggestion was accepted -> do normal completion
	commandline -f complete
    end
end
