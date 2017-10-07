; Doc reminder {{{
; ============
; # Win (Windows logo key)
; ! Alt
; ^ Control
; + Shift
; &  An ampersand may be used between any two keys or mouse buttons
;    to combine them into a custom hotkey.
;
; }}}

; Globals {{{
; =======
; Use regular expressions to match windows titles when using commands:
;     WinTitle, WinText, ExcludeTitle and ExcludeText
;
; Eg: WinActivate Untitled.*Notepad.
; https://autohotkey.com/docs/commands/SetTitleMatchMode.htm
SetTitleMatchMode, RegEx

; }}}

; Hotkeys {{{

; Map CapsLock to CTRL
Capslock::Control

; Map some WIN+<key> to CTRL+<key> (mac habit)
#c::^c
#v::^v
; #x::^x
; #z::^z
; #t::^t
; #l::^l
; #s::^s
; #k::^k
; #f::^f
#w::Send ^{F4}
#q::Send !{F4}

; Map prev/next tab
!#Left::Send ^{PgUp}
!#Right::Send ^{PgDn}

; Make Win+Tab behave like Alt+Tab
; TODO: find a working solution or make Win and Alt hot swappable

; Win+Alt+t == always on top
; !#t:: Winset, Alwaysontop, , A
; ^SPACE::  Winset, Alwaysontop, , A
!#t::Winset, Alwaysontop, , A

; }}}


; ; Workaround for ShiftAltTab
; ; http://www.autohotkey.com/forum/topic56870.html
; KeyWait,LShift
; Suspend, On
; ~LWin::Suspend Off
; ~LWin UP::
; KeyWait,LShift
; Suspend On
; Return
; ~<+Tab::ShiftAltTab


; vim: set fdm=marker:
