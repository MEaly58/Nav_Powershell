#############
#CSV File Format
#Login,PermisionSet,Company,
#############
#Import the NavAdmin Module
Import-Module “${env:ProgramFiles}\Microsoft Dynamics NAV\110\Service\NAVAdminTool.ps1”
#Nav version changes the 110 to a different number
$Users = Import-CSV -path "\\filepath.csv"
$Instance = "DynamicsNAV110"
#Run Script
foreach ($User in $Users)
{
$Login = $User.'Login'
$PermissionSet = $User.'PermissionSet'
$Company = $User.'Company'

New-NAVServerUserPermissionSet -ServerInstance "$Instance" -WindowsAccount "$Login" -PermissionSetId "$PermissionSet" -CompanyName "$Company" -Scope System
}
