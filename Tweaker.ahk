; Windows 11 Tweaks source code
#SingleInstance Off
#NoEnv
#NoTrayIcon
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Goto, AdminCheck

AdminCheck:
if %A_IsAdmin% = 0
{
MsgBox, 16, Error, You must run this program as an administrator.
ExitApp
}
else
Goto, CreateGUI
return

CreateGUI:
Gui Add, Tab3, x-2 y2 w547 h375, Taskbar|Shell|About
Gui Tab, 1
Gui Add, GroupBox, x17 y43 w237 h192, Taskbar Size
Gui Add, Button, x29 y71 w115 h23, &Small
Gui Add, Button, x29 y100 w115 h23, &Medium
Gui Add, Button, x29 y132 w115 h23, &Large
Gui Tab, 2
Gui Add, GroupBox, x11 y35 w230 h135, Windows Explorer Tweaks
Gui Add, Button, x20 y59 w110 h23, &Use old explorer
Gui Add, Button, x20 y89 w110 h23, &Restore default
Gui Tab, 3
Gui Font, s20, Segoe UI
Gui Add, Text, x149 y35 w245 h44 +0x200, Windows 11 Tweaks
Gui Font
Gui Font,, Segoe UI
Gui Add, Text, x204 y88 w140 h23 +0x200, Windows 11 Customization
Gui Font
Gui Font,, Segoe UI
Gui Add, Link, x17 y344 w49 h17, <a href="http://66.79.166.110">Website</a>
Gui Font
Gui Font,, Segoe UI
Gui Add, Link, x65 y344 w78 h18, <a href="http://github.com/desktopgooose/windows-11-tweaks">Source Code</a>
Gui Font
Gui Font, s12, Segoe UI
Gui Add, Text, x186 y150 w186 h23 +0x200, Created by Longhorn5048
Gui Font
Gui Font, s9
Gui Add, Text, x237 y109 w120 h23 +0x200, Version 0.1
Gui Font
Gui Tab

Gui Show, w542 h373, Windows 11 Tweaks
Return

GuiEscape:
GuiClose:
    ExitApp

ButtonSmall:
RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, TaskbarSi, 0
Gui, Destroy
RunWait, taskkill /f /im explorer.exe
RunWait, explorer.exe
MsgBox, 64, Complete, The taskbar has been set to small.
Goto, CreateGUI
return

ButtonMedium:
RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, TaskbarSi, 1
Gui, Destroy
RunWait, taskkill /f /im explorer.exe
RunWait, explorer.exe
MsgBox, 64, Complete, The taskbar has been set to the default which is medium.
Goto, CreateGUI
return

ButtonLarge:
RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, TaskbarSi, 2
Gui, Destroy
RunWait, taskkill /f /im explorer.exe
RunWait, explorer.exe
MsgBox, 64, Complete, The taskbar has been set to Large.
Goto, CreateGUI
return

ButtonUseoldexplorer:
RegWrite, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked
RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked, {e2bf9676-5f8f-435c-97eb-11607a5bedf7}
Gui, Destroy
RunWait, taskkill /f /im explorer.exe
RunWait, explorer.exe
MsgBox, 64, Complete, The old explorer has been applied.
Goto, CreateGUI
return

ButtonRestoredefault:
RegDelete, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked, {e2bf9676-5f8f-435c-97eb-11607a5bedf7}
Gui, Destroy
RunWait, taskkill /f /im explorer.exe
RunWait, explorer.exe
MsgBox, 64, Complete, The default explorer has been restored.
Goto, CreateGUI
return