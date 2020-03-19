' ***********************************************************************
' * This uses the WSHShell object to create a shortcut
' * that runs on startup.  Its point is to update
' * the "Play ..." shortcuts on the desktop every time we boot, not just
' * once on Win Setup.

Dim WSHShell
Set WSHShell = WScript.CreateObject("WScript.Shell")

Dim MyShortcut, DesktopPath

' Read Start Menu path using WshSpecialFolders object
DesktopPath = WSHShell.SpecialFolders("StartMenu")

' Create a shortcut object on the desktop
Set MyShortcut = WSHShell.CreateShortcut(DesktopPath & "\Programs\StartUp\fixlinks.lnk")
MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("wscript.exe")
MyShortcut.Arguments = "C:\UPD_DESK.VBS"
MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("C:\WINDOWS")
MyShortcut.Save

Set MyShortcut = WSHShell.CreateShortcut(DesktopPath & "\Programs\StartUp\wallpapr.lnk")
MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("paper.exe")
MyShortcut.Arguments = "C:\sci.bmp"
MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("C:\")
MyShortcut.Save
