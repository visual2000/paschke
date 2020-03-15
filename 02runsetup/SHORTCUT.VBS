' ***********************************************************************
' * This uses the WSHShell object to create shortcuts
' * on the desktop.

Dim WSHShell
Set WSHShell = WScript.CreateObject("WScript.Shell")

Dim MyShortcut, MyDesktop, DesktopPath

' Read desktop path using WshSpecialFolders object
DesktopPath = WSHShell.SpecialFolders("Desktop")

' Create a shortcut object on the desktop
Set MyShortcut = WSHShell.CreateShortcut(DesktopPath & "\Play 2048.lnk")
MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("C:\2048.exe")
MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("C:\")
MyShortcut.WindowStyle = 4
MyShortcut.IconLocation = WSHShell.ExpandEnvironmentStrings("C:\2048.exe, 0")
MyShortcut.Save

Set MyShortcut = WSHShell.CreateShortcut(DesktopPath & "\Play Conway's Game.lnk")
MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("C:\Conway.exe")
MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("C:\")
MyShortcut.WindowStyle = 4
MyShortcut.IconLocation = WSHShell.ExpandEnvironmentStrings("C:\Conway.exe, 0")
MyShortcut.Save

Set MyShortcut = WSHShell.CreateShortcut(DesktopPath & "\Play DadaCards.lnk")
MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings("C:\DadaCards.exe")
MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("C:\")
MyShortcut.WindowStyle = 3 ' maximized
MyShortcut.IconLocation = WSHShell.ExpandEnvironmentStrings("C:\DadaCards.exe, 0")
MyShortcut.Save

WScript.Echo "Shortcuts to the games are now on the Desktop."
