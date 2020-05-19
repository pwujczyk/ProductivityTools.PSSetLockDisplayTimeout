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

	$seconds=$Minutes*60;
	$batterycommand="powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK " +$seconds
	$pluggedInCommand="powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK "+ $seconds

	if ($Battery.IsPresent)
	{
		Invoke-Command -ScriptBlock $batterycommand;
	}

	if ($PluggedIn.IsPresent)
	{
		Invoke-Command -ScriptBlock $pluggedInCommand;
	}

	if($Battery.IsPresent -eq $false -and $PluggedIn.IsPresent -eq $false)
	{
		Invoke-Command -ScriptBlock $batterycommand;
		Invoke-Command -ScriptBlock $pluggedInCommand;
	}
}

function AddOptionToPowerOptions()
{
	$command='powercfg -attributes SUB_SLEEP 7bc4a2f9-d8fc-4469-b07b-33eb785aaca0 -ATTRIB_HIDE'
	Invoke-Command -ScriptBlock $command
}