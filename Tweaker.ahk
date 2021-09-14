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
Goto, CheckOS
return

CheckOS:
; Check if the OS version is below 21996, if so display an error and exit if not create the splash screen and GUI
if (A_OSVersion < 10.0.21996)  ; Check if the OS is Windows 10 or earlier
{
    MsgBox, 16, Error, You must run this on Windows 11 build 21996 or later. Your OS is %A_OSVersion%
    ExitApp
}
else ; Continue execution
{
   MsgBox, 48, WARNING, This might not work on future 11 builds.
   FileInstall, splash.png, %A_Temp%\splash.png
   SplashImage, %A_Temp%\splash.png, B
   Sleep, 3000
   SplashImage, Off
   Goto, CreateGUI
   return
}

CreateGUI:
Gui Add, StatusBar,, Version 0.2
Gui Add, Tab3, x-2 y2 w547 h375, Taskbar|Shell|System|About
Gui Tab, 1
Gui Add, GroupBox, x17 y43 w237 h192, Taskbar Size
Gui Add, Button, x29 y71 w115 h23, &Small
Gui Add, Button, x29 y100 w115 h23, &Medium
Gui Add, Button, x29 y132 w115 h23, &Large
Gui Tab, 2
Gui Add, GroupBox, x11 y35 w230 h135, Windows Explorer Tweaks
Gui Add, Button, x20 y59 w110 h23, &Use old explorer
Gui Add, Button, x20 y89 w110 h23, &Restore default
Gui Add, GroupBox, x250 y35 w283 h134, Start Menu Tweaks
Gui Add, Button, x258 y56 w161 h23, &Use Windows 10 start menu
Gui Add, Button, x258 y83 w160 h23, &Restore 11 start menu
Gui Tab, 3
Gui Add, Button, x22 y91 w100 h23, &Enable lock screen
Gui Add, GroupBox, x10 y35 w212 h158, Lock screen
Gui Add, Button, x22 y62 w101 h23, &Disable lock screen
Gui Add, Button, x5 y320 w80 h23, &Sign out
Gui Tab, 4
Gui Font, s20, Segoe UI
Gui Add, Text, x149 y35 w245 h44 +0x200, Windows 11 Tweaks
Gui Font
Gui Font,, Segoe UI
Gui Add, Text, x204 y88 w140 h23 +0x200, Windows 11 Customization
Gui Font
Gui Font,, Segoe UI
Gui Add, Link, x11 y331 w49 h17, <a href="http://66.79.166.110">Website</a>
Gui Font
Gui Font,, Segoe UI
Gui Add, Link, x62 y330 w78 h18, <a href="http://github.com/desktopgooose/windows-11-tweaks">Source Code</a>
Gui Font
Gui Font, s12, Segoe UI
Gui Add, Text, x186 y150 w186 h23 +0x200, Created by Longhorn5048
Gui Font
Gui Font, s9
Gui Add, Text, x237 y109 w120 h23 +0x200, Version 0.2
Gui Font

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

ButtonUseWindows10startmenu:
RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Start_ShowClassicMode, 1
Gui, Destroy
RunWait, taskkill /f /im explorer.exe
RunWait, explorer.exe
MsgBox, 64, Complete, The old start menu has been applied.
Goto, CreateGUI
return

ButtonRestore11startmenu:
RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Start_ShowClassicMode, 0
Gui, Destroy
RunWait, taskkill /f /im explorer.exe
RunWait, explorer.exe
MsgBox, 64, Complete, The Windows 11 start menu has been restored.
Goto, CreateGUI
return

ButtonDisableLockScreen:
RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization, NoLockScreen, 1
Gui, Destroy
MsgBox, 64, Complete, Lock screen disabled. You need to sign out for changes to take effect.
Goto, CreateGUI
return

ButtonEnableLockScreen:
RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization, NoLockScreen, 0
Gui, Destroy
MsgBox, 64, Complete, Lock screen enabled. You need to sign out for changes to take effect.
Goto, CreateGUI
return

ButtonSignout:
Shutdown, 0
return
