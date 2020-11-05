#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance, force

;Show
Gui, 1:Show, w485 h170, Auto Single Fire by xvorost
Gui, 1:submit, nohide
;ASF
Gui, 1:Font, s12 q5 c181818,Arial
Gui, 1:Add, GroupBox, x20 y20 w210 h120, ASF
Gui, 1:Font, s12 q5 c181818,Arial
;Contacts
Gui, 1:Add, GroupBox, x255 y20 w210 h120, Contacts:
Gui, 1:Add, Link, x265 y55, <a href="https://vk.com/x_vorost">VKontakte</a>
Gui, 1:Add, Link, x265 y75, <a href="https://discord.gg/jv8pWMhzDw">Discord</a>
Gui, 1:Add, Link, x265 y95, <a href="https://github.com/xvorost">GitHub</a>
;Comment
Gui, 1:Add, Text, x65 y145, Z - pause script
;Automatic Fire
Gui, 1:Add, Text, x35 y50, Automatic Fire Delay:
Gui, 1:Add, Slider, x35  y70 w180 h20 vAFD gSlide Range5-50 tickinterval5-50 AltSubmit
Gui, 1:Add, Text, x40 y90 w50 h18, 5
Gui, 1:Add, Text, x165 y90 w50 h18 Right, 50
Gui, 1:Add, Text, x35 y110, Value:
Gui, 1:Add, Edit, x80 y105 w70 vValue, 5

Gui, Show
return

Slide:
   Gui,Submit,NoHide
    int := afd
    fra := Mod(int, 10)
    val :=  Floor(int)
   
   GuiControl,, Edit1, %val%
return

Check:
Gui, 1:submit, nohide

;=====================

~$*LButton::
Gui, 1:submit, nohide
{
	IfWinActive, EscapeFromTarkov
	{
		while(GetKeyState("LButton", "p")) 
		{
			Gui, 1:submit, nohide
			Send, {LButton Down}
			Sleep, %AFD%
			Send, {LButton Up}
			Sleep, %AFD%
		}
	}
}
return

;=====================

Z:: 
    Suspend
    If A_IsSuspended
        SoundPlay, Deactivated.wav
    Else
        SoundPlay, Activated.wav
return

End::
ExitApp
return
 
GuiClose:
ExitApp
return