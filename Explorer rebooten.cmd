@echo off
title Explorer-Restart-Tool
PowerShell -Command "$shell = New-Object -ComObject Shell.Application; $explorerWindows = $shell.Windows(); $paths = @(); foreach ($window in $explorerWindows) { $folderPath = $window.Document.Folder.Self.Path; Write-Host 'Geöffnetes Explorer-Fenster:' $folderPath; $paths += $folderPath; } $paths | Out-File %userprofile%\documents\Explorer-Ordner-Instanzen.txt"
cls
echo Explorer neu starten?
pause
taskkill /im explorer.exe /f>NUL
start explorer.exe
echo $FilePath = "$env:userprofile\documents\Explorer-Ordner-Instanzen.txt">%userprofile%\documents\PowerShell-Verarbeitung.ps1
echo Get-Content $FilePath ^| ForEach-Object ^{ "explorer $_" ^} ^| Set-Content "$env:userprofile\documents\Explorer-Ordner-Instanzen-Neu.txt">>%userprofile%\documents\PowerShell-Verarbeitung.ps1
powershell -ExecutionPolicy Bypass -File %userprofile%\documents\PowerShell-Verarbeitung.ps1
copy %userprofile%\documents\Explorer-Ordner-Instanzen-Neu.txt %userprofile%\documents\Explorer-Neuaufruf-Skript.cmd>NUL
echo exit>>%userprofile%\documents\Explorer-Neuaufruf-Skript.cmd
start /min %userprofile%\documents\Explorer-Neuaufruf-Skript.cmd

