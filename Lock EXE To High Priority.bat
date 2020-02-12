::LAUNCHER.CMD
@Echo off
Cls
Pushd %~dp0
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command Start-Process PowerShell -ArgumentList '-File Add.ps1' -Verb RunAs 
Popd