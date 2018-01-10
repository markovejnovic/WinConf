; Startup script

; Pressing Win-C opens Everything.exe and centers the window.
; If the application is open, then it will restore and center the window.
LWin & c::
If WinExist("ahk_class EVERYTHING") 
{
	; Close the window if it is already open
	IfWinActive
		WinClose
	Else
	{
		; Test if the window is minimized
		WinGet, winState, MinMax
		If (winState = -1)
		{
			WinRestore, ahk_class EVERYTHING
		}
		Else
		{
			; If the window is not visible
			WinGet, Style, Style, ahk_class EVERYTHING
			Transform, Result, BitAnd, %Style%, 0x10000000 ; 0x10000000 is WS_VISIBLE.
			if Result <> 0
			{
				; Set it on top and focus it
				Winset, AlwaysOnTop, On
				Winset, AlwaysOnTop, Off
			}
		}

		WinActivate, ahk_class EVERYTHING
		WinGetPos,,, Width, Height, ahk_class EVERYTHING
		WinMove, ahk_class EVERYTHING,,
			(A_ScreenWidth / 2) - (Width / 2),
			(A_ScreenHeight / 2) - (Height / 2)
		ControlFocus, Edit1
	}
}
Else 
{
	; If the app is not turned on
	run Everything.exe
	WinWait, Everything
	WinActivate, ahk_class Everything
	WinGetPos,,, Width, Height, ahk_class EVERYTHING
	WinMove, ahk_class EVERYTHING,,
		(A_ScreenWidth / 2) - (Width / 2),
		(A_ScreenHeight / 2) - (Height / 2)
	ControlFocus, Edit1
}
Return