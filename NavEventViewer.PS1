<#!
.SYNOPSIS
	Gather information from envet log on Nas Service failures
.DESCRIPTION
	This script will pull Event log info from the Application Log with a Level of Warning and a source of one of the Dynamics Nav Nas Services, including the ErrorCode & the message.
.NOTES
	File Name: tablelocks.ps1
	Author: Mathew Ealy
	Requires Powershell 2.0
.LINK
	https://github.com/MEaly58
#>

#Variables
$Log = "Application"
$Eventype = "Warning"
$EventID = "705"
$OutFile = "C:\Outfile.csv"
#
#
#Import serer list file
$Servers = Import-CSV -path "C:\Serverlist.csv"

foreach ($Server in Servers)
{
$FQDN = $Server.'Server'

Get-EventLog -ComputerName $FQDN -LogName $Log -EventType = $EventType -EventID = $EventID | Sort-Object TimeGenerated | Export-CSV $OutFile

}
