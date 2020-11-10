#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance, force

;Show
Gui, 1:Show, w485 h270, Auto Single Fire by xvorost
Gui, 1:submit, nohide
;Crosshair options
Max = 255
a1=BE
a2=00
a3=FF
crosshair1 = 11-11 14-11 14-14 11-14 11-11
activecrosshair := crosshair1
;ASF
Gui, 1:Font, s12 q5 c181818,Arial
Gui, 1:Add, GroupBox, x20 y20 w210 h220, ASF
Gui, 1:Font, s12 q5 c181818,Arial
;Crosshair
Gui, 1:Add, Checkbox,x35 y145 w20 h20 gCheck vXr
Gui, 1:Add, Text, x55 y145, Crosshair
Gui, 1:Add, Slider, x35 y165 w180 h20 gPicker vAA +TooltipBottom Range1-300 tickinterval1-300, 300
;Contacts
Gui, 1:Add, GroupBox, x255 y20 w210 h220, Contacts:
Gui, 1:Add, Link, x265 y55, <a href="https://vk.com/x_vorost">VKontakte</a>
Gui, 1:Add, Link, x265 y75, <a href="https://discord.gg/jv8pWMhzDw">Discord</a>
Gui, 1:Add, Link, x265 y95, <a href="https://github.com/xvorost">GitHub</a>
;Comment
Gui, 1:Add, Text, x65 y245, Z - pause script
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

if(Xr==1)
{
	Gui, xhair:New, +AlwaysOnTop +E0x08000000 -Caption
	Gui, xhair:+Owner
	Gui, xhair:margin,-1,-1
	Gui, xhair:Add,Progress,x-2 y-2 w6 h6 c%a1%%a2%%a3% -border vCrosshair,100
	SysGet, mon, Monitor
	Gui, xhair:Show, % "x" monRight//2 "y" monBottom//2 NA
	WinSet, Region, %activecrosshair%, xhair
	Gui, xhair: +E0x80020
	Gui, xhair:Submit, Nohide
	GoSub Picker
}
Else
{
	Gui, xhair: Destroy
}	
return

;=====================

Picker:
n := Round(max/50,0)
if AA between 1 and 50
{
    a1 := Color(max)
    ab := AA*n
    a2 := Color(ab)
    a3 := Color(0)
}
if AA between 51 and 100
{
    a2 := Color(max)
    ab := (max-AA)*n
    a1 := Color(ab)
    a3 := Color(0)
}
if AA between 101 and 150
{
    a2 := Color(max)
    ab := (AA-100)*n
    a3 := Color(ab)
    a1 := Color(0)
}
if AA between 151 and 200
{
    a3 := Color(max)
    ab := (max-(AA-150))*n
    a2 := Color(ab)
    a1 := Color(0)
}
if AA between 201 and 250
{
    a3 := Color(max)
    ab := (AA-200)*n
    a1 := Color(ab)
    a2 := Color(0)
}
if AA between 251 and 300
{
    a1 := Color(max)
    ab := (max-(AA-250))*n
    a3 := Color(ab)
    a2 := Color(0)
}
loop, 1
{
    GuiControl xhair:+c%a1%%a2%%a3%, Crosshair
}
return
 
Color(N) {
   SetFormat, Integer, Hex 
   N += 0 
   SetFormat, Integer, D 
   StringTrimLeft, N, N, 2 
   If(StrLen(N) < 2) 
      N = 0%N%
   Return N 
}
return 

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