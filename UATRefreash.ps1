<#!
.SYNOPSIS
	Refresh UAT enviroment wiht Powershell
.DESCRIPTION
	This powershell function is used to automate a large portion of the UAT proccess from a production server to a UAT system.
.EXAMPLE
  TBD
.INPUTS
  Sample INPUTS
.OUTPUTS
  Expected OUTPUTS
.COMPONENT
  Componets of cmdlet
.NOTES
	File Name: UATRefreash.ps1
	Author: Mathew Ealy
	Requires Powershell 5.0
.LINK
	https://github.com/MEaly58
#>

#Backup Prod SQL DB
Set-Lcoation "SQLProd:\SQL\ProdServer\Instance"
Backup-SqlDatabase -Database "ProdDB" -BackupFile "\\mainserver\databasebackup\ProdDB.bak"

#Restore Prod DB into UAT
Set-Lcoation "SQLUAT:\SQL\UATServer\Instance"
Restore-SqlDatabase -Database "UATDB" -BackupFile "\\mainserver\databasebackup\MainDB.bak"
