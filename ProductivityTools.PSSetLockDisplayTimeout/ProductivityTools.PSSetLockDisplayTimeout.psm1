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

	AddOptionToPowerOptions

	$seconds=$Minutes*60;
	$batterycommand="powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK " +$seconds
	$pluggedInCommand="powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK "+ $seconds

	if ($Battery.IsPresent)
	{
		Invoke-Expression -Command  $batterycommand;
	}

	if ($PluggedIn.IsPresent)
	{
		Invoke-Expression -Command $pluggedInCommand;
	}

	if($Battery.IsPresent -eq $false -and $PluggedIn.IsPresent -eq $false)
	{
		Invoke-Expression -Command $batterycommand;
		Invoke-Expression -Command $pluggedInCommand;
	}
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