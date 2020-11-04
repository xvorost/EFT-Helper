#NoEnv
; #Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance, force
;#NoTrayIcon
 
 
;GUI 
;Crosshair
Max = 255
a1=BE
a2=00
a3=FF
crosshair1 = 11-11 14-11 14-14 11-14 11-11
activecrosshair := crosshair1
;Helper
Gui, 1:Font, s12 q5 c181818,Arial
Gui, 1:Add, GroupBox, x20 y20 w210 h180, Helper
Gui, 1:Font, s12 q5 c181818,Arial
;Crosshair
Gui, 1:Add, Checkbox,x35 y55 gCheck vXr, Crosshair
Gui, 1:Add, Slider, x35 y75 w180 h20 gPicker vAA +Tooltip Range1-300, 300
;Automatic Fire
Gui, 1:Add, Checkbox,x35 y110 gCheck vAF, Automatic Fire
Gui, 1:Add, Text, x35 y130, Delay:
Gui, 1:Add, Slider, x35  y150 w180 h20 vAFD +ToolTip Range10-500, 10
;Gui, 1:Add, Text, x35 y170, Randomization:
;Gui, 1:Add, Slider, x35 y190 w180 h20 vAFR +ToolTip Range0-100, 50
;Contacts
Gui, 1:Add, GroupBox, x255 y20 w210 h180, Contacts:
Gui, 1:Add, Text, x265 y55, VKontakte
Gui, 1:submit, nohide
;Show
Gui, 1:Show, w480 h230, EFT Helper by xvorost
Gui, 1:submit, nohide
 
global AA
;global AFR
global AFD
global AF
return
 
Check:
Gui, 1:submit, nohide
 
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
 
~$*LButton::
Gui, 1:submit, nohide
if(AF==1)
{
	AF()
}
return
 
AF() {
	IfWinActive, EscapeFromTarkov
	{
		while(GetKeyState("LButton", "p")) 
		{
			Gui, 1:submit, nohide
;			Random, rndm, 0, %AFR%
			Send, {LButton Down}
			Sleep, %AFD%
			Send, {LButton Up}
			Sleep, %AFD%
		}
	}
}
 
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
 
End::
ExitApp
return
 
GuiClose:
ExitApp
return
