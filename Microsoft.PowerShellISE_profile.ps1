if ($Host.Name -eq 'Windows PowerShell ISE Host') {
	#Checks to make sure variables are declared proprerly
	Set-PSDebug -Strict

	#updates the help files
	update-help

	$br = "`r"
	$IPAddress=@(Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.DefaultIpGateway})[0].IPAddress[0]
	$IPGateway=@(Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.DefaultIpGateway})[0].DefaultIPGateway[0]
	
	function Get-Uptime { 
		$os = Get-WmiObject win32_operatingsystem
		$uptime = (Get-Date) - ($os.ConvertToDateTime($os.lastbootuptime))
		$Display = "" + $Uptime.Days + " days, " + $Uptime.Hours + " hours, and " + $Uptime.Minutes + " minutes"
		Write-Output $Display
	}

	Function Start-PSTranscript {
		[string]$date = Get-Date -Format "MMddyyyy"
		$path = "$env:USERPROFILE\Scripts\Transcripts\PSTranscript_" + $date + ".txt"
		#---Not in use yet  Stop-Transcript -ea:silentlycontinue | out-null
		Start-Transcript -Path $path -Append
	}

	$Host.UI.RawUI.Backgroundcolor = "Black"
	$Host.UI.RawUI.Foregroundcolor = "Green"

	#Creates new profile if one doesn't exist already
	if (!(Test-Path $Profile)) {
		New-Item -Type file -Path $Profile -Force 
	}

	#Aliases will be created here.
	New-Alias -Name npp -Value "C:\Program Files (x86)\Notepad++\notepad++.exe"
	
	Start-PSTranscript

	Clear-Host

	# Welcome message
	Write-Host "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" -ForegroundColor Green
	Write-Host "|`tComputerName: " -nonewline -ForegroundColor Green;Write-Host $($env:COMPUTERNAME)"`t" -nonewline -ForegroundColor White;Write-Host "|`tUserName: " -nonewline -ForegroundColor Green;Write-Host $env:UserDomain\$env:UserName"`t" -nonewline -ForegroundColor White
	Write-Host "|`tLogon Server: " -nonewline -ForegroundColor Green;Write-Host $($env:LOGONSERVER)"`t" -nonewline -ForegroundColor White;Write-Host "|`tIP Address: " -nonewline -ForegroundColor Green;Write-Host $IPAddress"`t" -nonewline -ForegroundColor White
	Write-Host "|`tUptime: " -nonewline -ForegroundColor Green;Write-Host $(Get-Uptime)"`t" -nonewline -ForegroundColor White; Write-Host "|" -ForegroundColor Green;
	Write-Host "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" -ForegroundColor Green
	$br
	Write-Host "PowerShell ISE Script has finshed running.  How are you today "$env:Username"?" -ForegroundColor White;
	$br
}
