#CSV format
<#!
FullName,Login,Email,Profile, 
You can find the ProfileID in your system on table "Profile Table (2000000072)"
#> 


#Import the NavAdmin Module
Import-Module “${env:ProgramFiles}\Microsoft Dynamics NAV\110\Service\NAVAdminTool.ps1”
#Nav version changes the 110 to a differnt number
#Import the CSV file **Change the -path to the file
$Users = Import-CSV -path "\\server\share\file.csv"
#Variables
$InstanceName = "NavInstance"
#Execute script
foreach ($User in $Users)
{
$FullName = $User.'FullName'
$Login = $User.'Login'
$Email = $User.'Email'
$Profile = $User.'Profile'

New-NavServerUser -ServerInstance $InstanceName -WindowsAccount $Login -FullName "$FullName" -ProfileID "$Profile" 
}
