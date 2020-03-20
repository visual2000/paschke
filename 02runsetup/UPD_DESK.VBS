Dim WSHShell
Set WSHShell = WScript.CreateObject("WScript.Shell")

Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")
DesktopPath = WSHShell.SpecialFolders("Desktop")

Dim folder, files, folderIdx
Set folder = fso.GetFolder(DesktopPath)
Set files = folder.Files

For Each folderIdx in files
  If InStr(folderIdx, "\Play ") Then
    folderIdx.Delete
  End If
Next

Set folder = fso.GetFolder("C:\games")
Set files = folder.Files

For Each folderIdx in files
  gamename = Left(folderIdx.Name, Len(folderIdx.Name) - 4)
  Set MyShortcut = WSHShell.CreateShortcut(DesktopPath & "\Play " & gamename & ".lnk")
  MyShortcut.TargetPath = WSHShell.ExpandEnvironmentStrings(folderIdx)
  MyShortcut.WorkingDirectory = WSHShell.ExpandEnvironmentStrings("C:\games")
  MyShortcut.Save
Next

' also copy command.PIF...  This fixes the VBEMP COMMAND.COM windowed mode display bug...
fso.CopyFile "C:\fixcmd.PIF", "C:\WINDOWS\command.PIF"
