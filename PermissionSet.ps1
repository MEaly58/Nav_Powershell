#Proof of concept for importing Nav permissions sets
#Import Dynamics Nav modules (The numeric field changes by version)
Import-Module "${env:ProgramFiles}\Microsoft Dynamics NAV\90\Service\NavAdminTool.ps1"
#Varaibles
$InstanceName = "Nav Instance Name"
$File = "Path to csv file" 
#Import CSV file to bring in users and permissions sets for those users.
$Permissions  = Import-CSV -path $File
#Build Users Part of the scritp
#CSV file format is SetID,User 
foreach ($Permission in $Permissions)
{
$ID = $Permission.'SetID'
$User = $Permission.'User'

New-NAVServerUserPermissionSet $InstanceName -WindowsAccount $User -PermissionSetID $ID
}
