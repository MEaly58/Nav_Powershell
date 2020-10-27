<#!
.SYNOPSIS
	Disable a list of Dyanmics Nav18 users from a CSV file
.DESCRIPTION
	This is a powershell script to be run as Admin from the Nav app tier server to disable users listed in a csv file.  
.NOTES
	File Name: disableUsers.ps1
	Author: Mathew Ealy
	Requires Powershell 5.0
.LINK
	https://github.com/MEaly58
#>
#Import the NavAdmin Module
Import-Module “${env:ProgramFiles}\Microsoft Dynamics NAV\110\Service\NAVAdminTool.ps1”
#Import File
$Users = Import-CSV -path "\\filepath.csv"
$Instance = "DynamicsNAV110"
#Run Script
foreach ($User in $Users)
{
$Login = $User.'Login'
Set-NAVServerUser -ServerInstance $Instance -WindowsAccount "$Login" -State Disabled
}
