#############
#CSV File Format
#Login,PermisionSet,Company,
#############
#Import the NavAdmin Module
Import-Module “${env:ProgramFiles}\Microsoft Dynamics NAV\110\Service\NAVAdminTool.ps1”
#Nav version changes the 110 to a different number
$Users = Import-CSV -path "\\server\share\file.csv"
$Instance = "NavInstance"
#Run Script
forech ($User in $Usres)
{
$Login = $User.'Login'
$PermisionSet = $User.'PermisionSet'
$Company = $User.'Company'

New-NAVServerUserPermissionSet -ServerInstance "$Instance" -WindowsAccount "$Login" -PermissionSetId "$PermisionSet" -CompanyName "$Company" -Scope System
}
