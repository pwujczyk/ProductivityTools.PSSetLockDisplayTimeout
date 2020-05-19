cd $PSScriptRoot

Import-Module .\ProductivityTools.PSSetLockDisplayTimeout.psm1 -Force
Set-LockDisplayTimeout -Minutes 11 -Verbose