
(*
 	AppleScript to throw a tab back and forth between Safari and Chrome.
	Takes frontmost tab and moves it to the other browser, closing the original.
 	www.nickfyson.co.uk
	http://www.nickfyson.co.uk/2011/06/11/throwing-tabs-between-safari-chrome/
*)

set _currentApp to GetCurrentApp()

if _currentApp is "Safari" then
	
	-- The code for dealing correctly with opening a new Chrome tab comes from comments on this thread...
	-- http://www.tuaw.com/2011/03/14/use-applescript-to-open-current-safari-url-in-google-chrome
	
	tell application "Safari" to set currentURL to URL of current tab of window 1
	tell application "Safari" to close current tab of window 1
	
	tell application "Google Chrome"
		activate
		if (exists window 1) and (URL of active tab of window 1 is "chrome://newtab/") then
			tell window 1 to set URL of active tab to currentURL
		else
			open location currentURL
		end if
	end tell
	
end if


if _currentApp is "Chrome" then
	
	tell application "Google Chrome"
		set currentURL to URL of active tab of first window
		set windowtab to active tab of window 1
		tell windowtab
			delete
		end tell
	end tell
	
	tell application "Safari"
		activate
		open location currentURL
	end tell
	
end if


-- useful function pilfered from a Gruber script...
-- http://daringfireball.net/2009/01/applescripts_targetting_safari_or_webkit
on GetCurrentApp()
	tell application "System Events" to ¬
		get short name of first process whose frontmost is true
end GetCurrentApp

