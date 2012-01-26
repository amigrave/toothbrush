;A window's title can contain WinTitle anywhere inside it to be a match.
SetTitleMatchMode, 2

; Map CapsLock to CTRL
Capslock::Control

; Control to Win key
#c::^c
#v::^v
#x::^x
#z::^z
#t::^t
#l::^l
#s::^s
#k::^k
#f::^f
#w::Send ^{F4}
#q::Send !{F4}

; Maximize active windows
!#Up::WinMaximize, A

; Map prev/next tab
!#Left::Send ^{PgUp}
!#Right::Send ^{PgDn}

; Map prev/next window
LWin & Tab::AltTab

; Workaround for ShiftAltTab
; http://www.autohotkey.com/forum/topic56870.html
KeyWait,LShift
Suspend, On
~LWin::Suspend Off
~LWin UP::
KeyWait,LShift
Suspend On
Return
~<+Tab::ShiftAltTab

#+e::Run explorer

; Map editor shortcut
#e::
IfWinExist, GVIM
{
    WinActivate
    return
} else {
    Run C:\Program Files\vim\vim73\gvim.exe
    return
}

; Map Browsers
#F2::
IfWinExist, Google Chrome
{
    WinActivate
    return
} else {
    Run "%HOMEPATH%\Local Settings\Application Data\Google\Chrome\Application\chrome.exe"
    return
}

#F4::
IfWinExist, Google Chrome
{
    WinActivate
    return
} else {
    Run "C:\Program Files\Mozilla Firefox\firefox.exe"
    return
}

