cd $PSScriptRoot

Import-Module .\ProductivityTools.PSSetLockDisplayTimeout.psm1 -Force
Set-LockDisplayTimeout -Minutes 1 -Verbose
Write-Host "-------"
Set-LockDisplayTimeout -Minutes 1 -PluggedIn -Verbose
Write-Host "-------"
Set-LockDisplayTimeout -Minutes 1 -Battery -Verbose