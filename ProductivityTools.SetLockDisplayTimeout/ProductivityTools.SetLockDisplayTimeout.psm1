<#
	My Function
#>
function Set-LockDisplayTimeout {
	[cmdletbinding()]
	param(
		[int]$Minutes,
		[switch]$Battery,
		[switch]$PluggedIn
	)
	Write-Verbose "Hello from Set-LockDisplayTimeout"
	
	SetEASPolicy  $Minutes
	SetScreenSaverTimeOut  $Minutes
	#DispableScreenSaver

	AddOptionToPowerOptions
	SetLockDisplayTimeout $Minutes $Battery $PluggedIn

	Write-Verbose "Bye, Bye!"
}

function AddOptionToPowerOptions()
{
	Write-Verbose "Adding options to power options"
	$command='powercfg -attributes SUB_VIDEO 8EC4B3A5-6868-48c2-BE75-4F3044BE88A7 -ATTRIB_HIDE'
	#$command='powercfg -attributes SUB_VIDEO 8EC4B3A5-6868-48c2-BE75-4F3044BE88A7 +ATTRIB_HIDE'
	Write-Verbose "Command which will be executed $command"
	Invoke-Expression -Command $command
	Write-Verbose "Options to power options should be added"
}

function SetLockDisplayTimeout()
{

	param(
		[int]$Minutes,
		[switch]$Battery,
		[switch]$PluggedIn
	)

	Write-Verbose "Set LockDisplayTimeout start"

	$seconds=$Minutes*60;
	$batterycommand="powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK " +$seconds
	$pluggedInCommand="powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK "+ $seconds

	if ($Battery.IsPresent)
	{
		Write-Verbose "Battery switch is present"
		Write-Verbose "Invoke expression $batterycommand"
		Invoke-Expression -Command  $batterycommand;
	}

	if ($PluggedIn.IsPresent)
	{
		Write-Verbose "PluggedIn switch is present"
		Write-Verbose "Invoke expression $pluggedInCommand"
		Invoke-Expression -Command $pluggedInCommand;
	}

	if($Battery.IsPresent -eq $false -and $PluggedIn.IsPresent -eq $false)
	{
		Write-Verbose "Battery switch is not present"
		Write-Verbose "Invoke expression $batterycommand"
		Write-Verbose "PluggedIn switch is present"
		Write-Verbose "Invoke expression $pluggedInCommand"

		Invoke-Expression -Command $batterycommand;
		Invoke-Expression -Command $pluggedInCommand;
	}

	Write-Verbose "Set LockDisplayTimeout end"
}

function SetEASPolicy
{

	param(
		[int]$Minutes
	)
	
	$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\EAS\Policies"
	$Name = "7"
	$value = $Minutes*60
	if(Test-Path $registryPath)
	{
		Set-ItemProperty -Path $registryPath -Name $name -Value $value 
	}
	else
	{
		New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD 
	}
}

function GetEASPolicyValue()
{
	$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\EAS\Policies"
	$Name = "7"
	Get-ItemProperty -Path $registryPath -Name $name 
}


function DispableScreenSaver
{
	$registryPath = "HKCU:\Software\Policies\Microsoft\Windows\Control Panel\Desktop"
	$Name = "ScreenSaveActive"
	$value = "0"
	if(Test-Path $registryPath)
	{
		Set-ItemProperty -Path $registryPath -Name $name -Value $value 
	}
	else
	{
		New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType REG_SZ 
	}
}

function CreateNode($path)
{
	if(Test-Path $path)
	{
		Write-Host "Node $registryPath exists"
	}
	else
	{
		$parent=Split-Path -Path $path
		CreateNode $parent
		
		$element=Split-Path -Path $path -Leaf
		New-Item -Path $path -Value $element
	}
}


function SetScreenSaverTimeOut
{

	param(
		[int]$Minutes
	)
	
	
	$registryPath = "HKCU:\Software\Policies\Microsoft\Windows\Control Panel\Desktop"
	CreateNode $registryPath
	
	$Name = "ScreenSaveTimeOut"
	$value = $Minutes*60
	if(Test-Path $registryPath)
	{
		Set-ItemProperty -Path $registryPath -Name $name -Value $value 
	}
	else
	{
		New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType REG_SZ 
	}
}

Export-ModuleMember Set-LockDisplayTimeout 
